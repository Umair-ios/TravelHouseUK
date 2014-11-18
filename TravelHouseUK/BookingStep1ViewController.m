//
//  BookingStep1ViewController.m
//  TravelHouseUK
//
//  Created by AR on 31/12/2013.
//
//

#import "BookingStep1ViewController.h"

@interface BookingStep1ViewController ()

@end

@implementation BookingStep1ViewController

@synthesize step2lbl,step3lbl,bgScroller,passengerConfirmation,passenger1view,passenger2view,cardDetailScroller,cardDetailsView,bookingConfirmationView;
int pos = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    rights.text=[NSString stringWithFormat:@"All Rights Reserved %@",yearString];

    [self settingColors];
    [self settingScroller];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setting Steps

-(void) settingColors
{
    //self.step1lbl.textColor = [UIColor blackColor];
    //self.step1lbl.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Setting Scroller

-(void) settingScroller
{
    self.bgScroller.delegate = self;

    
    //[self.bgScroller setContentSize:CGSizeMake(320, 370*2)];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        
    }
    else
    {
        //---------- For passenger1view ---
        self.passenger1view.frame = CGRectMake(320, 0, 320, 350);
        [self.bgScroller addSubview:self.passenger1view];
        
        
        //---------- For passenger2view ---
        self.passenger2view.frame = CGRectMake(320*2, 0, 320, 350);
        [self.bgScroller addSubview:self.passenger2view];
        
        //---------- For passengerConfirmation ---
        self.passengerConfirmation.frame = CGRectMake(320*3, 0, 320, 350);
        [self.bgScroller addSubview:self.passengerConfirmation];
        
        
        //---------- For Card Detail ---
        [self.cardDetailScroller setContentSize:CGSizeMake(320, 418)];
        self.cardDetailsView.frame = CGRectMake(320*4, 0, 320, 350);
        [self.bgScroller addSubview:self.cardDetailsView];
        
        //---------- For bookingConfirmationView ---
        self.bookingConfirmationView.frame = CGRectMake(320*5, 0, 320, 350);
        [self.bgScroller addSubview:self.bookingConfirmationView];
        self.bgScroller.contentSize = CGSizeMake(self.bookingConfirmationView.frame.origin.x + self.bookingConfirmationView.frame.size.width, 270);
    }

    
}


-(IBAction)scrollRight
{
    if(pos<9)
    {
        pos +=1;
        [self.bgScroller scrollRectToVisible:CGRectMake(pos*self.bgScroller.frame.size.width, 0, self.passenger2view.frame.size.width, self.passenger2view.frame.size.height) animated:NO];
        NSLog(@"Position: %i",pos);
    }
}
-(IBAction)scrollLeft
{
    if(pos>0){
        pos -=1;
        [self.bgScroller scrollRectToVisible:CGRectMake(pos*self.bgScroller.frame.size.width, 0, self.passenger2view.frame.size.width, self.passenger2view.frame.size.height) animated:NO];
        
        NSLog(@"Position: %i",pos);
    }
}

- (IBAction)goback:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
