//
//  UITableView+MVVM.m
//  MvBox
//
//  Created by jufan wang on 2019/5/24.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "UITableView+MVVM.h"
#import <objc/runtime.h>

#import "UIViewController+MVVM.h"
#import "UIView+MVVM.h"


@implementation UITableView(MVVM)

+ (void)load {
    Method fromMethod = class_getInstanceMethod([self class], @selector(dequeueReusableCellWithIdentifier:));
    Method toMethod = class_getInstanceMethod([self class], @selector(sw_dequeueReusableCellWithIdentifier:));
    method_exchangeImplementations(fromMethod, toMethod);
    
    fromMethod = class_getInstanceMethod([self class], @selector(dequeueReusableCellWithIdentifier:forIndexPath:));
    toMethod = class_getInstanceMethod([self class], @selector(sw_dequeueReusableCellWithIdentifier:forIndexPath:));
    method_exchangeImplementations(fromMethod, toMethod);
    
    fromMethod = class_getInstanceMethod([self class], @selector(dequeueReusableHeaderFooterViewWithIdentifier:));
    toMethod = class_getInstanceMethod([self class], @selector(sw_dequeueReusableHeaderFooterViewWithIdentifier:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (UITableViewCell *)sw_dequeueReusableCellWithIdentifier:(NSString *)identifier {
    UITableViewCell * cell = [self sw_dequeueReusableCellWithIdentifier:identifier];
    if ([self.mvvmViewController respondsToSelector:@selector(mvvmTableViewCellWillAppear:)]) {
        [self.mvvmViewController mvvmTableViewCellWillAppear:cell];
    }
    return cell;
}

- (UITableViewCell *)sw_dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [self sw_dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if ([self.mvvmViewController respondsToSelector:@selector(mvvmTableViewCellWillAppear:)]) {
        [self.mvvmViewController mvvmTableViewCellWillAppear:cell];
    }
    return cell;
}
- (UITableViewHeaderFooterView *)sw_dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier {
    UITableViewHeaderFooterView * view = [self sw_dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if ([self.mvvmViewController respondsToSelector:@selector(mvvmViewWillAppear:)]) {
        [self.mvvmViewController mvvmViewWillAppear:view];
    }
    return view;
}

@end
