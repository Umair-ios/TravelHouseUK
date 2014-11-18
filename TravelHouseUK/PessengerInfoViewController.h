//
//  PessengerInfoViewController.h
//  TravelHouseUK
//
//  Created by AR on 28/01/2014.
//
//

#import <UIKit/UIKit.h>
#import "PessengerConfirmationViewController.h"
#import "dataStorage.h"
#import "ErrorpageViewController.h"

@class dataStorage;
@interface PessengerInfoViewController : UIViewController <UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate,NSXMLParserDelegate>
{
    IBOutlet UILabel *rights;
   
    NSMutableArray *pessengerData;
    dataStorage *data;
    NSDate *mydate;
    int pickerFor; // pickerFor = 0 for fieled 1 || pickerFor = 1 for date fieled
    NSArray *arrState;
    UIPickerView *pktStatePicker ;
    UIToolbar *mypickerToolbar;
}

@property (nonatomic) int totallInfants;
@property (nonatomic) int totallAdults;
@property (nonatomic) int totallPessengers;
@property (nonatomic) int totallChilds;
@property (nonatomic) int pessengersCounter;
@property (strong, nonatomic) IBOutlet UIView *PessengersView;
@property (strong, nonatomic) IBOutlet UIScrollView *bgScroll;
@property (strong, nonatomic) IBOutlet UILabel *pessengerNumberLbl;
@property (strong, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic) IBOutlet UITextField *fname;
@property (strong, nonatomic) IBOutlet UITextField *lName;
@property (strong, nonatomic) IBOutlet UITextField *dob;
@property (strong, nonatomic) IBOutlet UITextField *passport;

@property (strong, nonatomic) IBOutlet UIDatePicker *pickupdate;
@property (strong, nonatomic) IBOutlet UIToolbar *accesoryview;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barBtn;

- (IBAction)goHome:(id)sender;
- (IBAction)dropDown;
- (IBAction)donechanges:(id)sender;
- (IBAction)datechange:(id)sender;
- (IBAction)nextPessenger;
- (IBAction)previousPessenger;
- (IBAction)goback:(id)sender;
- (IBAction)subscribe:(id)sender;
- (IBAction)next;

@end
