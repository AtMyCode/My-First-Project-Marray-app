//
//  ThemeImageDetailVCViewController.m
//  Marry1.0
//
//  Created by apple on 14-10-1.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "ThemeImageDetailVCViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface ThemeImageDetailVCViewController ()

@end

@implementation ThemeImageDetailVCViewController
@synthesize imageArr;
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
    
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"shard"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

}
-(void)dispalyImageAndDetailLabel:(int)index
{
    
    //图片
   UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/2-(KScreenWidth-50)/2, 64+10, KScreenWidth-50, KScreenHeight-250)];
    [self.view addSubview:imageView];
    imageArrIndex = index;

    if (self.imageArr)
    {
        [self.imageView sd_setImageWithURL:[self.imageArr objectAtIndex:index]placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
    }
    
}
-(void)shareImage:(id)sender
{
    
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:self.productsDetailStr
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithUrl:[self.imageArr objectAtIndex:imageArrIndex]]
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
    
    
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
