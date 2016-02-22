//
//  MarkdownTextView.h
//  MarkDownDemo
//
//  Created by xiatianhan on 16/2/17.
//  Copyright © 2016年 NatsuDawn. All rights reserved.
//

#import <YYText/YYText.h>
@protocol MarkdownTextViewMenuDelegate <NSObject>

-(BOOL)shouldBlockMenu;

@end

@interface MarkdownTextView : YYTextView

@property (nonatomic,weak) id<MarkdownTextViewMenuDelegate> menuDelegate;

@end
