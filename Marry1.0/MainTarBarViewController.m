//
//  MainTarBarViewController.m
//  Marry1.0
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "MainTarBarViewController.h"

@interface MainTarBarViewController ()

@end

@implementation MainTarBarViewController
@synthesize coustomTarBar;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        [self.tabBar setHidden:YES];
//    }
//    return self;
//}
-(id)init
{
    if (self = [super init])
    {
        self.tabBar.hidden = YES;
    }
    return self;
}
+(MainTarBarViewController*)sharedTarBarController
{
    static MainTarBarViewController *main = nil;
    if (!main)
    {
        main = [[MainTarBarViewController alloc] init];
    }
    return main;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initArr]; //创建好一系列数组
    [self initCoustomTarbar]; //添加自定义导航栏
    
    

    
}
#pragma mark 初始化数组
-(void)initArr
{
    imageArr = [[NSMutableArray alloc] initWithObjects:@"r3_c4",@"r3_c8",@"r3_c12",@"r3_c18",@"r3_c22", nil];
    selectedImageArr = [[NSMutableArray alloc] initWithArray:@[@"r3_c4_1_4",@"r3_c8_1_4",@"r3_c12_1_4",@"r3_c18_2_4",@"r3_c22_1_4"]];
    btnArray = [[NSMutableArray alloc] init];  //按钮数组
    textLabelArr = @[@"婚饰",@"婚典",@"请贴",@"故事",@"设置"];
    labelArr = [[NSMutableArray alloc] init];
}
#pragma mark 添加自定义tarbar
-(void)initCoustomTarbar
{
    
    CGRect rect = self.tabBar.frame;
    
    self.coustomTarBar = [[UIView alloc] initWithFrame:rect];
    self.coustomTarBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coustomTarBar];
    
    for (int i =0; i<imageArr.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(KScreenWidth/5*i+16, 5, 32, 32);
        
        [btn setImage:[UIImage imageNamed:[imageArr objectAtIndex:i]] forState:UIControlStateNormal];
        
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(switchPage:) forControlEvents:UIControlEventTouchUpInside];
        [btnArray addObject:btn];
        [self.coustomTarBar addSubview:btn];
        
        //标签
        float x = btn.center.x;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x-10, 30, 20, 20)];
        label.tag = 100+i;
        [label setText:[textLabelArr objectAtIndex:i]];
        label.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1];
        label.adjustsFontSizeToFitWidth = YES;
        [labelArr addObject:label];
        [self.coustomTarBar addSubview:label];
    }
    //设置第一个页面的标签栏的颜色
    UIButton *btn =(UIButton*)[self.coustomTarBar viewWithTag:1000];
    [btn setImage:[UIImage imageNamed:[selectedImageArr objectAtIndex:0]] forState:UIControlStateNormal];
    UILabel *label = (UILabel*)[self.coustomTarBar viewWithTag:100];
    label.textColor =[UIColor colorWithRed:241/255.0 green:46/255.0 blue:179/255.0 alpha:1];

}
#pragma mark 切换页面
-(void)switchPage:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 1000:
            self.selectedIndex = 0;
            break;
        case 1001:
            self.selectedIndex = 1;
            break;
        case 1002:
            self.selectedIndex = 2;
            break;
        case 1003:
            self.selectedIndex = 3;
            break;
        case 1004:
            self.selectedIndex = 4;
            break;
    }
    for(int i=0;i<btnArray.count;i++)
    {
        
        UIButton *btn=[btnArray objectAtIndex:i];//更改tarbar按钮的颜色
        UILabel *label = [labelArr objectAtIndex:btn.tag-1000];//更改label文字的颜色
        if([btn isEqual:sender])
        {
            [btn setImage:[UIImage imageNamed:[selectedImageArr objectAtIndex:i]] forState:UIControlStateNormal];
            label.textColor =[UIColor colorWithRed:241/255.0 green:46/255.0 blue:179/255.0 alpha:1];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:[imageArr objectAtIndex:i]] forState:UIControlStateNormal];
            label.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1];
        }
    }
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
