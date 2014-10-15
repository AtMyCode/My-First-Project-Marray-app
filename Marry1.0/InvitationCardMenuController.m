//
//  InvitationCardMenuController.m
//  Marry1.0
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "InvitationCardMenuController.h"

@interface InvitationCardMenuController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation InvitationCardMenuController

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
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"galaxy"]];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
    
    NSDictionary *viewDictionary = @{ @"imageView" : self.backgroundImageView };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    
//    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    closeButton.frame = CGRectMake(10.0f, 100.0f, 200.0f, 44.0f);
//    [closeButton setBackgroundColor:[UIColor whiteColor]];
//    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
//    [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:closeButton];
    
    weddingArr = @[@"我的请帖",@"婚礼故事"];
    weddingImagePathArr = @[@"icon_message_blue",@"icon_liked_s_32"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 215, KScreenHeight) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
//    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    changeButton.frame = CGRectMake(10.0f, 200.0f, 200.0f, 44.0f);
//    [changeButton setTitle:@"Swap" forState:UIControlStateNormal];
//    [changeButton setBackgroundColor:[UIColor greenColor]];
//    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [changeButton addTarget:self action:@selector(changeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:changeButton];
    
    invitationCardMainNav = [[UINavigationController alloc] initWithRootViewController:[InvitationCardMainController new]];
}
//- (void)changeButtonPressed
//{
//    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[InvitationCardMainController new]];
//    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [weddingArr objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[weddingImagePathArr objectAtIndex:indexPath.row]];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 215, 188)];
    headView.backgroundColor = [UIColor colorWithRed:188/255.0 green:184/255.0 blue:255/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 80, 30)];
    label.text = @"我的婚礼";
    label.textColor = [UIColor redColor];
    [headView addSubview:label];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        AppNavigationController *controller = [[AppNavigationController alloc] initWithRootViewController:[InvitationCardMainController new]];
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
        
    }else if (indexPath.row==1)
    {
        
        MyStoryViewController *myStoryVC = [[MyStoryViewController alloc] init];
       
        AppNavigationController *controller = [[AppNavigationController alloc] initWithRootViewController:myStoryVC];
            [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    }
}
- (void)closeButtonPressed
{
    
       [self.sideMenuViewController setMainViewController:invitationCardMainNav animated:YES closeMenu:YES];
}
-(void)invitationCardMenuControllerNofi:(NSNotification*)note
{
    NSLog(@"invitationCardMenuControllerNofi");
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
