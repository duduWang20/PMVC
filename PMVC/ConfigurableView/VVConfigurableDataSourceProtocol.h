//
//  VVConfigurableDataSourceProtocol.h
//  MvBox
//
//  Created by jufan wang on 2019/8/30.
//  Copyright © 2019 mvbox. All rights reserved.
//

#ifndef VVConfigurableDataSourceProtocol_h
#define VVConfigurableDataSourceProtocol_h


@protocol VVConfigurableDataSourceProtocol <NSObject>

@optional
- (void)mvvmLoadRefreshData;
- (void)mvvmLoadAppendData;

@end


#endif /* VVConfigurableDataSourceProtocol_h */
