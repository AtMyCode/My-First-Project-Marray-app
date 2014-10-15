//
//  GuangGuangDataProvider.h
//  Marry1.0
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuangGuangDataProvider : NSObject
@property(retain,nonatomic)NSMutableArray *productsPriceArr;//产品价格
@property(retain,nonatomic)NSMutableArray *productsUrlArr; //产品url
@property(retain,nonatomic)NSMutableArray *productsLike_CountArr;//产品的喜欢数
@property(retain,nonatomic)NSMutableArray *productsLikeNumArr;//喜爱个数
@property(retain,nonatomic)NSMutableArray *products_IDArr;
@property(assign,nonatomic)int categoryIndex;
@property(assign,nonatomic)int page_Int;//上拉加载下一页

@property(retain,nonatomic)NSMutableArray *productsDetailInfoArr;
-(void)requestData;


@end
