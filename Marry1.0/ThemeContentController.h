//
//  ThemeContentController.h
//  Marry1.0
//
//  Created by apple on 14-10-1.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuangCollectionCell.h"
#import "ThemeImageDetailVCViewController.h"
#import "HSBuyDataProvider.h"
@interface ThemeContentController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIActivityIndicatorView *indicatorView;
    
    NSString * urlBuyString;
}
@property(retain,nonatomic)NSMutableArray *themeContentImagesURLArr; //图片路径

@property(retain,nonatomic) NSMutableArray *themeContentLikeCountArr;//喜欢计数

@property(retain,nonatomic) NSMutableArray *themeContentPriceArr;//价格
@property(retain,nonatomic)NSMutableArray *themeSubject_descArr;//商品描述
@property(retain,nonatomic)NSMutableArray *themeContentID;
@end
