//
//  WeddingProcessController.m
//  Marry1.0
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "WeddingProcessController.h"

@interface WeddingProcessController ()

@end

@implementation WeddingProcessController

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
    
    
    titleArr = @[@"结婚进度表",@"婚礼当天流程",@"婚礼登记需要哪些材料",@"结婚请柬的措辞",@"新娘美容纪要",@"选择伴娘七项注意",@"令婚礼完美的细节",@"喜宴上新人应酬技巧",@"婚宴时的注意事项",@"新人致答谢词"];
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth/2-(KScreenWidth-30)/2, 90, KScreenWidth-30, KScreenHeight-49-64-40)];
    background.backgroundColor = [UIColor colorWithRed:227/255.0 green:112/255.0 blue:138/255.0 alpha:1.0];
    background.layer.borderWidth = 10;
    background.layer.cornerRadius = 10;
    background.layer.masksToBounds
    = YES;
    background.layer.borderColor = [[UIColor colorWithRed:227/255.0 green:112/255.0 blue:138/255.0 alpha:1.0] CGColor];
    
    [self.view addSubview:background];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,-54, KScreenWidth-30, KScreenHeight-49-40) style:UITableViewStylePlain];
    tableView.layer.cornerRadius = 20;
    tableView.layer.masksToBounds
    = YES;
    tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:183/255.0 blue:193/255.0 alpha:0.8];
    //tableView.layer.borderColor = [[UIColor colorWithRed:227/255.0 green:112/255.0 blue:138/255.0 alpha:1.0] CGColor];
    //tableView.backgroundColor = [UIColor colorWithRed:227/255.0 green:112/255.0 blue:138/255.0 alpha:1.0];
    tableView.delegate =self;
    tableView.dataSource=self;
    [background addSubview:tableView];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor colorWithRed:227/255.0 green:112/255.0 blue:138/255.0 alpha:1.0];
    }
   
    
    
    cell.textLabel.text = [titleArr objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeddingProcessGuideViewController *guide = [[WeddingProcessGuideViewController alloc] init];
    guide.processTitle = [titleArr objectAtIndex:indexPath.row];
    guide.row = indexPath.row;
    [self.navigationController pushViewController:guide animated:YES];
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
