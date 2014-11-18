//
//  openmenuViewController.h
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 31/12/2013.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface openmenuViewController : UIViewController
{
    
    IBOutlet UILabel *rights;
    IBOutlet UIView *rightmenu;
    float y,leftx;
}


- (IBAction)openmenu:(id)sender;
- (IBAction)gohome:(id)sender;
- (IBAction)searchflight:(id)sender;
- (IBAction)Contactus:(id)sender;
- (IBAction)BookingCondition;
- (IBAction)FAQ;
- (IBAction)travelblog:(id)sender;
- (IBAction)subscribe:(id)sender;

@end
