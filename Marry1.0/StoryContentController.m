//
//  StoryContentController.m
//  Marry1.0
//
//  Created by Ibokan on 14-10-8.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "StoryContentController.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH KScreenWidth
#define CELL_CONTENT_MARGIN 10.0f
@interface StoryContentController ()

@end

@implementation StoryContentController
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
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    indicator.frame = CGRectMake(0, 0, 40, 40);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailDataNotifi:) name:@"detailDataNotifi" object:nil];
    
    //分享按钮
    UIButton *shardBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [shardBtn setImage:[UIImage imageNamed:@"productDetailShare@2x"] forState:UIControlStateNormal];
    [shardBtn addTarget:self action:@selector(shardAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shardBtn];
    
    
}

#pragma mark UITableViewDataSoucre
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mediaPathArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"Cell";
    //自定义cell类
    StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StoryTableViewCell alloc] initWithStyle:0 reuseIdentifier:CellIdentifier];
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 30)];
        [contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [contentLabel setMinimumScaleFactor:FONT_SIZE];
        [contentLabel setNumberOfLines:0];
        [contentLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        
        contentLabel.tag=100;
        [cell.contentView addSubview:contentLabel];
    }
    @try {
        [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:[mediaPathArr objectAtIndex:indexPath.row] ]placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    NSString *text= [descriptionArr objectAtIndex:indexPath.row];
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]
                                                                                                     }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    UILabel *contentLabel = (UILabel*)[cell.contentView viewWithTag:100];
    [contentLabel setText:text];
    [contentLabel setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN+180, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *text = [descriptionArr objectAtIndex:[indexPath row]];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:FONT_SIZE] forKey:NSFontAttributeName];
    
    
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]
         initWithString:text
         attributes:attributes];
  
    
   
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return 180+height + (CELL_CONTENT_MARGIN * 2);
}

#pragma mark 通知
-(void)detailDataNotifi:(NSNotification*)note
{
    
    NSLog(@"我收到。。。。。。。。。。。。");
    [indicator startAnimating];
    NSDictionary *dict = [note userInfo];
    mediaPathArr = [dict objectForKey:@"media_path"];
    descriptionArr = [dict objectForKey:@"description"];
    NSLog(@"%@",descriptionArr);
    self.storyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64,KScreenWidth,KScreenHeight - 49-64)];
    self.storyTableView.delegate = self;
    //    //数据源
    self.storyTableView.dataSource = self;
    [self.view addSubview:self.storyTableView];
    
}
#pragma mark shard
-(void)shardAction
{
    NSLog(@"分享");
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
