//
//  BuyViewController.m
//  Marry1.0
//
//  Created by Ibokan on 14-10-15.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "BuyViewController.h"

@interface BuyViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BuyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor redColor];
    
    
    //self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.taobao.com"]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
