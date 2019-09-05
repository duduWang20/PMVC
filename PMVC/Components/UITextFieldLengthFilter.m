//
//  UITextFieldLengthFilter.m
//  MvBox
//
//  Created by jufan wang on 2019/5/28.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "UITextFieldLengthFilter.h"
#import "UIView+MVVM.h"

#import "UIMvvmKeyboardManager.h"


@interface UITextFieldLengthFilter()
//@property (nonatomic, copy) NSString * inputString;
@end


@implementation UITextFieldLengthFilter

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setMvvmTextField:(UITextField *)mvvmTextField {
    _mvvmTextField = mvvmTextField;
    [_mvvmTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [[UIMvvmKeyboardManager sharedInstance] inputViewBecameFirstResponder:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text {
//    NSLog(@"wjf location = %d, length = %d , %@,length = %d", range.location, range.length, text, text.length);
    BOOL result = YES;
    _mvvmText = [textField.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = self.maxLengh - _mvvmText.length;
    _mvvmText = textField.text;
    if (caninputlen < 0 && text.length){
        NSInteger len = text.length + caninputlen;
        NSRange rg = {0,MAX(len,0)};
        if (rg.length > 0 && range.length == text.length){
            NSString *s = [text substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        result = NO;
    }
    if (result && self.mvvmNextDeletate) {
        result = [self.mvvmNextDeletate textField:textField shouldChangeCharactersInRange:range replacementString:text];
    }
    return result;
}

- (void)textFieldDidChange:(UITextField *)textField{
    if ([self.mvvmText isEqualToString:textField.text]) {
        return;
    }
    [self.mvvmTextField willChangeValueForKey:@"text"];
    if (self.mvvmText.length >= self.maxLengh && textField.text.length > self.mvvmText.length) {
        textField.text = self.mvvmText;
    }
    self.mvvmText = textField.text;
    if (self.maxLengh < self.mvvmText.length) {
        self.mvvmText = [self.mvvmText substringToIndex:self.maxLengh];
    }
    if ([self.mvvmNextDeletate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.mvvmNextDeletate performSelector:@selector(textViewDidChange:) withObject:textField];
    }
    [self.mvvmTextField didChangeValueForKey:@"text"];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.mvvmText = textField.text;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.mvvmText = textField.text;
    [[UIMvvmKeyboardManager sharedInstance] inputViewResignFirstResponder:textField];
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

