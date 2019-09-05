//
//  UITextView(MVVM).h
//  MvBox
//
//  Created by jufan wang on 2019/5/28.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UITextView(MVVM)

@property (nonatomic, strong) id<UITextViewDelegate> mvvmDeletateHead;
@property (nonatomic, strong) id<UITextViewDelegate> mvvmDeletateTail;

@end

NS_ASSUME_NONNULL_END
