//
//  QTViewController.m
//  QTSkin
//
//  Created by fminor on 12/06/2016.
//  Copyright (c) 2016 fminor. All rights reserved.
//

#import "QTViewController.h"

@interface QTViewController ()
{
    UIView *_containerView1;
    UIView *_containerView2;
}

@end

@implementation QTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _containerView1 = [[UIView alloc] init];
    _containerView2 = [[UIView alloc] init];
    
    [_containerView1 setFrame:CGRectMake(0, 0, 300, 200)];
    [_containerView2 setFrame:CGRectMake(0, 250, 300, 200)];
    
    [_containerView1 setBackgroundColor:[UIColor redColor]];
    [_containerView2 setBackgroundColor:[UIColor blueColor]];
    
    [self.view addSubview:_containerView1];
    [self.view addSubview:_containerView2];
    
    NSString *_path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"qts"];
    NSURL *_url = [NSURL fileURLWithPath:_path];
    [[QTSkinManager sharedManager] loadStyleFile:_url];
    
    NSString *_layoutPath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"qtl"];
    NSURL *_layoutUrl = [NSURL fileURLWithPath:_layoutPath];
    
    [[QTSkinManager sharedManager] bindController:self withLayoutFile:_layoutUrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
