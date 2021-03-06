//
//  CProductPrice.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CProduct.h"

@interface CProductPrice : CProduct
typedef enum Category : NSUInteger {
    VeryCheap,
    Cheap,
    Normal,
    Expensive,
    VeryExpensive
} ShapeType;

//@property int iId;
//@property (strong,nonatomic) NSString *sName;
@property float fPrice;
@property (nonatomic) enum Category tCategory;
@property NSString *sShopId;
@property NSString *sShopName;
@property NSString *sShopLocation;

@end
