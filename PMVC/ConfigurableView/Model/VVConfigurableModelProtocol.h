//
//  VVConfigurableModelProtocol.h
//  MvBox
//
//  Created by jufan wang on 2019/8/30.
//  Copyright © 2019 mvbox. All rights reserved.
//

#ifndef VVConfigurableModelProtocol_h
#define VVConfigurableModelProtocol_h

#import <Foundation/Foundation.h>


@protocol VVConfigurableModelProtocol <NSObject>

@property (nonatomic, weak) Class mvvmPresentationClass;
@property (nonatomic, assign) CGFloat mvvmPresentationHeight;

@end


#endif /* VVConfigurableModelProtocol_h */

