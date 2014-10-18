//
//  MySetViewController.m
//  Marry1.0
//
//  Created by Ibokan on 14-10-8.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "MySetViewController.h"

@interface MySetViewController ()


@end

@implementation MySetViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    title.font =[UIFont boldSystemFontOfSize:18];//默认大小粗体字
    title.textColor = [UIColor whiteColor];
    title.text = @"我的设置";
    self.navigationItem.titleView = title;
    
    //微博登录的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiboNotifi:) name:@"weiboNotifi" object:nil];
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 60, 30)];
    userNameLabel.text = @"用户名";
    [self.view addSubview:userNameLabel];
    
    userNameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 80, 120, 30)];
    
    userNameLabel2.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:userNameLabel2];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(10, 130, 40, 30);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.tag = 1111;
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth-120, 80, 80, 80)];
    [portraitImageView sd_setImageWithURL:[NSURL URLWithString:avatarImageURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    //圆角设置
    portraitImageView.layer.cornerRadius
    = 40;
    
    portraitImageView.layer.masksToBounds
    = YES;
    [self.view addSubview:portraitImageView];

    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 180, KScreenWidth, KScreenHeight)];
    background.backgroundColor = [UIColor colorWithRed:245/255.0 green:202/255.0 blue:202/255.0 alpha:1];
    [self.view addSubview:background];
    setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, KScreenWidth, 44*6) style:UITableViewStylePlain];
    setTableView.delegate =self;
    setTableView.dataSource = self;
    setTableView.scrollEnabled = NO;
    [background addSubview:setTableView];
    
    NSString *cache = [NSString stringWithFormat:@"清理缓存(%.2lfM)",[SDWebImageManager.sharedManager.imageCache  getSize]/(1024.0*1024.0)];
    textArr = @[@"婚礼流程",@"我的故事",cache,@"关于我们",@"意见反馈",@"版本更新"];
    iconArr =@[@"icon_star@2x",@"qingtie_a",@"icon_trip_delete@2x",@"icon_team_about",@"setting_feedback@2x",@"alert_version_update@2x"];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    NSString *cache = [NSString stringWithFormat:@"清理缓存(%.2lfM)",[SDWebImageManager.sharedManager.imageCache  getSize]/(1024.0*1024.0)];
    textArr = @[@"婚礼流程",@"我的故事",cache,@"关于我们",@"意见反馈",@"版本更新"];
    [setTableView reloadData];
    
}
#pragma mark UITableViewDataSoucre
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return textArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:[iconArr objectAtIndex:indexPath.row]];
    cell.textLabel.text = [textArr objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellfour"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        WeddingProcessController *weddingProcess = [[WeddingProcessController alloc] init];
        [self.navigationController pushViewController:weddingProcess animated:YES];
    }
    else if (indexPath.row ==1)
    {
        MainTarBarViewController *main = [MainTarBarViewController sharedTarBarController];
        main.coustomTarBar.hidden = YES;
        SetMyStoryViewController *viewController = [[SetMyStoryViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (indexPath.row==2)
    {
        [SDWebImageManager.sharedManager.imageCache clearMemory];
        [SDWebImageManager.sharedManager.imageCache clearDisk];
        NSString *cache = [NSString stringWithFormat:@"清理缓存(%.2lfM)",[SDWebImageManager.sharedManager.imageCache  getSize]/(1024.0*1024.0)];
        textArr = @[@"婚礼流程",@"我的故事",cache,@"关于我们",@"意见反馈",@"版本更新"];

        [setTableView reloadData];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缓存已清除" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if (indexPath.row==3)
    {
        
    }else if (indexPath.row ==4)
    {
        [UMFeedback showFeedback:self withAppkey:@"543aa155fd98c59dcb0167aa"];

    }else if (indexPath.row==5)
    {
        [[UIApplication sharedApplication].delegate performSelector:@selector(updateApp)];
    }
}
#pragma mark login
-(void)loginAction:(UIButton*)sender
{
   
   
    if ([sender.currentTitle isEqualToString:@"登录"])
    {
      
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kRedirectURI;
        request.scope = @"all";
        request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        [WeiboSDK sendRequest:request];

    }
    else if ([sender.currentTitle isEqualToString:@"注销"])
    {
        AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
        [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"991"];

    }
    
    
        
   
}
-(void)weiboNotifi:(NSNotification*)note
{
    NSDictionary *dict = [note userInfo];
    userName = [dict objectForKey:@"name"];
    avatarImageURL = [dict objectForKey:@"avatar_hd"];
    
    userNameLabel2.text = userName;
    [portraitImageView sd_setImageWithURL:[NSURL URLWithString:avatarImageURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    ;
    
    
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"提示";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:@"登录成功"
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
    
    UIButton *loginButn = (UIButton*)[self.view viewWithTag:1111];
    [loginButn setTitle:@"注销" forState:UIControlStateNormal];
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"提示";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:@"注销成功"
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
    UIButton *loginButn = (UIButton*)[self.view viewWithTag:1111];
    [loginButn setTitle:@"登录" forState:UIControlStateNormal];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"请求异常";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
