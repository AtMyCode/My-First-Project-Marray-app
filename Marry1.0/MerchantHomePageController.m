//
//  MerchantHomePageController.m
//  Marry1.0
//
//  Created by apple on 14-10-3.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "MerchantHomePageController.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH KScreenWidth
#define CELL_CONTENT_MARGIN 10.0f

@interface MerchantHomePageController ()

@end

@implementation MerchantHomePageController

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initNavTitle];//页面标题
    
    //logo
    logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 130, 80)];
    //logoImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:logoImageView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 130, 30)];
    nameLabel.adjustsFontSizeToFitWidth = YES;
    //nameLabel.backgroundColor = [UIColor blueColor];
    [self.view addSubview:nameLabel];
    
    propertsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 120, 70, 30)];
    propertsNameLabel.font= [UIFont systemFontOfSize:12];
    //propertsNameLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:propertsNameLabel];
    
    fans_label = [[UILabel alloc] initWithFrame:CGRectMake(240, 120, 70, 30)];
    fans_label.font = [UIFont systemFontOfSize:12];
    //fans_label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:fans_label];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"简介",@"作品"]];
    segmentedControl.frame = CGRectMake(KScreenWidth/2-(KScreenWidth-20)/2, 160, KScreenWidth-20, 30);
    [segmentedControl addTarget:self action:@selector(segementTouchSwitchAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex=0;
    [self.view addSubview:segmentedControl];
    
    
    //添加滚动视图
    sliderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 195, KScreenWidth, KScreenHeight-64-131)];
    [sliderScrollView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    [sliderScrollView setShowsHorizontalScrollIndicator:NO];
    [sliderScrollView setShowsVerticalScrollIndicator:NO];
    [sliderScrollView setPagingEnabled:YES];
    [sliderScrollView setBounces:NO];
    [sliderScrollView setContentSize:CGSizeMake(KScreenWidth*2, 0)];
    [sliderScrollView setDelegate:self];
    [self.view addSubview:sliderScrollView];
    [sliderScrollView setBackgroundColor:[UIColor yellowColor]];
    
    hintArr = @[@"地址",@"简介",@"微博",@"QQ",@"微信",@"城市",@"经营范围",@"电话"];
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
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return merchantDetailArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 30)];
        hintLabel.tag = 11;
        hintLabel.font= [UIFont systemFontOfSize:FONT_SIZE];
        
        [cell.contentView addSubview:hintLabel];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 30)];
        [contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [contentLabel setMinimumScaleFactor:FONT_SIZE];
        [contentLabel setNumberOfLines:0];
        [contentLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        
        contentLabel.tag=12;
        [cell.contentView addSubview:contentLabel];
    }
    
    UILabel *hintLabel = (UILabel*)[cell.contentView viewWithTag:11];
    hintLabel.text =[hintArr objectAtIndex:indexPath.row];
    
    
    NSString *text= [merchantDetailArr objectAtIndex:[indexPath row]];
    

    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]
                                                                                                     }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;

    UILabel *contentLabel = (UILabel*)[cell.contentView viewWithTag:12];
    [contentLabel setText:text];
    [contentLabel setFrame:CGRectMake(CELL_CONTENT_MARGIN+80, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2)-80, MAX(size.height, 44.0f))];
    
    
    
    hintLabel.frame = CGRectMake(10, MAX(size.height, 44.0f)/2-15+CELL_CONTENT_MARGIN,70, 30);
    

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *text = [merchantDetailArr objectAtIndex:[indexPath row]];
    
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
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

-(void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    title.font =[UIFont boldSystemFontOfSize:18];//默认大小粗体字
    title.textColor = [UIColor whiteColor];
    title.text = @"商家主页";
    self.navigationItem.titleView = title;
}
#pragma  mark  点击切换逛逛和主题页面
-(void)segementTouchSwitchAction:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        
        
        [sliderScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else
    {
        
        
        [sliderScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
        
    }
    
}
#pragma mark
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == sliderScrollView)
    {
        if (scrollView.contentOffset.x ==0) {
            
            segmentedControl.selectedSegmentIndex = 0;
        }
        else if (scrollView.contentOffset.x==320)
        {
            segmentedControl.selectedSegmentIndex = 1;
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
