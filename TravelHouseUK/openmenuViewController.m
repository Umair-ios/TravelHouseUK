//
//  openmenuViewController.m
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 31/12/2013.
//
//

#import "openmenuViewController.h"
#import "searchflightsViewController.h"
#import "ContactViewController.h"
#import "BookingStep1ViewController.h"
#import "BookingConditionViewController.h"
#import "FAQViewController.h"
#import "TravelnewsViewController.h"

@interface openmenuViewController ()

@end

@implementation openmenuViewController

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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    rights.text=[NSString stringWithFormat:@"All Rights Reserved %@",yearString];
    // Do any additional setup after loading the view from its nib.
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        y=0;
    else
        y=10;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        leftx=-320;
    } else {
        leftx=-768;
    }
    [self.view addSubview:rightmenu];
    [rightmenu setFrame:CGRectMake(leftx, y, rightmenu.frame.size.width, rightmenu.frame.size.height)];
    
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(closemenu)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    [self.view addGestureRecognizer:oneFingerSwipeLeft];
    
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(openmenu)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:oneFingerSwipeRight];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)closemenu
{
   }

- (IBAction)openmenu:(id)sender
{
 
    
    
}

- (IBAction)searchflight:(id)sender {
    
    NSString * nibName=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibName=@"searchflightsViewController_iPhone";
    } else {
        nibName=@"searchflightsViewController_iPad";
    }
    
    searchflightsViewController *op=[[searchflightsViewController alloc]initWithNibName:nibName bundle:nil];
    
    [self.navigationController pushViewController:op animated:YES];
    
}

- (IBAction)Contactus:(id)sender {
    
    NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"ContactViewController_iPhone";
    } else {
        nibname=@"ContactViewController_iPad";
    }
    
    ContactViewController *op=[[ContactViewController alloc]initWithNibName:nibname bundle:nil];
    
    [self.navigationController pushViewController:op animated:YES];
    
}

- (IBAction)BookingCondition
{
    /*BookingStep1ViewController *BSVC=[[BookingStep1ViewController alloc]initWithNibName:@"BookingStep1ViewController" bundle:nil];
     
     [self.navigationController pushViewController:BSVC animated:YES];*/
    
    NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"BookingConditionViewController_iPhone";
    } else {
        nibname=@"BookingConditionViewController_iPad";
    }
    
    BookingConditionViewController *BCVC=[[BookingConditionViewController alloc]initWithNibName:nibname bundle:nil];
    
    [self.navigationController pushViewController:BCVC animated:YES];
    
    
    
}

- (IBAction)FAQ
{
    NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"FAQViewController_iPhone";
    } else {
        nibname=@"FAQViewController_iPad";
    }
    
    FAQViewController *FVC=[[FAQViewController alloc]initWithNibName:nibname bundle:nil];
    
    [self.navigationController pushViewController:FVC animated:YES];
}

- (IBAction)gohome:(id)sender {
    
    [SVProgressHUD dismiss];

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)travelblog:(id)sender {
    
    NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"TravelnewsViewController_iPhone";
    } else {
        nibname=@"TravelnewsViewController_iPad";
    }
    
    TravelnewsViewController *FVC=[[TravelnewsViewController alloc]initWithNibName:nibname bundle:nil];
    
    [self.navigationController pushViewController:FVC animated:YES];
    
}

- (IBAction)subscribe:(id)sender {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Subscribe" message:@"To Subscribe to our newsletter Please enter your email." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Subscribe",nil, nil];
    alert.tag=1144;
    alert.alertViewStyle=UIAlertViewStyleLoginAndPasswordInput;
    [[alert textFieldAtIndex:0] setPlaceholder:@"Enter Your Name"];
    [[alert textFieldAtIndex:1] setPlaceholder:@"Enter Your Email"];
    [alert textFieldAtIndex:1].secureTextEntry=false;
    [alert show];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1144)
    {
        if(buttonIndex==1)
        {
            NSString *name=[alertView textFieldAtIndex:0].text;
            NSString *email=[alertView textFieldAtIndex:1].text;
            NSArray *arr=[[NSArray alloc]initWithObjects:name,email, nil];
            
            [[MessageSender sharedCenter] performSelectorInBackground:@selector(subscribeService:) withObject:arr];
            //[[MessageSender sharedCenter] subscribeService:arr];
            
            /*if([self IsValidEmail:email])
             {
             //[self performSelectorOnMainThread:@selector(SubcribeMail) withObject:nil waitUntilDone:NO];
             }
             else
             {
             
             }*/
        }
    }
}



@end
