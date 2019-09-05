//
//  UITextViewLengthFilter.m
//  MvBox
//
//  Created by jufan wang on 2019/5/28.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "UITextViewLengthFilter.h"
#import "UIView+MVVM.h"
#import "UIMvvmKeyboardManager.h"

#import <ReactiveCocoa/ReactiveCocoa.h>


@interface UITextViewLengthFilter()

@end


@implementation UITextViewLengthFilter

- (instancetype)init {
    if ([super init]) {
       
    }
    return self;
}

- (void)setMvvmTextView:(UITextView *)mvvmTextView {
    _mvvmTextView = mvvmTextView;
    _mvvmTextView.layoutManager.allowsNonContiguousLayout= NO;
    @weakify(self);
    [RACObserve(self.mvvmTextView, text)  subscribeNext:^(id x) {
        @strongify(self);
        [self textViewDidChange:self.mvvmTextView];
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [[UIMvvmKeyboardManager sharedInstance] inputViewBecameFirstResponder:textView];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    NSLog(@"wjf location = %d, length = %d , %@", range.location, range.length, text);
    BOOL result = YES;
    _mvvmText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = self.maxLengh - _mvvmText.length;
    _mvvmText = textView.text;
    
    if (caninputlen < 0 && text.length){
        NSInteger len = text.length + caninputlen;
        NSRange rg = {0,MAX(len,0)};
        if (rg.length > 0 && range.length == text.length){
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        result = NO;
    }
    if (result && self.mvvmNextDeletate) {
        result = [self.mvvmNextDeletate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return result;
}

- (void)textViewDidChange:(UITextView *)textView{
    if ([self.mvvmText isEqualToString:textView.text]) {
        return;
    }
    [self.mvvmTextView willChangeValueForKey:@"text"];
    
    if (self.mvvmText.length >= self.maxLengh && textView.text.length > self.mvvmText.length) {
        textView.text = self.mvvmText;
    }
    self.mvvmText = textView.text;
    if (self.maxLengh < self.mvvmText.length) {
        self.mvvmText = [self.mvvmText substringToIndex:self.maxLengh];
    }
    if (self.mvvmNextDeletate) {
        [self.mvvmNextDeletate textViewDidChange:textView];
    }
    [self.mvvmTextView didChangeValueForKey:@"text"];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [[UIMvvmKeyboardManager sharedInstance] inputViewResignFirstResponder:textView];
    return YES;
}

-(NSString*)deleteKeyOperation:(NSString*)text{
    NSMutableString *allString = [NSMutableString stringWithString:text];
    NSString *searchString = @"[";
    NSString *searchString2 = @"]";
    
    if (allString.length == 0)
        return allString;
    
    NSString *lastString = [allString substringFromIndex:allString.length - 1];
    NSRange range1;
    NSRange range2;
    NSRange deleteRange;
    if (![lastString isEqual:searchString2])
    {
        if (allString.length == 1) {
            deleteRange = [allString rangeOfString:lastString options:NSBackwardsSearch];
        }else{
            NSString *str = [allString substringFromIndex:allString.length-1];
            BOOL val = [NSString stringContainsEmoji:str];
            if (val) {
                deleteRange = [allString rangeOfString:str options:NSBackwardsSearch];
            }else{
                str = [allString substringFromIndex:allString.length-2];
                val = [NSString stringContainsEmoji:str];
                if (val) {
                    //长度为2的emoji表情
                    deleteRange = [allString rangeOfString:str options:NSBackwardsSearch];
                }else
                    //长度为1的emoji表情
                    deleteRange = [allString rangeOfString:lastString options:NSBackwardsSearch];
            }
        }
        
    }else
    {
        range1 = [allString rangeOfString:searchString options:NSBackwardsSearch] ;
        range2 = [allString rangeOfString:searchString2 options:NSBackwardsSearch];
        
        if (range1.length == 0 && range2.length == 0)
        {
            return [allString substringToIndex:allString.length-1];
        }
        
        deleteRange = NSMakeRange(range1.location, range2.location - range1.location + 1);
    }
    
    [allString deleteCharactersInRange:deleteRange];
    return allString;
}


@end

