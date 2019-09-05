//
//  VVPureEmotionsInputView.h
//  MvBox
//
//  Created by jufan wang on 2019/5/31.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol VVPureEmotionsInputViewProtocol <NSObject>

@property (nonatomic, copy) NSString * text;

@end


NS_ASSUME_NONNULL_BEGIN

@interface VVPureEmotionsInputView : UIView

@property (nonatomic, weak) UIView<VVPureEmotionsInputViewProtocol> * inputView;
@property (nonatomic, assign) NSInteger maxLength;

- (CGFloat)heigth;

@end

NS_ASSUME_NONNULL_END
