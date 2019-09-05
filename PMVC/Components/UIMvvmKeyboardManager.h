//
//  UIMVVMKeyboardManager.h
//  MvBox
//
//  Created by jufan wang on 2019/5/29.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "VVPureEmotionsInputView.h"


NS_ASSUME_NONNULL_BEGIN

@interface UIMvvmKeyboardManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak, readonly) UIView * inputView;
@property (nonatomic, strong) VVPureEmotionsInputView *pureEmotionsInputView;


- (void)keyboardAction:(NSNotification*)sender;

- (void)inputViewResignFirstResponder:(UIView *)inputView;
- (void)inputViewBecameFirstResponder:(UIView *)inputView;
- (void)inputViewFinishedInputing;

- (void)emotionsStart:(UIView *)inputView;
- (void)emotionsEnd;

- (void)stopInput;

@end

NS_ASSUME_NONNULL_END
