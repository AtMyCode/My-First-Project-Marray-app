//
//  MerchantHomeSubPageController.m
//  Marry1.0
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "MerchantHomeSubPageController.h"

@interface MerchantHomeSubPageController ()

@end

@implementation MerchantHomeSubPageController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(merchantHomeNotifi:) name:@"MerchantHomeDetailNotifi" object:nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(displayTabbar)];
}
-(void)displayTabbar
{
   
    MainTarBarViewController *main = [MainTarBarViewController sharedTarBarController];
    main.coustomTarBar.hidden =NO;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)merchantHomeNotifi:(NSNotification*)note
{
    NSDictionary *dict = [note userInfo];
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"logo_path"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    nameLabel.text = [dict objectForKey:@"name"];
    propertsNameLabel.text = [NSString stringWithFormat:@"**%@",[dict objectForKey:@"properties"]];
    fans_label.text =[NSString stringWithFormat:@"粉丝%d个",[[dict objectForKey:@"fans_count"] intValue]] ;
    merchantDetailArr = [dict objectForKey:@"merchantDetailArr"];
    
    
    UITableView *introductiontableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, sliderScrollView.frame.size.height) style:UITableViewStylePlain];
    [sliderScrollView addSubview:introductiontableView];
    
    introductiontableView.delegate = self;
    introductiontableView.dataSource =self;
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
