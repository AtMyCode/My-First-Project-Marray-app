//
//  ThemeContentController.m
//  Marry1.0
//
//  Created by apple on 14-10-1.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "ThemeContentController.h"

@interface ThemeContentController ()

@end

@implementation ThemeContentController
@synthesize themeContentImagesURLArr,themeSubject_descArr,themeContentPriceArr,themeContentLikeCountArr;
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
    //向通知中心注册 并初始化数组
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center = self.view.center;
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ThemeDataContentNotiction:) name:@"THEMEContentDATADFINISH" object:nil];
  
    

}
-(void)ThemeDataContentNotiction:(NSNotification*)note
{
    NSLog(@"Theme Content 的 Arr 拿到了！");
    [indicatorView stopAnimating];
    NSDictionary *dict =  [note userInfo];
    self.themeContentPriceArr = [dict objectForKey:@"price"];
    self.themeSubject_descArr = [dict objectForKey:@"subject_desc"];
    self.themeContentLikeCountArr = [dict objectForKey:@"like_count"];
    self.themeContentImagesURLArr = [dict objectForKey:@"photo_path"];
    //        NSLog(@"%@,%@,%@,%@",[themeContentLikeCountArr objectAtIndex:0],[themeContentImagesURLArr objectAtIndex:0],[themeContentPriceArr objectAtIndex:0],[themeSubject_descArr objectAtIndex:0]);
    
    [self addCollectionView];//添加collectionview
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"THEMEContentDATADFINISH" object:nil];
}
-(void)addCollectionView
{
    //
        //创建UICollectionView
        UICollectionViewFlowLayout *layout  =[[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(150, 160);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 10;
        UICollectionView *imagesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth,KScreenHeight-64-49) collectionViewLayout:layout];
        imagesCollectionView.backgroundColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1];
        
        //self.view.backgroundColor = [UIColor yellowColor];
        
        [imagesCollectionView registerClass:[GuangCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        imagesCollectionView.delegate = self;
        imagesCollectionView.dataSource = self;
        [self.view addSubview:imagesCollectionView];
   //
    
}
#pragma mark CollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.themeContentLikeCountArr count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    GuangCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.imageView sd_setImageWithURL:[self.themeContentImagesURLArr objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",[self.themeContentPriceArr objectAtIndex:indexPath.row] ];
    cell.loveCountLabel.text = [NSString stringWithFormat:@"%@",[self.themeContentLikeCountArr objectAtIndex:indexPath.row]];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ThemeImageDetailVCViewController *detailVC = [[ThemeImageDetailVCViewController alloc] init];
    detailVC.productsDetailStr= [self.themeSubject_descArr objectAtIndex:indexPath.row];
    detailVC.productsPrice = [[self.themeContentPriceArr objectAtIndex:indexPath.row] floatValue];
    [detailVC setValue:self.themeContentImagesURLArr forKey:@"imageArr"];
    [detailVC dispalyImageAndDetailLabel:indexPath.row];
   
    [self.navigationController pushViewController:detailVC animated:YES];
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
