//
//  FAQViewController.h
//  TravelHouseUK
//
//  Created by AR on 06/01/2014.
//
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface FAQViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UILabel *rights;
       UIActivityIndicatorView *spinner;
    UIWebView* webView;
}

@property (strong, nonatomic) IBOutlet UIScrollView *faqScroller;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *borderedlayer;

- (IBAction)goHome:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)subscribe:(id)sender;

@end
