//
//  ViewController.m
//  MarkdownDemo
//
//  Created by xiatianhan on 16/2/15.
//  Copyright © 2016年 NatsuDawn. All rights reserved.
//

#import "ViewController.h"
#import "YYTextView.h"
#import "YYTextLayout.h"
#import "MarkdownTextView.h"
#import "TBCMarkdownEditManager.h"
#import <objc/runtime.h>

@interface ViewController () <YYTextViewDelegate>
@property (nonatomic, strong) MarkdownTextView *mdView;
@property (nonatomic, strong) NSString *test;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, assign) BOOL blockMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    MarkdownTextView *mdView = [MarkdownTextView new];
    mdView.menuDelegate = self;
    NSString *text = @"#Markdown Editor\nThis is a simple markdown editor based on `YYTextView`.\n\n*********************************************\nIt\'s *italic* style.\n\nIt\'s also _italic_ style.\n\nIt\'s **bold** style.\n\nIt\'s ***italic and bold*** style.\n\nIt\'s __underline__ style.\n\nIt\'s ~~deleteline~~ style.\n\n\nHere is a link: [YYKit](https://github.com/ibireme/YYKit)\n\nHere is some code:\n\n\tif(a){\n\t\tif(b){\n\t\t\tif(c){\n\t\t\t\tprintf(\"haha\");\n\t\t\t}\n\t\t}\n\t}\n";
    mdView.text = text;
    mdView.font = [UIFont systemFontOfSize:14];
    //    mdView.textParser = parser;
    mdView.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, self.view.frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height);
    mdView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    mdView.delegate = self;
    mdView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mdView.scrollIndicatorInsets = mdView.contentInset;
    mdView.selectedRange = NSMakeRange(text.length, 0);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mdView];
    self.mdView = mdView;
    
    self.toolBar= [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.toolBar.barStyle = UIBarStyleDefault;
    self.toolBar.items = [NSArray arrayWithObjects:
                          [[UIBarButtonItem alloc]initWithTitle:@"撤销" style:UIBarButtonItemStyleBordered target:self action:@selector(unDo:event:)],
                           [[UIBarButtonItem alloc]initWithTitle:@"重做" style:UIBarButtonItemStyleBordered target:self action:@selector(reDo)],
                          [[UIBarButtonItem alloc]initWithTitle:@"字体" style:UIBarButtonItemStyleBordered target:self action:@selector(showFontMenu:event:)],
//                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(showInsertMenu)],
                           nil];
    [self.toolBar sizeToFit];
    self.mdView.inputAccessoryView = self.toolBar;
}

- (void)unDo:(UIBarButtonItem*)sender event:(UIEvent*)event {
}

- (void)reDo {
    
}

- (void)H1:(UIBarButtonItem*)sender event:(UIEvent*)event {
    NSString *selected = [[self.mdView text]
                          substringWithRange:[self.mdView selectedRange]];
    NSLog(@"%@", selected);
}

- (void)H2:(UIBarButtonItem*)sender{
    NSString *selected = [[self.mdView text]
                          substringWithRange:[self.mdView selectedRange]];
    NSLog(@"%@", selected);
}

- (void)H3:(UIBarButtonItem*)sender{
    NSString *selected = [[self.mdView text]
                          substringWithRange:[self.mdView selectedRange]];
    NSLog(@"%@", selected);
}


- (void)showFontMenu:(UIBarButtonItem*)sender event:(UIEvent*)event  {
    
    UIMenuItem *H1 = [[UIMenuItem alloc] initWithTitle:@"H1"action:@selector(H1:event:)];
    UIMenuItem *H2 = [[UIMenuItem alloc] initWithTitle:@"H2"action:@selector(H2:)];
    UIMenuItem *H3 = [[UIMenuItem alloc] initWithTitle:@"H3"action:@selector(H3:)];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    menuController.menuItems = @[
                       H1, H2, H3
                       ];
    _blockMenu = true;
    [self becomeFirstResponder];
    [menuController setMenuVisible:YES animated:YES];
    
    UIView *buttonView=[[event.allTouches anyObject] view];
    CGRect buttonFrame=[buttonView convertRect:buttonView.frame toView:self.view];
    [menuController setTargetRect:buttonFrame inView:self.view];
    [menuController setMenuVisible:YES animated:YES];
    _blockMenu = false;
}

- (void)showInsertMenu {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    NSLog(@"%@", NSStringFromSelector(action));
    if (action == @selector(H1:event:)
        || action == @selector(H2:)
        || action == @selector(H3:)) {
        return YES;
    }
    return NO;
}


- (void)edit:(UIBarButtonItem *)item {
    if (_mdView.isFirstResponder) {
        [_mdView resignFirstResponder];
    } else {
        [_mdView becomeFirstResponder];
    }
}

- (void)textViewDidBeginEditing:(YYTextView *)textView {
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
        target:self
        action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
}

- (BOOL)shouldBlockMenu {
    return self.blockMenu;
}
@end
