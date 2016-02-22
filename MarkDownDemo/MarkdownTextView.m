//
//  MarkdownTextView.m
//  MarkDownDemo
//
//  Created by xiatianhan on 16/2/17.
//  Copyright © 2016年 NatsuDawn. All rights reserved.
//

#import "MarkdownTextView.h"



@implementation MarkdownTextView

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if ([self.menuDelegate respondsToSelector:@selector(shouldBlockMenu)] && [self.menuDelegate shouldBlockMenu]) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
    
}


@end
