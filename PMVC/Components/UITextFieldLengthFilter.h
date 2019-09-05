//
//  UITextFieldLengthFilter.h
//  MvBox
//
//  Created by jufan wang on 2019/5/28.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

//add an list header

@interface UITextFieldLengthFilter : NSObject<UITextFieldDelegate>

@property (nonatomic, copy) NSString * mvvmText;

@property (nonatomic, assign) NSInteger maxLengh;
@property (nonatomic, assign) NSInteger minLengh;
@property (nonatomic, weak) UITextField * mvvmTextField;

@property (nonatomic, strong) id<UITextFieldDelegate> mvvmNextDeletate;

@end

NS_ASSUME_NONNULL_END
