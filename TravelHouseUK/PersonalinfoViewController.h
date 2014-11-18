//
//  PersonalinfoViewController.h
//  TravelHouseUK
//
//  Created by AR on 28/01/2014.
//
//

#import <UIKit/UIKit.h>

@class dataStorage;
@interface PersonalinfoViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UILabel *rights;
       dataStorage *data;
    NSMutableArray *personalData;
}

@property (strong, nonatomic) IBOutlet UIToolbar *accesoryview;

@property (strong, nonatomic) IBOutlet UIView *personalView;
@property (strong, nonatomic) IBOutlet UIScrollView *bgScroll;
@property (strong, nonatomic) IBOutlet UITextField *fName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *telephone;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITextField *department;

- (IBAction)goHome:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)next;
- (IBAction)subscribe:(id)sender;
- (IBAction)nextView;
@end
