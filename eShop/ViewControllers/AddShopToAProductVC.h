//
//  AddShopToAProduct.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalViewDelegate;

@interface AddShopToAProductVC : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>{
    
    id<ModalViewDelegate> delegate;
    
}


@property id<ModalViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *pckPendingProducts;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectShop;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (strong, nonatomic) UITapGestureRecognizer *singleTap;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UINavigationItem *barTop;

@property NSArray *arrProductPendingShops;


@end
