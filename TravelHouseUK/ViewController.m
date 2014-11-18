//
//  HappyTaxiViewController.m
//  HappyTaxi
//
//  Created by Abdul Rehman Ali on 9/30/13.
//
//

#import "ViewController.h"
#import "openmenuViewController.h"
#import "searchflightsViewController.h"
#import "ContactViewController.h"
#import "BookingStep1ViewController.h"
#import "FAQViewController.h"
#import "BookingConditionViewController.h"
#import "TravelnewsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    rights.text=[NSString stringWithFormat:@"All Rights Reserved %@",yearString];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Home:(id)sender {
    
    NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"openmenuViewController_iPhone";
    } else {
        nibname=@"openmenuViewController_iPad";
    }
    
    openmenuViewController *op=[[openmenuViewController alloc]initWithNibName:nibname bundle:nil];
    
    [self.navigationController pushViewController:op animated:YES];
    
}

- (IBAction)searchflight:(id)sender {
    
    NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"searchflightsViewController_iPhone";
    } else {
        nibname=@"searchflightsViewController_iPad";
    }
    searchflightsViewController *op=[[searchflightsViewController alloc]initWithNibName:nibname bundle:nil];
    
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

- (IBAction)directCall:(id)sender {
    
    
    
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:02031373050"]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Soryy" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
        
    }
    

    
}



- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
