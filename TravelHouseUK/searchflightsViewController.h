//
//  searchflightsViewController.h
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 31/12/2013.
//
//

#import <UIKit/UIKit.h>
#import "flightdata.h"
#import "SVProgressHUD.h"

@interface searchflightsViewController : UIViewController<NSURLConnectionDelegate,NSXMLParserDelegate,UITextFieldDelegate,NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UILabel *rights;
    __weak IBOutlet UIScrollView *scroller;
    int check,iter,da,hintCheck;
    NSMutableArray *obj,*fl,*jsonDataArray,*itenaryArray,*infant,*child;
    NSMutableDictionary *dict;
    NSMutableData *myWebData;
    flightdata *fldata;
    NSDateFormatter *dateFormatter;
    NSMutableArray *destinations;
    NSDate *mydate;
    NSDate *myRdate;

    NSString *ffrom,*fto,*error,*airline,*cabinClassValue,*ReturnFlight;
    int directFlight;
    IBOutlet UITableView *streetTableview;
    NSArray *CabinClasses;
    
}

@property (weak, nonatomic) IBOutlet UIButton *returnRadiobtn;
@property (weak, nonatomic) IBOutlet UIButton *oneRadiobtn;

@property (strong, nonatomic) IBOutlet UIPickerView *classPicker;

@property (strong, nonatomic) IBOutlet UIDatePicker *departuredatepicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *returndatepicker;
@property (strong, nonatomic) IBOutlet UIToolbar *accesoryview;

@property (weak, nonatomic) IBOutlet UITextField *txtFlyingClass;

@property (weak, nonatomic) IBOutlet UITextField *txtflyingfrom;
@property (weak, nonatomic) IBOutlet UITextField *txtflyingto;
@property (weak, nonatomic) IBOutlet UITextField *txtDdate;
@property (weak, nonatomic) IBOutlet UITextField *txtRdate;
@property (weak, nonatomic) IBOutlet UITextField *txtAirline;
@property (weak, nonatomic) IBOutlet UITextField *txtNoAdult;
@property (weak, nonatomic) IBOutlet UITextField *txtNoChild;
@property (weak, nonatomic) IBOutlet UITextField *txtNoInfant;

-(IBAction)TextChange:(UITextField *)textField;

- (IBAction)datechange:(id)sender;

- (IBAction)searchflights:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)goHome:(id)sender;

- (IBAction)done:(id)sender;
- (IBAction)setDirectFlight:(id)sender;
- (IBAction)setReturnFlight:(id)sender;
- (IBAction)subscribe:(id)sender;
- (IBAction)ValueChanged:(id)sender;
- (IBAction)editchanged:(id)sender;
- (IBAction)showKeyboard:(id)sender;

@end
