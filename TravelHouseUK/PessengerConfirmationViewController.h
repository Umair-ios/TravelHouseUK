//
//  PessengerConfirmationViewController.h
//  TravelHouseUK
//
//  Created by AR on 28/01/2014.
//
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "PayPalMobile.h"
#import "flightdata.h"

@class dataStorage;
@interface PessengerConfirmationViewController : UIViewController<UIAlertViewDelegate,NSXMLParserDelegate,PayPalPaymentDelegate>
{
    IBOutlet UILabel *rights;
    
    IBOutlet UILabel *pessengerlabel;
    dataStorage *data;
    NSMutableData *myWebData,*dataArray;
    int check,searchType,termsAccepted;
    NSString *error;
    NSString *BookingDecliened;
    IBOutlet UIView *transientview;
    IBOutlet UILabel *transienttime;
    CGRect myRect;
    IBOutlet UIView *fareview;
    __weak IBOutlet UIScrollView *scroller;
    IBOutlet UIView *termsView;
    NSString *paymentId;
    NSString *pnrNo;
}
@property (nonatomic) int totallPessengers;
@property (strong, nonatomic) IBOutlet UIView *pessengersInfo;
@property (strong, nonatomic) IBOutlet UIScrollView *bgScroller;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;

- (IBAction)goHome:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)accpetTerms:(id)sender;
- (IBAction)bookFare:(id)sender;
- (IBAction)readTerms:(id)sender;
- (IBAction)subscribe:(id)sender;
- (IBAction)fareMatch:(id)sender;

@end
