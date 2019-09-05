//
//  UIButton+VVTouch.h
//  MvBox
//
//  Created by jufan wang on 2019/5/23.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIButtonEventZoneType) {
    UIButtonEventZoneType_Center,
    UIButtonEventZoneType_TopLeft,
    UIButtonEventZoneType_TopRigth,
    UIButtonEventZoneType_BottonLeft,
    UIButtonEventZoneType_BottonRight
};
NS_ASSUME_NONNULL_BEGIN

@interface UIButton(VVTouch)

@property (nonatomic, assign) UIButtonEventZoneType eventZoneType;

@end

NS_ASSUME_NONNULL_END
