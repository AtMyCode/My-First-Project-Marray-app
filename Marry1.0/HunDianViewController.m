//
//  HunDianViewController.m
//  Marry1.0
//
//  Created by apple on 14-10-1.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "HunDianViewController.h"

@interface HunDianViewController ()

@end
static int pageNumFooterRefresh =1;
@implementation HunDianViewController
@synthesize sliderScrollView,zuoPingTableView,zuoPingDataProvider,merchantsTableView,merchantsDataProvider;
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
    
    //通知 作品的
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"HDZuoPingItemsData" object:nil queue:queue usingBlock:^(NSNotification *note) {
        NSLog(@"婚典作品的数据我收到了！");
        
        
        
        NSDictionary *dict =  [note userInfo];
        zuoPingItemsImagePathArr = [dict objectForKey:@"items"];
        zuoPingTitleArr = [dict objectForKey:@"title"];
        zuoPingIDArr = [dict objectForKey:@"idArr"];
        zuoPingMIDArr = [dict objectForKey:@"midArr"];
        //NSLog(@"%@",zuoPingMIDArr);
        
        
        static int switchIndex = 1;
        if (switchIndex) {
            self.zuoPingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, KScreenWidth, KScreenHeight-64-49) style:UITableViewStylePlain];
            self.zuoPingTableView.backgroundColor = [UIColor yellowColor];
            self.zuoPingTableView.delegate = self;
            self.zuoPingTableView.dataSource = self;
            [self.sliderScrollView addSubview:self.zuoPingTableView];
            //添加上拉加载
            [self addFooterRefreshToZuoPingView];
            switchIndex = 0;

        }
        [indicator stopAnimating];
        
    }];
    
    
    //商家的数据通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(merchantsDataNotifi:) name:@"merchantsDataNotification" object:nil];
     
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [self addSegementView];//添加分割view
    [self addPageScrollView];//添加滚动视图
    //[self addZuoPingAndShangjiaView];//在滚动视图上添加作品和商家页面
    
    //初始化作品数据提供者
   self.zuoPingDataProvider = [[HDZuoPingDataProvide alloc] init];

    [self.zuoPingDataProvider requestZuoPingData];
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0, 0, 30, 30);
    indicator.center  = self.view.center;
    [indicator startAnimating];
    [self.view addSubview:indicator];
    
    //商家页面tableView
    self.merchantsTableView = [[UITableView alloc] initWithFrame:CGRectMake(KScreenWidth, -64, KScreenWidth, KScreenHeight-49-64) style:UITableViewStylePlain];
    

}
#pragma mark 商家data的通知
-(void)merchantsDataNotifi:(NSNotification*)note
{
    NSLog(@"我是商家我收到了");
    [merchantsPageIndicator stopAnimating];
    NSDictionary *dataDict =  [note userInfo];
    merchantsFans_countArr = [dataDict objectForKey:@"fans_count"];
    merchantsLogo_pathArr = [dataDict objectForKey:@"logo_path"];
    merchantsNameArr = [dataDict objectForKey:@"name"];
    merchantsOpu_count = [dataDict objectForKey:@"opu_count"];
    merchantsPropertiesNameArr = [dataDict objectForKey:@"propertiesName"];
    merchantsMID = [dataDict objectForKey:@"merchantsMID"];
    
    //NSLog(@"%@",merchantsMID);
    //NSLog(@"%d,%d,%d,%d,%d",[merchantsPropertiesNameArr count],[merchantsOpu_count count],[merchantsNameArr count],[merchantsLogo_pathArr count],[merchantsFans_countArr count]);
    static int switchNum=1;
    if (switchNum) {
        [self.sliderScrollView addSubview:self.merchantsTableView];
        self.merchantsTableView.delegate =self;
        self.merchantsTableView.dataSource=self;
        [self addHeaderMerchantsRefresh];//添加下拉刷新
        [self addFooterMerchatsRefresh];//添加上拉加载
        switchNum = 0;
    }
    
}
#pragma mark 添加上拉加载
-(void)addFooterMerchatsRefresh
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.merchantsTableView addFooterWithCallback:^{
        
        vc.merchantsDataProvider.pageNum = ++pageNumFooterRefresh;
        NSLog(@"%d",pageNumFooterRefresh);
        // 进入刷新状态就会回调这个Block
        [vc.merchantsDataProvider requestMerchantsData];
       
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.merchantsTableView reloadData];
            // 结束刷新
            [vc.merchantsTableView footerEndRefreshing];
        });
    }];

}
#pragma mark 添加下拉刷新
- (void)addHeaderMerchantsRefresh
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.merchantsTableView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        pageNumFooterRefresh =1;
        vc.merchantsDataProvider.pageNum =1;
        [vc.merchantsDataProvider requestMerchantsData];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.merchantsTableView reloadData];
            // 结束刷新
            [vc.merchantsTableView headerEndRefreshing];
        });
    }];
    

    //[self.merchantsTableView headerBeginRefreshing];
}

#pragma mark 添加上拉加载
-(void)addFooterRefreshToZuoPingView
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.zuoPingTableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [vc.zuoPingDataProvider requestZuoPingData];
        
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.zuoPingTableView reloadData];
            // 结束刷新
            [vc.zuoPingTableView footerEndRefreshing];
        });
    }];

}
#pragma mark 在婚典页面添加滚动视图
-(void)addPageScrollView
{
    //添加滚动视图
    self.sliderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-49-64)];
    [self.sliderScrollView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    [self.sliderScrollView setShowsHorizontalScrollIndicator:NO];
    [self.sliderScrollView setShowsVerticalScrollIndicator:NO];
    [self.sliderScrollView setPagingEnabled:YES];
    [self.sliderScrollView setBounces:NO];
    [self.sliderScrollView setContentSize:CGSizeMake(KScreenWidth*2, 0)];
    [self.sliderScrollView setDelegate:self];
    [self.view addSubview:self.sliderScrollView];
}
#pragma mark //添加作品view 商家页面
-(void)addZuoPingAndShangjiaView
{
    //作品view
    UIView *zuoPingView = [[UIView alloc] init];
    zuoPingView.frame = CGRectMake(0, -64, KScreenWidth, KScreenHeight-64-49);
    //zuoPingView.backgroundColor = [UIColor redColor];
    [self.sliderScrollView addSubview:zuoPingView];
    //商家view
    UIView *merchantsView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth, -64, KScreenWidth, KScreenHeight-64-49)];
    merchantsView.backgroundColor = [UIColor redColor];
    [self.sliderScrollView addSubview:merchantsView];
    
}
#pragma mark UItableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==self.merchantsTableView) {
        return [merchantsLogo_pathArr count];
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView ==self.merchantsTableView) {
        return 1;
    }
    return [zuoPingItemsImagePathArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.merchantsTableView)
    {
        static NSString *CellIdentifier = @"TableViewCell";
        HunDianMerchantsPageCostomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HunDianMerchantsPageCostomCell" owner:self options:nil] lastObject];
        }
        @try {
            cell.propertiesNameLabel.text = [NSString stringWithFormat:@"**%@",[merchantsPropertiesNameArr objectAtIndex:indexPath.row]];
           

        }
        @catch (NSException *exception) {
            NSLog(@"exception = %@",exception);
            
        }
        @finally {
            
        }
        [cell.logoImageView setImageWithURL:[NSURL URLWithString:[merchantsLogo_pathArr objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.nameLabel.text = [merchantsNameArr objectAtIndex:indexPath.row];
        cell.opu_countLabel.text = [NSString stringWithFormat:@"作品%d个",[[merchantsOpu_count objectAtIndex:indexPath.row] intValue]];
        cell.fansLabel.text = [NSString stringWithFormat:@"粉丝%d个",[[merchantsFans_countArr objectAtIndex:indexPath.row] intValue]];

               return cell;
    }

    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    HunDianZuoPingPageCostomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HunDianZuoPingPageCostomCell" owner:self options:nil] lastObject];
    }
    
    //NSLog(@"%@",zuoPingItemsImagePathArr);
   //NSLog(@"%@",[[zuoPingItemsImagePathArr objectAtIndex:0] objectAtIndex:0]);
    [cell.FirstImageView sd_setImageWithURL:[NSURL URLWithString:[[zuoPingItemsImagePathArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [cell.secondImageView sd_setImageWithURL:[NSURL URLWithString:[[zuoPingItemsImagePathArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row+1] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    @try {
        [cell.ThirdImageView sd_setImageWithURL:[NSURL URLWithString:[[zuoPingItemsImagePathArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row+2] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
   
    
    
    cell.titleLabel.text = [zuoPingTitleArr objectAtIndex:indexPath.section];
    
    return cell;
}
#pragma mark UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 200;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.merchantsTableView) {
        return 120;
    }
    return 183;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"我选择了%d",indexPath.section);
    if (tableView ==self.zuoPingTableView) {
        HDZuoPingDetailDataProvider *detailDataProvier = [[HDZuoPingDetailDataProvider alloc] init];
        [detailDataProvier requestDetailData:[zuoPingIDArr objectAtIndex:indexPath.section]];
        ZuoPingDetailViewController *zuoPingDetailViewController = [[ZuoPingDetailViewController alloc] init];
        zuoPingDetailViewController.zuoPingMID = [zuoPingMIDArr objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:zuoPingDetailViewController animated:YES];
        
        MainTarBarViewController *main = [MainTarBarViewController sharedTarBarController];
        main.coustomTarBar.hidden = YES;
    }
    else
    {
        NSLog(@"商家%d",indexPath.row);
        
            HDMerchantsHomeDetailInfoProvider *infoProvider = [[HDMerchantsHomeDetailInfoProvider alloc] init];
            [infoProvider requestMerchantsHomeDetailData:[merchantsMID objectAtIndex:indexPath.row]];
            
            MainTarBarViewController *main = [MainTarBarViewController sharedTarBarController];
            main.coustomTarBar.hidden = YES;
            
            MerchantHomeSubPageController *homeSubPage = [[MerchantHomeSubPageController alloc] init];
            
            [self.navigationController pushViewController:homeSubPage animated:YES];
    

    }
    
    
}
#pragma mark 在导航栏上添加segementController
- (UISegmentedControl*)addSegementView
{
    segementTitleView =[[UISegmentedControl alloc] initWithItems:@[@"作品",@"商家"]];
    
    segementTitleView.frame = CGRectMake(0, 0, KScreenWidth - 320+120, 28);
    segementTitleView.tintColor = [UIColor whiteColor];
    segementTitleView.selectedSegmentIndex = 0;
    [segementTitleView addTarget:self action:@selector(segementTouchAction:) forControlEvents:UIControlEventValueChanged];
    return segementTitleView;
}
#pragma  mark  点击切换逛逛和主题页面
-(void)segementTouchAction:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        
        
        [self.sliderScrollView setContentOffset:CGPointMake(0, -64) animated:YES];
    }
    else
    {
        
        
        [self.sliderScrollView setContentOffset:CGPointMake(320, -64) animated:YES];
        
    }
    
}
#pragma mark UIScrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.sliderScrollView])
    {
        if (scrollView.contentOffset.x ==0) {
            
            segementTitleView.selectedSegmentIndex = 0;
        }
        else if (scrollView.contentOffset.x==320)
        {
            segementTitleView.selectedSegmentIndex = 1;
            
            static int switchNum = 1;
            if (switchNum) {
                NSLog(@"==================================");
                self.merchantsDataProvider = [[HDMerchantsDataProvider alloc] init];
                [self.merchantsDataProvider requestMerchantsData];
                switchNum = 0;
                merchantsPageIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                merchantsPageIndicator.frame = CGRectMake(0, 0, 40, 40);
                merchantsPageIndicator.center = self.view.center;
                [self.view addSubview:merchantsPageIndicator];
                [merchantsPageIndicator startAnimating];
            }
            
            
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
