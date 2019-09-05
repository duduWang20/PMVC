//
//  NSObject+HeadElasticity.h
//  MvBox
//
//  Created by jufan wang on 2019/5/25.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 This object is a delegate of UIScrollView , that should implementatin crollViewDidScroll:
 
 */

NS_ASSUME_NONNULL_BEGIN

//call super scrollViewDidScroll: when override in child

@interface NSObject(HeadElasticity)<UIScrollViewDelegate>

//pre-conditions
@property (nonatomic, weak, readonly) UIView * headerView;
@property (nonatomic, weak, readonly) UITableView * tableView;
@property (nonatomic, assign, readonly) CGFloat headerHeight;

//enable and disable point
@property (nonatomic, assign) BOOL enableHeaderElasticity;

//easy for upfront
- (void)enalbeHeaderElasticity:(BOOL)enable
                withHeaderView:(nonnull UIView *)headerView
                withTableView:(nonnull UITableView *)tableView
               andHeaderHeight:(CGFloat)headerHeight;

-(void)mvvmScrollViewDidScroll:(UIScrollView *)scrollView;

//output
@property (nonatomic, assign, readonly) CGFloat headerWidth;
@property (nonatomic, assign, readonly) CGFloat offsetY2Screen;

@end


NS_ASSUME_NONNULL_END

