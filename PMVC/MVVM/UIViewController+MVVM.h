//
//  UIViewController+MVVM.h
//  MvBox
//
//  Created by jufan wang on 2019/5/22.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerMVVMEventBindingProtocol <NSObject>

@optional


- (void)mvvmCollectionViewCellWillAppear:(UICollectionViewCell *)cell;

- (void)mvvmViewWillAppear:(UIView *)view;

- (void)mvvmViewControllerWillAppear:(UIViewController *)viewController;

- (void)mvvmViewTouchingEnd:(UIView *)view;
- (void)mvvmViewTouchingBegin:(UIView *)view;


#pragma mark -- table view

- (void)mvvmDidSelectModel:(id)model withView:(UIView *)view;
- (void)mvvmDidSelectModel:(id)model withView:(UIView *)view atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView mvvmDeleteCellAtIndexPath:(NSIndexPath *)indexPath;


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)mvvmTableViewCellWillAppear:(UITableViewCell *)cell;
- (void)tableView:(UITableView *)tableView cellWillAppear:(UITableViewCell *)cell;


@end


NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(MVVM)<UIViewControllerMVVMEventBindingProtocol>

@end

NS_ASSUME_NONNULL_END

