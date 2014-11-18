//
//  FareDetailViewController.h
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 09/05/2014.
//
//

#import <UIKit/UIKit.h>
#import "flightdata.h"

@interface FareDetailViewController : UIViewController
{
    IBOutlet UILabel *rights;
    IBOutlet UIView *grandTotalView;
    int check,searchType,termsAccepted;
    __weak IBOutlet UIScrollView *scroller;
    IBOutlet UIView *termsView;
    IBOutlet UIView *transientview;
    IBOutlet UILabel *transienttime;
    IBOutlet UIView *bookingview;
    IBOutlet UIView *bookingViewError;
    CGRect myRect;
    
    IBOutlet UILabel *totalProtectionTotalfee;
    IBOutlet UILabel *totalAirlineFailureFee;
    IBOutlet UILabel *totalProtection;
    IBOutlet UILabel *airlineFailuireFee;
    IBOutlet UILabel *grandeTotal;
    IBOutlet UILabel *infantLabel;
    IBOutlet UILabel *infantTotalLabel;
    IBOutlet UILabel *childLabel;
    IBOutlet UILabel *childTotalLabel;
    IBOutlet UILabel *adultTotalLabel;
    IBOutlet UILabel *InfantFareLabel;
    IBOutlet UILabel *childFareLabel;
    IBOutlet UILabel *adultFareLabel;
}
@property (nonatomic,unsafe_unretained) BOOL fromPcvc;
@property (nonatomic,strong) NSString *pnrno;
@property (nonatomic,strong) NSString *paypalid;
@property (nonatomic,readwrite) Boolean bookingDone;
@property (nonatomic,readwrite) Boolean bookingDoneWithError;

@property (weak, nonatomic) IBOutlet UILabel *txtPnrno;
@property (weak, nonatomic) IBOutlet UILabel *txtpaypalid;
@property (weak, nonatomic) IBOutlet UIButton *backbtn;

- (IBAction)goHome:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)accpetTerms:(id)sender;
- (IBAction)readTerms:(id)sender;
- (IBAction)bookFare:(id)sender;
- (IBAction)subscribe:(id)sender;

@end
