//
//  WeddingProcessGuideViewController.m
//  Marry1.0
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "WeddingProcessGuideViewController.h"

@interface WeddingProcessGuideViewController ()

@end

@implementation WeddingProcessGuideViewController
@synthesize processTitle,row;
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //读取plist文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MarryFlow" ofType:@"plist"];
    contentArr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 20)];
    titleLabel.backgroundColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = processTitle;
    [self.view addSubview:titleLabel];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 84, KScreenWidth, KScreenHeight-49-64-20)];
    textView.font = [UIFont systemFontOfSize:14];
    textView.backgroundColor = [UIColor colorWithRed:242/255.0 green:183/255.0 blue:193/255.0 alpha:0.8];
    textView.text = [contentArr objectAtIndex:row];
    
    
    textView.editable = NO;
    
    
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
