//
//  ShopsListVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ShopsListVC.h"
//#import "AppDelegate.h"
#import "ShopViewCell.h"
#import "CShop.h"
#import "CProductPrice.h"
#import "CCoreManager.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"

static ShopsListVC *sharedInstance;

@interface ShopsListVC ()

@end

@implementation ShopsListVC

@synthesize arrShops;
@synthesize tbvShops;


-(id) init{
    if(sharedInstance){
        NSLog(@"Error: You are creating a second AppDelegate. Bad Panda!");
    }
    
    self=[super init];
    
    //Initialize singleton class
    sharedInstance=self;
    
    
    
    return self;
}

//Return a reference of this class
+(ShopsListVC *) sharedViewController{
    
    return sharedInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [[GAI sharedInstance].defaultTracker set:kGAIScreenName
                                       value:@"Shop List"];
    // Send the screen view.
    [[GAI sharedInstance].defaultTracker
     send:[[GAIDictionaryBuilder createAppView] build]];
    
    // This class implements DataSource and Delegate callbacks
    [self.tbvShops setDataSource:self];
    [self.tbvShops setDelegate:self];
    // Assign our own backgroud for the view
/*    UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    [self.tbvShops setBackgroundView:bview];
  */
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    self.tbvShops.backgroundColor = background;
    
    //Set tittle text
    [self.barTop setTitle:NSLocalizedString(@"SHOP_LIST", nil)];
    
    //Request to AppDelegate list of avaliable shops
    //AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    arrShops = [CCoreManager getShopsList];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// BEGIN: Methods to implement for fulfill CollectionView Interface
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrShops count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    static NSString *CellIdentifier = @"CellShopId";
    
    
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CShop *currShop = [arrShops objectAtIndex:indexPath.row];
    
    [cell.lblName setText:[NSString stringWithFormat:@"%@ (%@)",currShop.sName,currShop.sId]];
    [cell.lblLocation setText:[NSString stringWithFormat:@"%@",currShop.sLocation]];
    
    
    if([currShop.dPicture length]>0){
        cell.imgShopPict.image= [UIImage imageWithData:currShop.dPicture ];
    }
    else{
        cell.imgShopPict.image= [UIImage imageNamed:@"NoPictSM"];
        
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CShop* cCurrShop;
    
    // Get the current shop
    cCurrShop = [arrShops objectAtIndex:indexPath.row];
    
    //Notify CoreManager which is the active shop
    [CCoreManager setActiveShop:cCurrShop];
    
    [self performSegueWithIdentifier:@"showPriceProducts2" sender:self.view];
    
   
 
}

//end: Methods to implement for fulfill CollectionView Interface

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showPriceProducts2"]){
 /*
        //Create a new prescription object
        Prescription *prescription;
        prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:tDosis Image:uiImageView.image];
        
        //Notify the model
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        [appDelegate addPrescription:prescription];
 */       
    }
}

-(void) refreshShopList{
    //Request to Core manager for prices of current shop
    //AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    arrShops = [CCoreManager getShopsList];
    
    //Refresh whole table
    [self.tbvShops reloadData];
}



@end
