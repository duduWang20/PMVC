//
//  UIButton+VVTouch.m
//  MvBox
//
//  Created by jufan wang on 2019/5/23.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "UIButton+VVTouch.h"
#import <objc/runtime.h>


@interface UIButtonMVVMBridger : NSObject
@property (nonatomic, assign) UIButtonEventZoneType eventZoneType;
@end
@implementation UIButtonMVVMBridger
@end


@implementation UIButton(VVTouch)

- (UIButtonMVVMBridger *)mvvmButtonMVVMBridger {
    UIButtonMVVMBridger * bridger = objc_getAssociatedObject(self, @selector(mvvmButtonMVVMBridger));;
    if (!bridger) {
        bridger = [UIButtonMVVMBridger new];
        objc_setAssociatedObject(self, @selector(mvvmButtonMVVMBridger), bridger, OBJC_ASSOCIATION_RETAIN);
    }
    return bridger;
}

- (void)setEventZoneType:(UIButtonEventZoneType)eventZoneType {
    self.mvvmButtonMVVMBridger.eventZoneType = eventZoneType;
}

- (UIButtonEventZoneType)eventZoneType {
    return self.mvvmButtonMVVMBridger.eventZoneType;
}

@end

