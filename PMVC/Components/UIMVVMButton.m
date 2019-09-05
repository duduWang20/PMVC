//
//  UIMVVMButton.m
//  MvBox
//
//  Created by jufan wang on 2019/5/27.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "UIMVVMButton.h"
#import "UIButton+VVTouch.h"

@implementation UIMVVMButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    
//    CGFloat width = bounds.size.width;
//    CGFloat height = bounds.size.height;
    
    switch (self.eventZoneType) {
//        case UIButtonEventZoneType_TopLeft:
//            break;
//        case UIButtonEventZoneType_TopRigth:
//
//            widthDelta = widthDelta>0?widthDelta:0;
//            heightDelta = heightDelta>0?heightDelta:0;
//            width +=  widthDelta;
//            height += heightDelta;
//            CGFloat y = bounds.origin.y;
//            bounds = CGRectMake(bounds.origin.x, y - heightDelta, width, height);
//            break;
//        case UIButtonEventZoneType_BottonLeft:
//
//            break;
//        case UIButtonEventZoneType_BottonRight:
//
//            break;
        default:
            bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
            break;
    }
    return CGRectContainsPoint(bounds, point);
}

@end
