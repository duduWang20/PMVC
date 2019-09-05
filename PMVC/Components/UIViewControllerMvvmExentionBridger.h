//
//  UIViewControllerMvvmExentionBridger.h
//  MvBox
//
//  Created by jufan wang on 2019/6/28.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VVNodDataView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewControllerMvvmExentionBridger : NSObject
@property (nonatomic, strong) VVNodDataView *noDataView;
@property (nonatomic, copy) void(^checkActionBlock)(void);
@property (nonatomic, copy) void(^mvvmImagePickerBlock)(NSString *imagePath);

@end

NS_ASSUME_NONNULL_END
