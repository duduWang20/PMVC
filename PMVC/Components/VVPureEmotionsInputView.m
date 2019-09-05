//
//  VVPureEmotionsInputView.m
//  MvBox
//
//  Created by jufan wang on 2019/5/31.
//  Copyright © 2019 mvbox. All rights reserved.
//

#import "VVPureEmotionsInputView.h"


#import "FaceScrollView.h"
#import "EmojiKeyBoardView.h"
#import "UIMvvmKeyboardManager.h"

#import <PureLayout/PureLayout.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface VVPureEmotionsInputView()<EmojiKeyboardViewDelegate>

@property (nonatomic, strong) FaceScrollView *faceView;
@property (nonatomic, strong) EmojiKeyBoardView *emojiKeyBoard;

@end


@implementation VVPureEmotionsInputView

//-- 切换到emoji表情
- (void)exchangEmoji:(UIButton *)button {
    UIView *footView = [button superview];
    //qq表情按钮
    UIButton *button2 = (UIButton *)[footView viewWithTag:100];
    button.backgroundColor = UIColorFromRGB(0xCCCCCC);
    button2.backgroundColor = UIColorFromRGB(0xEEEEEE);
    [_faceView removeFromSuperview];
    [self addSubview:_emojiKeyBoard];
}

- (void)exchangQQ:(UIButton *)button {//-- 切换到qq表情
    UIView *footView = [button superview];
    //emoji表情按钮
    UIButton *button2 = (UIButton *)[footView viewWithTag:101];
    button.backgroundColor = UIColorFromRGB(0xCCCCCC);
    button2.backgroundColor = UIColorFromRGB(0xEEEEEE);
    [self.emojiKeyBoard removeFromSuperview];
    [self addSubview:_faceView];
}

- (CGFloat)heigth {
    return 216;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        // line 1
        UIView *view_line_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 180, kScreenWidth, 0.5)];
        view_line_1.backgroundColor = UIColorFromRGB(0xE1E1E1);
        [self addSubview:view_line_1];
        // line 2
        UIView *view_line_2 = [[UIView alloc] initWithFrame:CGRectMake(129 / 320.0f * kScreenWidth, 180, 0.5, 36)];
        view_line_2.backgroundColor = UIColorFromRGB(0xE1E1E1);
        [self addSubview:view_line_2];
        // line 3
        UIView *view_line_3 = [[UIView alloc] initWithFrame:CGRectMake(2 * 129 / 320.0f * kScreenWidth, 180, 0.5, 36)];
        view_line_3.backgroundColor = UIColorFromRGB(0xE1E1E1);
        [self addSubview:view_line_3];
        
        //0, 216, 129, 30
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, view_line_1.bottom, view_line_2.left, 36)];
        button1.contentMode = UIViewContentModeCenter;
        [button1 setImage:[UIImage imageNamed:@"chat_input_emoji_btn_left"] forState:UIControlStateNormal];
        button1.tag = 100;
        [button1 addTarget:self action:@selector(exchangQQ:) forControlEvents:UIControlEventTouchUpInside];
        button1.backgroundColor = UIColorFromRGB(0xCCCCCC);
        [self addSubview:button1];
        
        //129, 216, 129, 30
        UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(view_line_2.right, view_line_1.bottom , view_line_3.left - view_line_2.right, 36)];
        button2.contentMode = UIViewContentModeCenter;
        [button2 setImage:[UIImage imageNamed:@"chat_input_emoji_btn_right"] forState:UIControlStateNormal];
        button2.tag = 101;
        [button2 addTarget:self action:@selector(exchangEmoji:) forControlEvents:UIControlEventTouchUpInside];
        button2.backgroundColor = UIColorFromRGB(0xEEEEEE);
        [self addSubview:button2];
        
        UIButton *button_send = [[UIButton alloc]initWithFrame:CGRectMake(view_line_3.right, view_line_1.bottom, kScreenWidth - view_line_3.right, 36)];
        [button_send setTitle:@"退出" forState:UIControlStateNormal];
        button_send.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [button_send setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        button_send.backgroundColor = UIColorFromRGB(0xEEEEEE);
        [button_send addTarget:self action:@selector(sentFaceButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button_send];
        
        self.faceView = [[FaceScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];

        [self addSubview:self.faceView];

        [RACObserve(self.faceView, faceView.selectFaceName) subscribeNext:^(id x) {
                            NSString * value = x;
            NSLog(@"%@", value);
            if ([value isEqualToString:@"[删除]"]) {
                if([value isEqual:@"[删除]"])
                {
                    NSMutableString *allString = [NSMutableString stringWithString:self.inputView.text];
                    NSString *searchString = @"[";
                    NSString *searchString2 = @"]";
                    if (allString.length == 0)
                        return;
                    
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
                            return;
                        
                        deleteRange = NSMakeRange(range1.location, range2.location - range1.location + 1);
                    }
                    
                    [allString deleteCharactersInRange:deleteRange];
                    self.inputView.text = allString;
                   
                }
            }else {
                [self increaseOne:value];
            }
        }];
        
        //
        self.emojiKeyBoard = [[EmojiKeyBoardView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, EmojiKeyBoard_Height)];
        self.emojiKeyBoard.delegate = self;
        
//        NSDictionary *useInfo = [sender userInfo];UIKeyboardDidShowNotification
//        self.value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//        self.name = sender.name;
    }
    return self;
}


- (void)sentFaceButtonAction {
    [[UIMvvmKeyboardManager sharedInstance] emotionsEnd];
}

#pragma mark -- EmojiKeyBoardView

/**
 Delegate method called when user taps an emoji button
 @param emojiKeyBoardView EmojiKeyBoardView object on which user has tapped.
 @param emoji Emoji used by user
 */
- (void)emojiKeyBoardView:(EmojiKeyBoardView *)emojiKeyBoardView didUseEmoji:(NSString *)emoji {
    [self increaseOne:emoji];
}

/**
 Delegate method called when user taps on the backspace button
 @param emojiKeyBoardView EmojiKeyBoardView object on which user has tapped.
 */
- (void)emojiKeyBoardViewDidPressBackSpace:(EmojiKeyBoardView *)emojiKeyBoardView {
    self.inputView.text = [self deleteKeyOperation:self.inputView.text];
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

- (void)increaseOne:(NSString *)one {
    if (self.inputView.text.length < self.maxLength) {
        self.inputView.text = [self.inputView.text stringByAppendingString:one];
        UITextView * view = (UITextView * )self.inputView;
        if ([view respondsToSelector:@selector(scrollRangeToVisible:)]) {
            [view scrollRangeToVisible:NSMakeRange(view.text.length, 1)];
        }
    }
}


@end


