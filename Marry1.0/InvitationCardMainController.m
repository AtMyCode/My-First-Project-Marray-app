//
//  InvitationCardMainController.m
//  Marry1.0
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "InvitationCardMainController.h"
#import "TWTSideMenuViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface InvitationCardMainController ()

@end

@implementation InvitationCardMainController
@synthesize imageScrollView;


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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(invitationCardURLNotifi:) name:@"invitationCardURLArr" object:nil];
    InvitationCardDataProvider *dataProvider = [[InvitationCardDataProvider alloc] init];
    [dataProvider requesInvitationCardtData];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    title.font =[UIFont boldSystemFontOfSize:18];//默认大小粗体字
    title.textColor = [UIColor whiteColor];
    title.text = @"请帖展";
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(0, 0, 30, 20);
    [moreBtn setImage:[UIImage imageNamed:@"nav_menu_icon@2x"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(openButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    
    //UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Open" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    self.navigationItem.leftBarButtonItem = moreItem;
    
    
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-49-64)];
   
    [self.view addSubview:self.imageScrollView];
    
    
    numLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth-60, 80, 50, 30)];
    //numLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:numLabel];
    
    }
#pragma mark 通知
-(void)invitationCardURLNotifi:(NSNotification*)note
{
    
    NSLog(@"我收到请帖了");
   invitationUrlArr =  [[note userInfo] objectForKey:@"invitationCardURLArr"];
   // NSLog(@"url %@",urlArr);
    
    //添加滚动视图
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-49-64-60)];
    [self.imageScrollView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    [self.imageScrollView setShowsHorizontalScrollIndicator:NO];
    [self.imageScrollView setShowsVerticalScrollIndicator:NO];
    [self.imageScrollView setPagingEnabled:YES];
    [self.imageScrollView setBounces:NO];
    [self.imageScrollView setContentSize:CGSizeMake(KScreenWidth*[invitationUrlArr count], 0)];
    [self.imageScrollView setDelegate:self];
    
    [self.view addSubview:self.imageScrollView];
    
    UIImageView *imageOne = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/2-100 ,64, 200, 350)];
    
    [imageOne setImageWithURL:[NSURL URLWithString:[invitationUrlArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imageScrollView addSubview:imageOne];
    totlalPage = [invitationUrlArr count];
    
    currentPage = 1;
    numLabel.text = [NSString stringWithFormat:@"%d/%d",currentPage,totlalPage];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(KScreenWidth/2-100+10, 450, 35, 35);
    [editBtn setImage:[UIImage imageNamed:@"card_basicinfo@2x"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtn];
    
    UIButton *takeAPictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takeAPictureBtn.frame = CGRectMake(KScreenWidth/2-100+80, 450, 35, 35);
    [takeAPictureBtn setImage:[UIImage imageNamed:@"card_cover@2x"] forState:UIControlStateNormal];
    [takeAPictureBtn addTarget:self action:@selector(takeAPhotoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takeAPictureBtn];
    
    UIButton *shardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shardBtn.frame = CGRectMake(KScreenWidth/2-100+150, 450, 35, 35);
    [shardBtn setImage:[UIImage imageNamed:@"card_photos@2x"] forState:UIControlStateNormal];
    [shardBtn addTarget:self action:@selector(shardBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shardBtn];

}
#pragma mark edit
-(void)editBtn
{
    
}
#pragma mark shard
-(void)shardBtn
{
    
}
#pragma mark 
-(void)takeAPhotoBtn
{
    
}
- (void)openButtonPressed
{
    
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    
    startContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    
    willEndContentOffsetX = scrollView.contentOffset.x;
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    endContentOffsetX = scrollView.contentOffset.x;
    
    if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { //画面从右往左移动，前一页
        numLabel.text = [NSString stringWithFormat:@"%d/%d",--currentPage,totlalPage];
//        if (currentPage<totlalPage) {
//            NSLog(@"前一页");
//            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/2+KScreenWidth*currentPage-100 ,64, 200, 350)];
//            image.backgroundColor = [UIColor redColor];
//            [image setImageWithURL:[NSURL URLWithString:[invitationUrlArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//            [self.imageScrollView addSubview:image];
//            currentPage++;
//
//        }
        
    } else if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {//画面从左往右移动，后一页
        NSLog(@"后一页");
        if (currentPage<totlalPage) {
            
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/2+KScreenWidth*currentPage-100 ,64, 200, 350)];
            
            [image setImageWithURL:[NSURL URLWithString:[invitationUrlArr objectAtIndex:currentPage]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [self.imageScrollView addSubview:image];
            currentPage++;
            numLabel.text = [NSString stringWithFormat:@"%d/%d",currentPage,totlalPage];
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
