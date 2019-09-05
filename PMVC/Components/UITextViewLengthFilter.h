//
//  UITextViewLengthFilter.h
//  MvBox
//
//  Created by jufan wang on 2019/5/28.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface UITextViewLengthFilter : NSObject<UITextViewDelegate>

@property (nonatomic, weak) UITextView * mvvmTextView;


@property (nonatomic, copy) NSString * mvvmText;

@property (nonatomic, assign) NSInteger maxLengh;
@property (nonatomic, assign) NSInteger minLengh;

@property (nonatomic, strong) id<UITextViewDelegate> mvvmNextDeletate;

@end


NS_ASSUME_NONNULL_END
