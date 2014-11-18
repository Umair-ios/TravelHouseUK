//
//  ContactViewController.h
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 31/12/2013.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface ContactViewController : UIViewController <MFMailComposeViewControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UILabel *rights;
    
    __weak IBOutlet UIScrollView *scroller;
    NSArray *CabinClasses;
    IBOutlet UIView *myWebview;
    __weak IBOutlet UIWebView *webview;
}
- (IBAction)goback:(id)sender;


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *borderedlayer;
@property (weak, nonatomic) IBOutlet UITextField *txtname;
@property (weak, nonatomic) IBOutlet UITextField *txtemail;
@property (weak, nonatomic) IBOutlet UITextField *txtphone;
@property (weak, nonatomic) IBOutlet UITextField *txtdpt;
@property (weak, nonatomic) IBOutlet UITextField *txtcomment;

@property (strong, nonatomic) IBOutlet UIToolbar *accesoryview;
@property (strong, nonatomic) IBOutlet UIPickerView *classPicker;

- (IBAction)goHome:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)mailShare:(id)sender;
- (IBAction)directCall:(id)sender;
- (IBAction)subscribe:(id)sender;
- (IBAction)socialShare:(id)sender;
- (IBAction)showMap:(id)sender;
- (IBAction)closeMap:(id)sender;

@end
