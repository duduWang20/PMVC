//
//  UITextView(MVVM).m
//  MvBox
//
//  Created by jufan wang on 2019/5/28.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "UITextView(MVVM).h"

#import <objc/runtime.h>



@interface UITextViewMVVMBridger : NSObject
@property (nonatomic, strong) id<UITextViewDelegate> mvvmDeletateHead;
@property (nonatomic, strong) id<UITextViewDelegate> mvvmDeletateTail;
@end
@implementation UITextViewMVVMBridger
@end



@implementation UITextView(MVVM)
 

- (UITextViewMVVMBridger *)mvvmTextViewBridger {
    UITextViewMVVMBridger * bridger = objc_getAssociatedObject(self, @selector(mvvmTextViewBridger));;
    if (!bridger) {
        bridger = [UITextViewMVVMBridger new];
        objc_setAssociatedObject(self, @selector(mvvmTextViewBridger), bridger, OBJC_ASSOCIATION_RETAIN);
    }
    return bridger;
}

- (id<UITextViewDelegate>)mvvmDeletateHead {
    return [self mvvmTextViewBridger].mvvmDeletateHead;
}

- (id<UITextViewDelegate>)mvvmDeletateTail {
    return [self mvvmTextViewBridger].mvvmDeletateTail;
}
    
- (void)setMvvmDeletateHead:(id<UITextViewDelegate>)mvvmDeletateHead {
    [self mvvmTextViewBridger].mvvmDeletateHead = mvvmDeletateHead;
}

- (void)setMvvmDeletateTail:(id<UITextViewDelegate>)mvvmDeletateTail {
    [self mvvmTextViewBridger].mvvmDeletateTail = mvvmDeletateTail;
}


@end
