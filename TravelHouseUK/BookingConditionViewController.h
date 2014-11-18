//
//  BookingConditionViewController.h
//  TravelHouseUK
//
//  Created by AR on 06/01/2014.
//
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface BookingConditionViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UILabel *rights;
    
    UIWebView* webView;
    UIActivityIndicatorView *spinner;
}

@property (strong, nonatomic) IBOutlet UIScrollView *bgScroller;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *borderedlayer;

- (IBAction)goHome:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)subscribe:(id)sender;

@end
