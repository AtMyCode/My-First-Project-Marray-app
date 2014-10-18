//
//  HunShiViewController.m
//  Marry1.0
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "HunShiViewController.h"
#import "GuangCollectionCell.h"
@interface HunShiViewController ()

@end

@implementation HunShiViewController
@synthesize sliderScrollView,btnCategoryView,guangGuangCollectionView,guangGuangDataProvider,categoryBtnArray,reachability;
@synthesize themeIDArr,themeImageUrlArr,themeTitleArr,themeTableView,themeDataProvider;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self checkNetwork];//检测网络
    }
    return self;
}
- (void) reachabilityChanged: (NSNotification*)note {
    self.reachability = [note object];
    
    if(![self.reachability isReachable])
    {
        NSLog(@"网络不可以用");
        return;
    }
    
    NSLog(@"网络可用");;
    
    if (self.reachability.isReachableViaWiFi) {
        NSLog(@"当前通过wifi连接");
       
    } else {
        NSLog(@"wifi未开启，不能用");
        
    }
    
    if (self.reachability.isReachableViaWWAN) {
        NSLog(@"当前通过2g or 3g连接");
        
    } else {
        
        NSLog(@"2g or 3g网络未使用") ;
    }
}
-(void)checkNetwork
{
    NSLog(@"开启 www.apple.com 的网络检测");
    self.reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    NSLog(@"-- current status: %@", self.reachability.currentReachabilityString);
    
    // start the notifier which will cause the reachability object to retain itself!
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    self.reachability.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"网络可用");
        });
    };
    
    self.reachability.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"网络不可以用");
            return ;
            
        });
    };
    
    [self.reachability startNotifier];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNotification]; //向通知中心注册观察者 给主题页面提供信息
    
    self.guangGuangDataProvider = [[GuangGuangDataProvider alloc] init];//创建逛逛数据提供者

    //在导航栏上添加segementController
    self.segmentedControl = [self addSegementView];
    self.navigationItem.titleView =self.segmentedControl;
    //在婚饰页面添加滚动视图
    [self addPageScrollView];
    //创建collectionView来显示逛逛的数据
    [self createGuangGuangCollectionMethod];
    //添加逛逛view 和 主题页面
    [self addGuangGuangAndTheme];
    //添加分类按钮到右侧导航栏
    [self addCategoryBtnToNav];
    //添加种类按钮到分类按钮面板上
    [self addBtnToCategoryView];
    
     viewIsHidden =1;
    [self addFooterToGuangGuangCollectionView];//给逛逛添加上拉刷新
    [self addHeaderToGuangGuangCollectionView];//给逛逛添加下拉刷新
    
    
    
    
}

#pragma mark 为逛逛获得数据
-(void)getDataToGuangGuang
{
//        //手动下拉时调用
//    if (productsID)
//    {
//        
//        dispatch_group_t group = dispatch_group_create();
//        
//        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//        
//        dispatch_group_async(group, queue, ^{
//            [self.guangGuangDataProvider requestData];//请求数据
//        });
//        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//            [self.guangGuangDataProvider.products_IDArr removeObjectsInArray:productsID];
//            productsID = self.guangGuangDataProvider.products_IDArr;
//            
//            [self.guangGuangDataProvider.productsDetailInfoArr removeObjectsInArray:productsDetailInfoArr];
//            productsDetailInfoArr = self.guangGuangDataProvider.productsDetailInfoArr;
//            
//            [self.guangGuangDataProvider.productsLike_CountArr removeObjectsInArray:productsLike_CountArr];
//            productsLike_CountArr =self.guangGuangDataProvider.productsLike_CountArr;
//            
//            [self.guangGuangDataProvider.productsLikeNumArr removeObjectsInArray:productsLikeNumArr];
//            productsLikeNumArr =self.guangGuangDataProvider.productsLikeNumArr;
//            
//            [self.guangGuangDataProvider.productsPriceArr removeObjectsInArray:productsPriceArr];
//            productsPriceArr =self.guangGuangDataProvider.productsPriceArr;
//            
//            [self.guangGuangDataProvider.productsUrlArr removeObjectsInArray:productsUrlArr];
//            productsUrlArr =self.guangGuangDataProvider.productsUrlArr;
//            
//            
//        });
//  
//    }
//    else
//    {
    
        [self.guangGuangDataProvider requestData];//请求数据
    

    
    productsLike_CountArr = self.guangGuangDataProvider.productsLike_CountArr;
    
    productsPriceArr = self.guangGuangDataProvider.productsPriceArr;
    
    productsUrlArr = self.guangGuangDataProvider.productsUrlArr;
    
    productsID = self.guangGuangDataProvider.products_IDArr;
    
    productsLikeNumArr = self.guangGuangDataProvider.productsLikeNumArr;
    
    productsDetailInfoArr = self.guangGuangDataProvider.productsDetailInfoArr;

    
    
}
#pragma mark 添加下拉刷新
-(void)addHeaderToGuangGuangCollectionView
{
    
    
        __unsafe_unretained typeof(self) vc = self;
        // 添加下拉刷新头部控件
        [self.guangGuangCollectionView addHeaderWithCallback:^{
            // 进入刷新状态就会回调这个Block
            

//            if ([vc.reachability isReachable])
//            {
            
            static int i=1;
            if (i)
            {
                //取得逛逛页面的数据
                [vc getDataToGuangGuang];
                i=0;
            }
            
                // 模拟延迟加载数据，因此2秒后才调用）
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [vc.guangGuangCollectionView reloadData];
                    // 结束刷新
                    [vc.guangGuangCollectionView headerEndRefreshing];
                });
            //}
            
        }];
 
#warning 自动刷新(一进入程序就下拉刷新)
    [self.guangGuangCollectionView headerBeginRefreshing];
}
- (void)addFooterToGuangGuangCollectionView
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.guangGuangCollectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [vc.guangGuangDataProvider requestData];
       
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.guangGuangCollectionView reloadData];
            // 结束刷新
            [vc.guangGuangCollectionView footerEndRefreshing];
        });
    }];
}

#pragma mark CollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [productsUrlArr count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     GuangCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[productsUrlArr objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[[productsPriceArr objectAtIndex:indexPath.row] floatValue]];
        cell.loveCountLabel.text = [NSString stringWithFormat:@"%d",[[productsLike_CountArr objectAtIndex:indexPath.row] intValue]];

               cell.backgroundColor = [UIColor whiteColor];
    
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    ClickImageDisplayDetailViewController *imageDetailViewController = [[ClickImageDisplayDetailViewController alloc] init];
    imageDetailViewController.guangguangDataProvider = self.guangGuangDataProvider;
    imageDetailViewController.detailIndex = indexPath.row;
    imageDetailViewController.productsDetailStr =[productsDetailInfoArr objectAtIndex:indexPath.row];
    imageDetailViewController.productsPrice = [[productsPriceArr objectAtIndex:indexPath.row] floatValue];
    imageDetailViewController.view.backgroundColor = [UIColor whiteColor];
    imageDetailViewController.productsId = [[productsID objectAtIndex:indexPath.row] intValue];
   // NSLog(@"%@",productsID);
    //NSLog(@"%@",[productsPriceArr objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:imageDetailViewController animated:YES];
    
}

#pragma mark 创建逛逛的collectionView
-(void)createGuangGuangCollectionMethod
{
    //创建UICollectionView
    UICollectionViewFlowLayout *layout  =[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(150, 160);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    self.GuangGuangCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -64, KScreenWidth,KScreenHeight-64-49) collectionViewLayout:layout];
    self.guangGuangCollectionView.backgroundColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1];
    
    // [self.view addSubview:GuangGuangCollectionView];
    
    [self.guangGuangCollectionView registerClass:[GuangCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    self.guangGuangCollectionView.delegate = self;
    self.guangGuangCollectionView.dataSource = self;

}

#pragma mark 添加种类按钮到分类按钮面板上
-(void)addBtnToCategoryView
{
    self.categoryBtnArray = [NSArray arrayWithObjects:@"全部",@"婚纱",@"礼服",@"婚鞋",@"配饰",@"首饰",@"婚庆用品",@"家居礼品", nil];//类别
    self.btnCategoryView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth/2-50, 64, 100, 250)];
    [self.view addSubview:self.btnCategoryView];
    self.btnCategoryView.hidden = YES;
    
    //添加tableview来放置按钮
    UITableView *categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.btnCategoryView.frame.size.width, self.btnCategoryView.frame.size.height) style:UITableViewStylePlain];
    [self.btnCategoryView addSubview:categoryTableView];
    categoryTableView.delegate = self;
    categoryTableView.dataSource = self;
    categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分割线
    categoryTableView.backgroundColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:0.3];
    
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.themeTableView)
    {
      return  self.themeImageUrlArr.count;
    }
    else
    {
        return self.categoryBtnArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.themeTableView)
    {
        static NSString *CellIdentifier = @"TableViewCell";
        //自定义cell类
        static BOOL isRegister =NO;
        if (!isRegister) {
            UINib *nib = [UINib nibWithNibName:@"CostomThemeCell" bundle:[NSBundle mainBundle]];
            [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
            isRegister = YES;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:1];
        UILabel *title =(UILabel*)[cell.contentView viewWithTag:2];
        title.text = [themeTitleArr objectAtIndex:indexPath.row];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[themeImageUrlArr objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        return cell;
    }
    else
    {
        static NSString *identifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.font = [UIFont fontWithName:@"Menlo Regular-Bold" size:2];//设置字体大小
        
        cell.textLabel.text = [self.categoryBtnArray objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];//设置字体颜色
        cell.backgroundColor  = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:0.3];
        //设置选中后的字体颜色
        cell.textLabel.highlightedTextColor = [UIColor colorWithRed:255/255.0 green:202/255.0 blue:1/255.0 alpha:1];
        //设置cell选中的颜色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:103/255.0 green:144/255.0 blue:136/255.0 alpha:1];
        return cell;
    }
    
}
#pragma mark uitableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.themeTableView) {
        return 200;
    }
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.themeTableView)
    {
        ThemeContentController *themeContentVC = [[ThemeContentController alloc] init];
        GGThemeContentImageProvider *themeImageInfoProvider = [[GGThemeContentImageProvider alloc] init];
        [themeImageInfoProvider requestImageThemeData:[[self.themeIDArr objectAtIndex:indexPath.row] intValue]];
        [self.navigationController pushViewController:themeContentVC animated:NO];
    }
    else
    {
        
        if (self.guangGuangDataProvider.productsUrlArr)
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                self.guangGuangDataProvider.categoryIndex = indexPath.row;
                [self.guangGuangDataProvider.productsLike_CountArr removeAllObjects];
                [self.guangGuangDataProvider.productsLikeNumArr removeAllObjects];
                [self.guangGuangDataProvider.productsPriceArr removeAllObjects];
                [self.guangGuangDataProvider.productsUrlArr removeAllObjects];
                [self.guangGuangDataProvider.products_IDArr removeAllObjects];
                [self.guangGuangDataProvider.productsDetailInfoArr removeAllObjects];
                self.guangGuangDataProvider.page_Int  = 0;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.guangGuangDataProvider requestData];
                    [self addHeaderToGuangGuangCollectionView];
                    //点击后隐藏btnCategoryView
                    self.btnCategoryView.hidden = YES;
                    viewIsHidden = 1;
                });
                
            });
            
        }
    }
    
    
}
#pragma mark 添加分类按钮到导航栏
-(void)addCategoryBtnToNav
{
    //添加分类按钮
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KScreenWidth - 20, 46, 40, 30);
    [button setTitle:@"分类" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(categorizeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *categorizeBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem =categorizeBtn;// 设置分类按钮
    }
#pragma mark 分类按钮Action
-(void)categorizeBtnAction:(UIButton*)sender
{
        [self genieToRect:sender.frame edge:BCRectEdgeBottom];
}
- (void) genieToRect: (CGRect)rect edge: (BCRectEdge) edge
{
   
    NSTimeInterval duration = 0.65;
    
    CGRect endRect = CGRectInset(rect, 5.0, 5.0);

    if (viewIsHidden) {
        self.btnCategoryView.hidden= NO;
        [self.btnCategoryView genieOutTransitionWithDuration:duration startRect:endRect startEdge:edge completion:^{
            self.btnCategoryView.userInteractionEnabled = YES;
           
            
        }];
        viewIsHidden =0;
    }
    else
    {
        [self.btnCategoryView genieInTransitionWithDuration:duration destinationRect:endRect destinationEdge:edge completion:^{
            
        }];
        viewIsHidden=1;
    }
    

}

#pragma mark 在婚饰页面添加滚动视图
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
#pragma mark //添加逛逛view 主题页面
-(void)addGuangGuangAndTheme
{
    //逛逛view
    UIView *guangguangView = [[UIView alloc] init];
    guangguangView.frame = CGRectMake(0, -64, KScreenWidth, KScreenHeight-64-49);
    //view.backgroundColor = [UIColor redColor];
    [self.sliderScrollView addSubview:guangguangView];
    [self.sliderScrollView addSubview:self.guangGuangCollectionView];
    
    
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //如果是guangGuangCollectionView向上拉的时候隐藏分类面板
    if ([scrollView isEqual:self.guangGuangCollectionView])
    {
        [self.btnCategoryView setHidden:YES];
        viewIsHidden = 1;
        
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.sliderScrollView])
    {
        if (scrollView.contentOffset.x==0)
        {
            self.segmentedControl.selectedSegmentIndex =0;
            viewIsHidden =1;
            [self addCategoryBtnToNav];
            
        }else if (scrollView.contentOffset.x==320)
        {
            self.segmentedControl.selectedSegmentIndex =1;
            
            viewIsHidden = 0;
            self.navigationItem.rightBarButtonItem = nil;
            
            static int switchIndex = 1;
            if (switchIndex)
            {
                //请求主题数据
                self.themeDataProvider = [[GGThemeDataProvider alloc] init];
                [self.themeDataProvider requestImageThemeData];
                switchIndex = 0;
            }
           
        }
        
        [self.btnCategoryView setHidden:YES];
    }
    
    
    
}
#pragma mark 在导航栏上添加segementController
- (UISegmentedControl*)addSegementView
{
    UISegmentedControl *segementTitleView =[[UISegmentedControl alloc] initWithItems:@[@"逛逛",@"主题"]];
    
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
#pragma mark 向通知中心注册观察者 给主题页面提供信息
-(void)addNotification
{
    //向通知中心注册观察者 给主题页面提供信息
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [[NSNotificationCenter defaultCenter]
     addObserverForName:@"THEMEDATADFINISH" object:nil queue:mainQueue usingBlock:^(NSNotification *note)
     {
         NSLog(@"我收到了");
         
         
          NSDictionary *dict = [note userInfo];
         self.themeImageUrlArr = [dict objectForKey:@"cover_path"];//主题图片url
         self.themeIDArr = [dict objectForKey:@"id"];//id
         self.themeTitleArr = [dict objectForKey:@"title"];//主题标题
         
         
         
         //添加主题页面
         static int switchIndex = 1;
         if (switchIndex)
         {
             UIView *themeView = [[UIView alloc] init];
             themeView.frame = CGRectMake(320, -64, KScreenWidth, KScreenHeight-64-49);
             themeView.backgroundColor = [UIColor yellowColor];
             [self.sliderScrollView addSubview:themeView];
             
             self.themeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-49-64) style:UITableViewStylePlain];
             self.themeTableView.backgroundColor = [UIColor redColor];
             [themeView addSubview:themeTableView];
             self.themeTableView.delegate = self;
             self.themeTableView.dataSource = self;
             [self addHeaderRefreshToThemeTableView];//添加下拉刷新
             [self addFooterRefreshToThemeTableView];//添加上拉加载
             switchIndex = 0;
         }

        
     }];
    
}
-(void)addFooterRefreshToThemeTableView
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.themeTableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        if (vc.themeDataProvider) {
            
            [vc.themeDataProvider requestImageThemeData];
        }
        
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.themeTableView reloadData];
            // 结束刷新
            [vc.themeTableView footerEndRefreshing];
        });
    }];

}
-(void)addHeaderRefreshToThemeTableView
{
    __unsafe_unretained typeof(self) vc = self;
    [self.themeTableView addHeaderWithCallback:^{
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.themeTableView reloadData];
            // 结束刷新
            [vc.themeTableView headerEndRefreshing];
        });


    }];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.themeTableView headerBeginRefreshing];
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
