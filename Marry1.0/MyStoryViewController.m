//
//  MyStoryViewController.m
//  Marry1.0
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "MyStoryViewController.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
@interface MyStoryViewController ()

@end
static BOOL isRegister = NO;
@implementation MyStoryViewController
@synthesize managedObjectContext;
@synthesize storyTableView;
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
    isRegister = NO;
    titleArr = [[NSMutableArray alloc] init];
    imageArr = [[NSMutableArray alloc] init];
    timeArr = [[NSMutableArray alloc] init];
    
    self.managedObjectContext =  ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    title.font =[UIFont boldSystemFontOfSize:18];//默认大小粗体字
    title.textColor = [UIColor whiteColor];
    title.text = @"我的故事";
    self.navigationItem.titleView = title;
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(0, 0, 30, 20);
    [moreBtn setImage:[UIImage imageNamed:@"nav_menu_icon@2x"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(openButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    self.navigationItem.leftBarButtonItem = moreItem;
    
    
    
    
    
   self.storyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-49) style:UITableViewStylePlain];
    self.storyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.storyTableView.delegate =self;
    self.storyTableView.dataSource = self;
    [self.view addSubview:self.storyTableView];
    
    [self addHeaderRefresh];
}
-(void)refreshData
{
    [titleArr removeAllObjects];
    [imageArr removeAllObjects] ;
    [timeArr removeAllObjects];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoryData"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error=nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (StoryData *info in fetchedObjects)
    {
        [imageArr insertObject:[UIImage imageWithData:info.storyImage] atIndex:0];
        [titleArr insertObject:info.storyTitle atIndex:0];
        [timeArr insertObject:info.storyDate atIndex:0];
        
    }


}
-(void)addHeaderRefresh
{
    
    
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.storyTableView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        [vc refreshData];
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.storyTableView reloadData];
            // 结束刷新
            [vc.storyTableView headerEndRefreshing];
        });
        //}
        
    }];
    

    [self.storyTableView headerBeginRefreshing];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imageArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellCell";
    
    if (!isRegister)
    {
        UINib *nib = [UINib nibWithNibName:@"CreateStoryCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        isRegister = YES;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *titleLabel = (UILabel*)[cell.contentView viewWithTag:11];
    UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:12];
    titleLabel.text =[titleArr objectAtIndex:indexPath.row];
    
    CGSize newSize = CGSizeMake(KScreenWidth, 198);//（需要裁剪的size大小）
    UIGraphicsBeginImageContext(newSize);
    [[imageArr objectAtIndex:indexPath.row] drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView.image = newImage;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *timeLabel = (UILabel*)[cell.contentView viewWithTag:13];
    timeLabel.text = [timeArr objectAtIndex:indexPath.row];
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}
- (void)openButtonPressed
{
   
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
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
