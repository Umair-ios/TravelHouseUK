//
//  TravelnewsViewController.h
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 07/01/2014.
//
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface TravelnewsViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UILabel *rights;
  
    __weak IBOutlet UIScrollView *scroller;
    UIWebView* webView;
    UIActivityIndicatorView *spinner;
}

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *borderedlayer;

- (IBAction)goHome:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)subscribe:(id)sender;

@end
