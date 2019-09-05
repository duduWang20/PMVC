//
//  UIView+MVVM.h
//  MvBox
//
//  Created by jufan wang on 2019/5/22.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(MVVM)

@property (nonatomic, weak) UINavigationController * mvvmNavigationController;
@property (nonatomic, assign) BOOL mvvmHasBind;
@property (nonatomic, weak, readonly) UIViewController * mvvmViewController;



@end

NS_ASSUME_NONNULL_END
