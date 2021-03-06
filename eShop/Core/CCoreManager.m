//
//  CCoreManager.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "CCoreManager.h"
#import "CDatabase.h"
#import "CShop.h"
#import "CProduct.h"

static CShop *cAtiveShop;
static CProduct *cAtiveProduct;

@implementation CCoreManager

@synthesize arrShops;

-(id)init {
    if ( self = [super init] ) {
        self.arrShops = [[NSMutableArray alloc]init];
        cAtiveShop=nil;
        cAtiveProduct=nil;
    }
    return self;
}


+(void) setActiveShop:(CShop*) r_CShop{
    
  cAtiveShop=r_CShop;
}

+(CShop*) getActiveShop{
    
    //Check if there was an active shop
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return cAtiveShop;
}

+(NSMutableArray*) getShopPriceList{
    
    //Check if there was an active shop
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase getShopPriceList:cAtiveShop];
}

+(NSMutableArray*) getShopsList{
    return [CDatabase getShopsList];
}

+(NSMutableArray*) getShopNotExistingProducts{

    //Check if there was an active shop
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase getShopNotExistingProducts:cAtiveShop];

}

+(int) getNumberShopNotExistingProducts{
    
    //Check if there was an active shop
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase getNumberShopNotExistingProducts:cAtiveShop];
    
}

+(void) insertProductPrice:(CProductPrice*)p_cProductPrice{
    
    CShop *cShop = [CCoreManager getActiveShop];
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase insertProductPrice:p_cProductPrice inShop:cShop];
}

+(void) updateProductPrice:(CProductPrice*)p_cProductPrice{
    
    CShop *cShop = [CCoreManager getActiveShop];
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase updateProductPrice:p_cProductPrice inShop:cShop];
}

+(void) deleteProductPrice:(CProductPrice*)p_cProductPrice{
    
      return [CDatabase deleteProductPrice:p_cProductPrice];
}

+(void) deleteShop{
 
    CShop *cShop = [CCoreManager getActiveShop];
    if(cAtiveShop==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase deleteShop:cShop];
}

+(void) updateShop:(CShop*) p_CShop{
    
    [CDatabase updateShop:p_CShop];
    [CCoreManager setActiveShop:p_CShop];
}


+(void) addShop:(CShop*) p_CShop{
    
    [CDatabase addShop:p_CShop];
}

+(CShop*) getShopById:(CShop*) p_CShop{
    
    return [CDatabase getShopById:p_CShop];
    
}



-(NSArray*) listShop
{
    return arrShops;
}


+(void) setActiveProduct:(CProduct*) r_CProduct{
    
    cAtiveProduct=r_CProduct;
}

+(CProduct*) getActiveProduct{
    
    //Check if there was an active shop
    if(cAtiveProduct==nil){
        [NSException raise:@"No active Product" format:@"cProductZhop is nul"];
    }
    
    return cAtiveProduct;
}

+(NSMutableArray*) getProductPriceList{
    
    //Check if there was an active shop
    if(cAtiveProduct==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase getProductPriceList:cAtiveProduct];
}

+(NSMutableArray*) getProductsList{
    return [CDatabase getProductsList];
}

+(NSMutableArray*) getProductNotExistingShops{
    
    //Check if there was an active shop
    if(cAtiveProduct==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase getProductNotExistingShops:cAtiveProduct];
    
}

+(int) getNumberProductNotExistingShops{
    
    //Check if there was an active shop
    if(cAtiveProduct==nil){
        [NSException raise:@"No active Product" format:@"cAtiveProduct is nul"];
    }
    
    return [CDatabase getNumberProductNotExistingShops:cAtiveProduct];
    
}

+(void) insertShopPrice:(CProductPrice*)p_cProductPrice{

    
    if(cAtiveProduct==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }

    return [CDatabase insertShopPrice:p_cProductPrice inProduct:cAtiveProduct];
}

+(void) updateShopPrice:(CProductPrice*)p_cProductPrice{
    
    
    if(cAtiveProduct==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase updateShopPrice:p_cProductPrice inProduct:cAtiveProduct];
}

+(void) deleteProduct{

    if(cAtiveProduct==nil){
        [NSException raise:@"No active shop" format:@"cAtiveshop is nul"];
    }
    
    return [CDatabase deleteProduct:cAtiveProduct];
}

+(void) updateProduct:(CProduct *)p_CProduct{
    
    [CDatabase updateProduct:p_CProduct];
    [CCoreManager setActiveProduct:p_CProduct];
}

+(void) addProduct:(CProduct*) p_CProduct{
    
    [CDatabase addProduct:p_CProduct];
    
}

+(CProduct*) existsProduct:(CProduct*) p_CProduct{
    return [CDatabase existsProduct:p_CProduct];
}

+(NSMutableArray*) getProductsMinList{
    return [CDatabase getProductsMinList];
}

+(void) setNextProductState:(CProduct*) p_CProduct{


  
  // Change next state
    p_CProduct.tProdStatus++;
    if(p_CProduct.tProdStatus>=MAX_PROD_STATE) p_CProduct.tProdStatus=0;

    
  
  // Update product in DDBB
    [CDatabase updateProduct:p_CProduct];

}

@end
