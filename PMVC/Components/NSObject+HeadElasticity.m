//
//  NSObject+HeadElasticity.m
//  MvBox
//
//  Created by jufan wang on 2019/5/25.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "NSObject+HeadElasticity.h"
#import <objc/runtime.h>
#import "UIMvvmKeyboardManager.h"

#import "UIMvvmScrollView.h"

@interface VVScrollViewHeadElasticityMVVMBridger : NSObject
@property (nonatomic, assign) BOOL enableHeaderElasticity;
@property (nonatomic, weak) UIView * headerView;
@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat offsetY2Screen;
@property (nonatomic, assign) CGFloat originOffset;
@end
@implementation VVScrollViewHeadElasticityMVVMBridger
@end


@implementation NSObject(HeadElasticity)

- (void)enalbeHeaderElasticity:(BOOL)enable
                withHeaderView:(nonnull UIView *)headerView
                 withTableView:(nonnull UITableView *)tableView
               andHeaderHeight:(CGFloat)headerHeight {
    self.headerView = headerView;
    self.tableView = tableView;
    self.headerHeight = headerHeight;
    self.enableHeaderElasticity = enable;
}

- (VVScrollViewHeadElasticityMVVMBridger *)mvvmScrollViewHeadElasticityBridger {
    VVScrollViewHeadElasticityMVVMBridger * bridger = objc_getAssociatedObject(self, @selector(mvvmScrollViewHeadElasticityBridger));;
    if (!bridger) {
        bridger = [VVScrollViewHeadElasticityMVVMBridger new];
        objc_setAssociatedObject(self, @selector(mvvmScrollViewHeadElasticityBridger), bridger, OBJC_ASSOCIATION_RETAIN);
    }
    return bridger;
}

- (void)setEnableHeaderElasticity:(BOOL)enableHeaderElasticity {
    self.mvvmScrollViewHeadElasticityBridger.enableHeaderElasticity = enableHeaderElasticity;
    if (enableHeaderElasticity) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.headerView.frame = CGRectMake(0, 0, self.headerWidth, self.headerHeight);
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.headerWidth, self.headerHeight)];
        [self.tableView.superview insertSubview:self.headerView aboveSubview:self.tableView];
        self.mvvmScrollViewHeadElasticityBridger.originOffset = MAXFLOAT;
    }else {
//        [UIView animateWithDuration:.25 animations:^{
            [self.headerView removeFromSuperview];
            self.tableView.tableHeaderView = nil;
//        }];
    }
}
- (BOOL)enableHeaderElasticity {
    return self.mvvmScrollViewHeadElasticityBridger.enableHeaderElasticity;
}

- (void)setHeaderView:(UIView *)headerView {
    headerView.contentMode = UIViewContentModeScaleToFill;
    self.mvvmScrollViewHeadElasticityBridger.headerView = headerView;
}
- (UIView *)headerView {
    return self.mvvmScrollViewHeadElasticityBridger.headerView;
}


- (void)setHeaderHeight:(CGFloat)headerHeight {
    self.mvvmScrollViewHeadElasticityBridger.headerHeight = headerHeight;
}
- (CGFloat)headerHeight {
    return self.mvvmScrollViewHeadElasticityBridger.headerHeight;
}
- (CGFloat)headerWidth {
    return self.mvvmScrollViewHeadElasticityBridger.tableView.superview.bounds.size.width;
}

- (void)setTableView:(UITableView *)tableView {
    self.mvvmScrollViewHeadElasticityBridger.tableView = tableView;
}
- (UITableView *)tableView {
    return self.mvvmScrollViewHeadElasticityBridger.tableView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITextView class]]
        && ![scrollView isKindOfClass:[UIMvvmScrollView class]]) {
//        [[UIMvvmKeyboardManager sharedInstance] stopInput];
    }
    
    if (self.mvvmScrollViewHeadElasticityBridger.enableHeaderElasticity) {
//        [UIView animateWithDuration:.25 animations:^{
            CGFloat offsetY = scrollView.contentOffset.y;//-20 normal & -44 for x status bar
            if (self.mvvmScrollViewHeadElasticityBridger.originOffset == MAXFLOAT) {
                self.mvvmScrollViewHeadElasticityBridger.originOffset = offsetY;
            }
            
            CGFloat height = self.headerHeight;
            if (offsetY <= 0) {
                height -= offsetY;
                self.headerView.frame = CGRectMake(0, 0, self.headerWidth, height);
            }else {
                self.headerView.frame = CGRectMake(0, -offsetY, self.headerWidth, height);
            }
            //    内容视图相对于tableView在X、Y轴方向的偏移。
            //     向上、向左 滚动 contentOffset.y 大于0
            [self willChangeValueForKey:@"offsetY2Screen"];
            self.mvvmScrollViewHeadElasticityBridger.offsetY2Screen = self.headerHeight +  self.mvvmScrollViewHeadElasticityBridger.originOffset - offsetY;
            [self didChangeValueForKey:@"offsetY2Screen"];
//        }];
    }
}

-(void)mvvmScrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITextView class]]
        && ![scrollView isKindOfClass:[UIMvvmScrollView class]]) {
//        [[UIMvvmKeyboardManager sharedInstance] stopInput];
    }
    
    if (self.mvvmScrollViewHeadElasticityBridger.enableHeaderElasticity) {
        //        [UIView animateWithDuration:.25 animations:^{
        CGFloat offsetY = scrollView.contentOffset.y;//-20 normal & -44 for x status bar
        if (self.mvvmScrollViewHeadElasticityBridger.originOffset == MAXFLOAT) {
            self.mvvmScrollViewHeadElasticityBridger.originOffset = offsetY;
        }
        
        CGFloat height = self.headerHeight;
        if (offsetY <= 0) {
            height -= offsetY;
            self.headerView.frame = CGRectMake(0, 0, self.headerWidth, height);
        }else {
            self.headerView.frame = CGRectMake(0, -offsetY, self.headerWidth, height);
        }
        //    内容视图相对于tableView在X、Y轴方向的偏移。
        //     向上、向左 滚动 contentOffset.y 大于0
        [self willChangeValueForKey:@"offsetY2Screen"];
        self.mvvmScrollViewHeadElasticityBridger.offsetY2Screen = self.headerHeight - 2 *self.mvvmScrollViewHeadElasticityBridger.originOffset - offsetY;
        [self didChangeValueForKey:@"offsetY2Screen"];
        //        }];
    }
}

- (CGFloat)offsetY2Screen {
    return self.mvvmScrollViewHeadElasticityBridger.offsetY2Screen;
}

@end


