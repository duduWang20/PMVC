//
//  UICollectionView+MVVM.m
//  MvBox
//
//  Created by jufan wang on 2019/5/27.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "UICollectionView+MVVM.h"
#import <objc/runtime.h>

#import "UIViewController+MVVM.h"
#import "UIView+MVVM.h"

@implementation UICollectionView(MVVM)

+ (void)load {
    Method fromMethod = class_getInstanceMethod([self class], @selector(dequeueReusableCellWithReuseIdentifier:forIndexPath:));
    Method toMethod = class_getInstanceMethod([self class], @selector(sw_dequeueReusableCellWithReuseIdentifier:forIndexPath:));
    method_exchangeImplementations(fromMethod, toMethod);

    fromMethod = class_getInstanceMethod([self class], @selector(dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:));
    toMethod = class_getInstanceMethod([self class], @selector(sw_dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (UICollectionViewCell *)sw_dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [self sw_dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if ([self.mvvmViewController respondsToSelector:@selector(mvvmCollectionViewCellWillAppear:)]) {
        [self.mvvmViewController mvvmCollectionViewCellWillAppear:cell];
    }
    return cell;
}

//- (UICollectionReusableView *)sw_dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView * cell = [self sw_dequeueReusableSupplementaryViewOfKind:identifier withReuseIdentifier:identifier forIndexPath:indexPath];
//    if ([self.mvvmViewController respondsToSelector:@selector(mvvmViewWillAppear:)]) {
//        [self.mvvmViewController mvvmViewWillAppear:cell];
//        //UIKBCandidateCollectionView
//        //UIKeyboardCandidateBarLayout
//    }
//    return cell;
//}

@end

