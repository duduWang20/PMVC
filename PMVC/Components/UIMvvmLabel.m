//
//  UIMvvmLabel.m
//  MvBox
//
//  Created by jufan wang on 2019/6/27.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "UIMvvmLabel.h"

@implementation UIMvvmLabel

//-(CGSize)intrinsicContentSize{
//    CGSize originalSize = [super intrinsicContentSize];
//    CGFloat fontSize = [self.font pointSize];
//    CGFloat delt = 0;
//    if (fontSize >= 10 && fontSize <= 18) {
//        delt = 2.5 + (fontSize - 10) * 2.0 / 8.0;
//    }
//    CGSize size = CGSizeMake(originalSize.width, originalSize.height-delt);
//    return size;
//}

-(CGSize)intrinsicContentSize{
    
    CGSize originalSize = [super intrinsicContentSize];
    if (self.numberOfLines == 1) {
        return CGSizeMake(originalSize.width, originalSize.height - (self.font.ascender - self.font.capHeight) + self.font.descender);
    }
    return originalSize;
}

@end
