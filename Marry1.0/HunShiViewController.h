//
//  HunShiViewController.h
//  Marry1.0
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Genie.h"
#import "GuangGuangDataProvider.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ClickImageDisplayDetailViewController.h"
#import "MainTarBarViewController.h"
#import "GGThemeDataProvider.h"
#import "ThemeContentController.h"
#import "GGThemeContentImageProvider.h"
@interface HunShiViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    int viewIsHidden;
    
    NSMutableArray *productsLike_CountArr;//产品的喜欢次数
    NSMutableArray *productsPriceArr;//价格
    NSMutableArray *productsUrlArr;//图片的url
    NSMutableArray *productsID;//id
    NSMutableArray *productsDetailInfoArr;//商品信息
    NSMutableArray *productsLikeNumArr;//是否喜欢
    
    

}
@property(retain,nonatomic)UISegmentedControl *segmentedControl;//主题和逛逛页面的segment
@property (retain, nonatomic)UIScrollView *sliderScrollView;//滚动视图
@property(retain,nonatomic)UIView *btnCategoryView; //分类按钮面板
@property(retain,nonatomic)NSArray *categoryBtnArray;//分类按钮
@property(retain,nonatomic)UICollectionView *guangGuangCollectionView;//逛逛的页面collectionview
@property(retain,nonatomic)GuangGuangDataProvider *guangGuangDataProvider;//逛逛数据提供者

@property(retain,nonatomic)Reachability *reachability;;

@property(retain,nonatomic)NSMutableArray *themeImageUrlArr;//主题图片url

@property(retain,nonatomic)NSMutableArray *themeIDArr;//id
@property(retain,nonatomic)NSMutableArray *themeTitleArr;//主题标题
@property(retain,nonatomic) UITableView *themeTableView;//主题tableview
@property(retain,nonatomic)GGThemeDataProvider *themeDataProvider;
@end
