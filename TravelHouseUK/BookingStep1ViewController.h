//
//  BookingStep1ViewController.h
//  TravelHouseUK
//
//  Created by AR on 31/12/2013.
//
//

#import <UIKit/UIKit.h>

@interface BookingStep1ViewController : UIViewController <UIScrollViewDelegate>{
    IBOutlet UILabel *rights;
   

}

@property (strong, nonatomic) IBOutlet UILabel *step2lbl;
@property (strong, nonatomic) IBOutlet UILabel *step3lbl;
@property (strong, nonatomic) IBOutlet UIScrollView *bgScroller;
@property (strong, nonatomic) IBOutlet UIView *passenger2view;
@property (strong, nonatomic) IBOutlet UIView *passengerConfirmation;
@property (strong, nonatomic) IBOutlet UIView *passenger1view;
@property (strong, nonatomic) IBOutlet UIView *cardDetailsView;
@property (strong, nonatomic) IBOutlet UIScrollView *cardDetailScroller;
@property (strong, nonatomic) IBOutlet UIView *bookingConfirmationView;

-(IBAction)scrollRight;
-(IBAction)scrollLeft;
- (IBAction)goback:(id)sender;

@end
