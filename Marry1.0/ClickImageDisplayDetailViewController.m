//
//  ClickImageDisplayDetailViewController.m
//  Marry1.0
//
//  Created by Ibokan on 14-9-29.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "ClickImageDisplayDetailViewController.h"
#import "ShareTabbar.h"
#import "AppDelegate.h"
@interface ClickImageDisplayDetailViewController ()

@end

@implementation ClickImageDisplayDetailViewController
@synthesize guangguangDataProvider,detailIndex,productsDetailStr,productsPrice,imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    [self initNavTitle];//初始化标题
    
    
    //获得主控制器 隐藏tarbar
    mainTarBarViewController = [MainTarBarViewController sharedTarBarController];
    mainTarBarViewController.coustomTarBar.hidden = YES;
    
    //设置返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(PreviousPage)];
    
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"shard"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //[self addTabbarAndBtn];//添加标签栏按钮
    [self.view addSubview:[ShareTabbar toolbar]];//添加分享评论栏
    [self dispalyImageAndDetailLabel];//显示图片
    [self dispalyImagePriceAndDetail];
    
    //购买按钮
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buyBtn.frame = CGRectMake(KScreenWidth-90, KScreenHeight-120, 60, 40);
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];

}
-(void)buyAction
{
    BuyViewController *buyVC = [[BuyViewController alloc] init];
    [self.navigationController pushViewController:buyVC animated:YES];
}
-(void)shareImage:(id)sender
{
  
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:productsDetailStr
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithUrl:[self.guangguangDataProvider.productsUrlArr objectAtIndex:detailIndex]]
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
-(void)dispalyImagePriceAndDetail
{
    //商品描述
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, KScreenHeight-170, KScreenWidth-100, 30)];
    
    detailLabel.adjustsFontSizeToFitWidth = YES;
    detailLabel.numberOfLines = 0;
    detailLabel.text = self.productsDetailStr;
    [self.view addSubview:detailLabel];
    
    //商品价格
    UILabel *productsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2-50, KScreenHeight-120, 100, 40)];
    
    // 设置基本字体
    
    UIFont *boldFont = [UIFont boldSystemFontOfSize:15];
    productsPriceLabel.font = boldFont;
    productsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.productsPrice];
    //productsPriceLabel.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:productsPriceLabel];


}
-(void)dispalyImageAndDetailLabel
{
    //图片
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/2-(KScreenWidth-50)/2, 64+10, KScreenWidth-50, KScreenHeight-250)];
    [self.view addSubview:imageView];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.guangguangDataProvider.productsUrlArr objectAtIndex:detailIndex]]];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
  
}
#pragma mark 添加标签栏
//-(void)addTabbarAndBtn
//{
//    UIView *tabbarView = [[UIView alloc] initWithFrame:mainTarBarViewController.tabBar.frame];
//    tabbarView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:tabbarView];
//    
//    
//    NSArray *btnArr = [[NSArray alloc] initWithObjects:@"评论",@"赞",@"分享",@"讨论", nil];
//    for (int i=0; i<btnArr.count; i++)
//    {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(i*(KScreenWidth/4.0-20+(KScreenWidth/4.0-20)/2), 10, KScreenWidth/4.0-20, 30);
//        [btn setTitle:[btnArr objectAtIndex:i] forState:UIControlStateNormal];
//        btn.tag = 100+i;
//        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//        [tabbarView addSubview:btn];
//    }
//
//}
//#warning ！！ 评论 赞 分享按钮动作
//-(void)btnAction:(UIButton *)sender
//{
//    
//}
-(void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    title.font =[UIFont boldSystemFontOfSize:18];//默认大小粗体字
    title.textColor = [UIColor whiteColor];
    title.text = @"商品详情";
    self.navigationItem.titleView = title;

   
}
-(void)PreviousPage
{
    mainTarBarViewController.coustomTarBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
