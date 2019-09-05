//
//  VVConfigurablePresentationProtocol.h
//  MvBox
//
//  Created by jufan wang on 2019/9/3.
//  Copyright © 2019 mvbox. All rights reserved.
//

#ifndef VVConfigurablePresentationProtocol_h
#define VVConfigurablePresentationProtocol_h


#import "VVConfigurableModelProtocol.h"

@protocol VVConfigurablePresentationProtocol <NSObject>

@property (nonatomic, weak) id<VVConfigurableModelProtocol> mvvmModel;

@end


#endif /* VVConfigurablePresentationProtocol_h */
