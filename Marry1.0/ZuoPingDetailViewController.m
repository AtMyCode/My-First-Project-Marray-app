//
//  ZuoPingDetailViewController.m
//  Marry1.0
//
//  Created by apple on 14-10-2.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "ZuoPingDetailViewController.h"

@interface ZuoPingDetailViewController ()

@end

@implementation ZuoPingDetailViewController
@synthesize browserView,zuoPingMID;
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
    self.browserView = [[AGPhotoBrowserView alloc] initWithFrame:self.view.bounds];
    self.browserView.delegate = self;
    self.browserView.dataSource = self;
    
    
    
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.frame = CGRectMake(0, 0, 40, 40);
    indicatorView.center = self.view.center;
    [self.view addSubview:indicatorView];
    [indicatorView startAnimating];
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationZuoPingData:) name:@"ZuoPingDetailDataImage" object:nil];
    

    
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    [self initNavTitle];//设置页面标题
    mainVC = [MainTarBarViewController sharedTarBarController];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"作品" style:UIBarButtonItemStylePlain target:self action:@selector(displayTabBar)];
    
    [self addTabBar];//添加tabbarButton
    
    
    NSLog(@"mid = %@",zuoPingMID);
}

-(void)notificationZuoPingData:(NSNotification*)note
{
    NSLog(@"我收到了ZuoPingDetailDataImage的消息！");
    
    [indicatorView stopAnimating];
    
    NSDictionary *infoDict = [note userInfo];
    imagesPathArr = [infoDict objectForKey:@"imagesPathArr"];
    logoPathStringURL = [infoDict objectForKey:@"logo_path"];
    opu_countStr = [infoDict objectForKey:@"opu_count"];
    
    //NSLog(@"logopath = %@,opu_countStr = %@",logoPathStringURL,opu_countStr);
    // NSLog(@"%@",imagesPathArr);
    
    //添加tableView
    UITableView *imagesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64-49) style:UITableViewStylePlain];
    [self.view addSubview:imagesTableView];
    imagesTableView.delegate = self;
    imagesTableView.dataSource =self;
    
    //商家logo
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:logoPathStringURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    //作品数目
    opusLabel.text =[NSString stringWithFormat:@"作品%@个",opu_countStr];
    //商家name
    titleNameLabel.text = [infoDict objectForKey:@"name"];
    
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ZuoPingDetailDataImage" object:nil];
}
#pragma mark uitableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imagesPathArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    ZuoPingDetailCoustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZuoPingDetailCoustomCell" owner:self options:nil] lastObject];
    }
   
    [cell.imageView setImageWithURL:[NSURL URLWithString:[imagesPathArr objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:[imagesPathArr objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    return cell;
}
#pragma mark uitableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.browserView showFromIndex:indexPath.row];
    
}
-(void)addTabBar
{
    //tabbarButton
    UIButton *myTabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myTabBarButton.frame = mainVC.tabBar.frame;
    [myTabBarButton addTarget:self action:@selector(tabBarAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myTabBarButton];
    //商家logo图片
    logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, mainVC.tabBar.frame.size.height)];
    [myTabBarButton addSubview:logoImageView];
    //进入箭头
    nextArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth-30, 10, 20, 30)];
    nextArrowImageView.image = [UIImage imageNamed:@"cell_access"];
    [myTabBarButton addSubview:nextArrowImageView];
    //商家的名称
    titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 10, 150, 30)];
    titleNameLabel.adjustsFontSizeToFitWidth = YES;
    [myTabBarButton addSubview:titleNameLabel];
    //作品数目
    opusLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 10, 50, 30)];
    opusLabel.font = [UIFont systemFontOfSize:10];
    opusLabel.textAlignment = NSTextAlignmentRight;
    //opusLabel.backgroundColor = [UIColor purpleColor];
    
    [myTabBarButton addSubview:opusLabel];
}
#pragma mark tabbar Action
-(void)tabBarAction
{
    NSLog(@"我被点击了");
    HDMerchantsHomeDetailInfoProvider *homeDataInfoProvider = [[HDMerchantsHomeDetailInfoProvider alloc] init];
    [homeDataInfoProvider requestMerchantsHomeDetailData:self.zuoPingMID];
    MerchantHomePageController *merchantHomePageVC = [[MerchantHomePageController alloc] init];
    [self.navigationController pushViewController:merchantHomePageVC animated:YES];
}
#pragma mark 显示tabbar
-(void)displayTabBar
{
   
    mainVC.coustomTarBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    title.font =[UIFont boldSystemFontOfSize:18];//默认大小粗体字
    title.textColor = [UIColor whiteColor];
    title.text = @"作品详情";
    self.navigationItem.titleView = title;
}
#pragma mark - AGPhotoBrowser datasource
- (NSInteger)numberOfPhotosForPhotoBrowser:(AGPhotoBrowserView *)photoBrowser
{
    return imagesPathArr.count;
}
- (UIImage *)photoBrowser:(AGPhotoBrowserView *)photoBrowser imageAtIndex:(NSInteger)index
{
    __block UIImage *myImage;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:[imagesPathArr objectAtIndex:index]] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        myImage = image;
    }];
    
   	return myImage;
}
- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser titleForImageAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%d/%d",index+1,imagesPathArr.count];
}
#pragma mark - AGPhotoBrowser delegate
- (void)photoBrowser:(AGPhotoBrowserView *)photoBrowser didTapOnDoneButton:(UIButton *)doneButton
{
	// -- Dismiss
	NSLog(@"Dismiss the photo browser here");
	[self.browserView hideWithCompletion:^(BOOL finished){
		//NSLog(@"Dismissed!");
	}];
}
- (void)photoBrowser:(AGPhotoBrowserView *)photoBrowser didTapOnActionButton:(UIButton *)actionButton atIndex:(NSInteger)index
{
	NSLog(@"Action button tapped at index %d!", index);
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@""
														delegate:nil
											   cancelButtonTitle:NSLocalizedString(@"取消", @"Cancel button")
										  destructiveButtonTitle:NSLocalizedString(@"保存", @"Delete button")
											   otherButtonTitles:NSLocalizedString(@"分享", @"Share button"), nil];
	[action showInView:self.view];
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
