//
//  UIMVVMKeyboardManager.m
//  MvBox
//
//  Created by jufan wang on 2019/5/29.
//  Copyright © 2019 mvbox. All rights reserved.
//

#
#import "UIMvvmKeyboardManager.h"
#import "UIView+MVVM.h"


@interface UIMvvmKeyboardManager()

@property (nonatomic, weak) UIView * inputView;
@property (nonatomic, strong) NSValue *value;
@property (nonatomic, copy) NSString *name;//UIKeyboardDidShowNotification

@end


@implementation UIMvvmKeyboardManager


+ (instancetype)sharedInstance {
    static UIMvvmKeyboardManager * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [UIMvvmKeyboardManager new];
    });
    return _sharedInstance;
}

- (void)inputViewResignFirstResponder:(UIView *)inputView {
    if (self.inputView == inputView) {
        self.inputView = nil;
        [UIView animateWithDuration:.25 animations:^{
            UIViewController * controller = inputView.mvvmViewController;
            CGRect frame = controller.view.frame;
            controller.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        }];
    }
}

- (void)inputViewBecameFirstResponder:(UIView *)inputView {
    self.inputView = inputView;
    [self keyboardInputAdjustment];
}

- (void)setInputView:(UIView *)inputView {
    if (_inputView != inputView) {
        _inputView = inputView;
        if (_inputView) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardDidShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
        }else {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
        }
    }
}

- (void)keyboardAction:(NSNotification*)sender{
    if (self.inputView) {
        NSDictionary *useInfo = [sender userInfo];
        self.value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        self.name = sender.name;
        [self keyboardInputAdjustment];
    }
}

- (UIScrollView *)scrollView {
    UIResponder * next = self.inputView;
    while (next) {
        if ([next isKindOfClass:[VVPreloadTableView class]]) {
            break;
        }
        next = next.nextResponder;
    }
    return (UIScrollView *)next;
}

- (void)keyboardInputAdjustment {
    if (self.name && self.inputView) {
        CGRect keyBoardFrame = [self.value CGRectValue];
        if (keyBoardFrame.size.height == 0) {
            return;
        }
        UIViewController * controller = self.inputView.mvvmViewController;
        CGRect inputViewFrame = [self.inputView convertRect:self.inputView.frame toView:nil];
        CGFloat delt = [UIScreen mainScreen].bounds.size.height - keyBoardFrame.size.height;
        CGRect controllerViewFrame = controller.view.frame;
        
        [self emotionsEnd];
        
        CGFloat y = controllerViewFrame.origin.y + delt / 2 - inputViewFrame.origin.y;
        if (y < 0) {
            [UIView animateWithDuration:.25 animations:^{
                controller.view.frame = CGRectMake(0, y , controllerViewFrame.size.width, controllerViewFrame.size.height);
            }];
        }
    }
}

- (void)inputViewFinishedInputing {
    self.value = nil;
    self.name = nil;
    if (self.inputView) {
        [UIView animateWithDuration:.25 animations:^{
            UIViewController * controller = self.inputView.mvvmViewController;
            CGRect frame = controller.view.frame;
            controller.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            [self.inputView resignFirstResponder];
        }];
        self.inputView = nil;
    }
}


#pragma mark -- emotion view

- (void)emotionsStart:(UIView *)inputView {
    self.inputView = inputView;
    
    [CATransaction begin];
    [[UIApplication sharedApplication].keyWindow addSubview:self.pureEmotionsInputView];
    self.pureEmotionsInputView.hidden = NO;
    [self.pureEmotionsInputView setNeedsDisplay];
    [CATransaction commit];
    
    CGRect keyBoardFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216);
    UIViewController * controller = inputView.mvvmViewController;
    CGRect inputViewFrame = [inputView convertRect:inputView.frame toView:nil];
    CGFloat delt = [UIScreen mainScreen].bounds.size.height - keyBoardFrame.size.height;
    CGRect controllerViewFrame = controller.view.frame;
    
    CGFloat y = controllerViewFrame.origin.y + delt / 2 - inputViewFrame.origin.y;
    if (y < 0) {
        [UIView animateWithDuration:.25 animations:^{
            controller.view.frame = CGRectMake(0, y , controllerViewFrame.size.width, controllerViewFrame.size.height);
        }];
    }
}

- (void)emotionsEnd {
    [UIView animateWithDuration:.25 animations:^{
        [self.pureEmotionsInputView removeFromSuperview];
        UIViewController * controller = self.inputView.mvvmViewController;
        CGRect frame = controller.view.frame;
        controller.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }];
}

- (VVPureEmotionsInputView *)pureEmotionsInputView {
    if (!_pureEmotionsInputView) {
        CGRect frame = [UIScreen mainScreen].bounds;
        _pureEmotionsInputView = [[VVPureEmotionsInputView alloc] initWithFrame:CGRectMake(0, frame.size.height - 216, frame.size.width, 216)];
    }
    return _pureEmotionsInputView;
}

- (void)stopInput {
    [self inputViewFinishedInputing];
    [self emotionsEnd];
    self.value = nil;
    self.name = nil;
}

@end

