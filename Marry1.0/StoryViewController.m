//
//  StoryViewController.m
//  Marry1.0
//
//  Created by apple on 14-10-6.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "StoryViewController.h"
#import "MJRefresh.h"
@interface StoryViewController ()

@end

@implementation StoryViewController
@synthesize storyTableView,dataProvider;
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
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    indicator.frame = CGRectMake(0, 0, 40, 40);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storyDataNofi:) name:@"storyDataNotifi" object:nil];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    title.font =[UIFont boldSystemFontOfSize:18];//默认大小粗体字
    title.textColor = [UIColor whiteColor];
    title.text = @"故事精选";
    self.navigationItem.titleView = title;
    //创建数据提供者
    self.dataProvider = [[StoryDataProvider alloc] init];
    [self.dataProvider requestStoryData];
    //创建tableview
    self.storyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64-49) style:UITableViewStylePlain];
    self.storyTableView.delegate =self;
    self.storyTableView.dataSource =self;
    [self.storyTableView setSeparatorStyle:0];
    [self addFooterRefresh];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"精选故事" style:UIBarButtonItemStyleBordered target:self action:nil];
}
-(void)storyDataNofi:(NSNotification*)note
{
    NSLog(@"我收到故事的通知啦");
    [indicator stopAnimating];
    NSDictionary *dict = [note userInfo];
    imageURL = [dict objectForKey:@"cover_path"];
    titleArr = [dict objectForKey:@"title"];
    avatarArr = [dict objectForKey:@"avatar"];
    praise_countArr = [dict objectForKey:@"praise_count"];
    storyId = [dict objectForKey:@"id"];
     //设置分割线为none
    [self.view addSubview:self.storyTableView];
    
    
}
-(void)addFooterRefresh
{
    // 添加上拉刷新尾部控件
    __unsafe_unretained typeof(self) vc = self;

    [self.storyTableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
       [vc.dataProvider requestStoryData];
        
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.storyTableView reloadData];
            // 结束刷新
            [vc.storyTableView footerEndRefreshing];
        });
    }];

}
#pragma mark UITableViewDataSoucre
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imageURL.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"MyCell";
    static BOOL isRegister= NO;
    if (!isRegister) {
        UINib *nib = [UINib nibWithNibName:@"StoryCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:identifer];
        isRegister = YES;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:11];
   
    //圆角设置
    
    imageView.layer.cornerRadius
    = 15;//(值越大，角就越圆)
    
    imageView.layer.masksToBounds= YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[imageURL objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        UILabel *titleLabel =(UILabel*)[cell viewWithTag:12];
    titleLabel.text = [titleArr objectAtIndex:indexPath.row];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    
    UIImageView *avatarImageView = (UIImageView*)[cell viewWithTag:13];
    
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:[avatarArr objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    CALayer *roundedLayer = [avatarImageView layer];
    [roundedLayer setMasksToBounds:YES];
    roundedLayer.cornerRadius = 47/2.0;
    roundedLayer.borderColor = [[UIColor grayColor] CGColor];
    
    UILabel *praiseLabel = (UILabel*)[cell viewWithTag:14];
    praiseLabel.text =[NSString stringWithFormat:@"%d",[[praise_countArr objectAtIndex:indexPath.row] intValue]] ;
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"我选择了%d",indexPath.row);
    StoryDetailDataProvider *detailDataProvider =[[StoryDetailDataProvider alloc] init];
    [detailDataProvider requestDetailData:[[storyId objectAtIndex:indexPath.row] intValue]];
    StoryContentController *storyContentVC = [[StoryContentController alloc] init];
    [self.navigationController pushViewController:storyContentVC animated:YES];
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
