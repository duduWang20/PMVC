//
//  UIView+MVVM.m
//  MvBox
//
//  Created by jufan wang on 2019/5/22.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "UIView+MVVM.h"

#import <objc/runtime.h>


@interface UIViewMVVMBridger : NSObject
@property (nonatomic, weak) UINavigationController * mvvmNavigationController;
@property (nonatomic, weak) UIViewController * mvvmViewController;
@end
@implementation UIViewMVVMBridger
@end


@implementation UIView(MVVM)

+ (void)load {
    for (NSString *method in @[@"setNeedsLayout", @"setNeedsDisplay", @"setNeedsDisplayInRect"]) {
        Method fromMethod = class_getInstanceMethod([self class], NSSelectorFromString(method));
        NSString * nmethod = [NSString stringWithFormat:@"sw_%@", method];
        Method toMethod = class_getInstanceMethod([self class], NSSelectorFromString(nmethod));
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

- (BOOL)checkMainThread {
    if ([NSThread isMainThread]) {
        return YES;
    }
    return NO;
}

- (void)sw_setNeedsLayout {
    if ([self checkMainThread]) {
        [self sw_setNeedsLayout];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sw_setNeedsLayout];
        });
    }
}

- (void)sw_setNeedsDisplay {
    if ([self checkMainThread]) {
        [self sw_setNeedsDisplay];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sw_setNeedsDisplay];
        });
    }
}

- (void)sw_setNeedsDisplayInRect {
    if ([self checkMainThread]) {
        [self sw_setNeedsDisplayInRect];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sw_setNeedsDisplayInRect];
        });
    }
}

- (void)setMvvmHasBind:(BOOL)mvvmHasBind {
    objc_setAssociatedObject(self, @selector(mvvmHasBind), @(mvvmHasBind), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)mvvmHasBind {
    NSNumber * bridger = objc_getAssociatedObject(self, @selector(mvvmHasBind));;
    return [bridger boolValue];
}

- (void)setMvvmNavigationController:(UINavigationController *)mvvmNavigationController {
    [self mvvmExtentionBridger].mvvmNavigationController = mvvmNavigationController;
}

- (UINavigationController *)mvvmNavigationController {
    UINavigationController * _navigationController = [self mvvmExtentionBridger].mvvmNavigationController;
    if (!_navigationController) {
        UINavigationController * nav = nil;
        UIResponder * next = self.nextResponder;
        while (nav == nil && next) {
            if ([next isKindOfClass:[UINavigationController class]]) {
                nav = (UINavigationController *)next;
                break;
            }
            next = [next nextResponder];
        }
        _navigationController = nav;
        [self setMvvmNavigationController:_navigationController];
    }
    return _navigationController;
}


- (UIViewController *)mvvmViewController {
    UIViewController * _viewController = [self mvvmExtentionBridger].mvvmViewController;
    if (_viewController == nil) {
        UIResponder * next = self.nextResponder;
        while (_viewController == nil && next) {
            if ([next isKindOfClass:[UIViewController class]]) {
                _viewController = (UIViewController *)next;
                break;
            }
            next = [next nextResponder];
        }
        self.mvvmViewController = _viewController;
    }
    return _viewController;
}

- (void)setMvvmViewController:(UIViewController * _Nullable)mvvmViewController {
    [self mvvmExtentionBridger].mvvmViewController = mvvmViewController;
}


- (UIViewMVVMBridger *)mvvmExtentionBridger {
    UIViewMVVMBridger * bridger = objc_getAssociatedObject(self, @selector(mvvmNavigationController));;
    if (!bridger) {
        bridger = [UIViewMVVMBridger new];
        objc_setAssociatedObject(self, @selector(mvvmNavigationController), bridger, OBJC_ASSOCIATION_RETAIN);
    }
    return bridger;
}


@end
