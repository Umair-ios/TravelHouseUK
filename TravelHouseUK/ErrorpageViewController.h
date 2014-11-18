//
//  ErrorpageViewController.h
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 26/06/2014.
//
//

#import <UIKit/UIKit.h>

@interface ErrorpageViewController : UIViewController{
    IBOutlet UILabel *rights;
   

}

@property (weak, nonatomic) IBOutlet UIButton *backbtn;

- (IBAction)goHome:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)subscribe:(id)sender;

@end
