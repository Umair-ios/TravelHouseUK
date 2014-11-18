//
//  PersonalinfoViewController.m
//  TravelHouseUK
//
//  Created by AR on 28/01/2014.
//
//

#import "PersonalinfoViewController.h"
#import "PessengerInfoViewController.h"
#import "dataStorage.h"
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "

@interface PersonalinfoViewController ()

@end

@implementation PersonalinfoViewController

@synthesize personalView,bgScroll,fName,email,telephone,country,department,accesoryview;

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

    
    
    self.fName.delegate = self;
    self.email.delegate = self;
    self.telephone.delegate = self;
    self.country.delegate = self;
    self.department.delegate = self;
    
    self.telephone.inputAccessoryView=accesoryview;
    personalData = [[NSMutableArray alloc] init];
    data = [dataStorage sharedCenter];
    
    NSLog(@"%lu",(unsigned long)data.pessengersArray.count);
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
    {
        self.personalView.frame = CGRectMake(0, 0, self.bgScroll.frame.size.width, self.bgScroll.frame.size.height);
        
        [self.bgScroll addSubview:self.personalView];

    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    
    [self.telephone resignFirstResponder];
    
    [self.bgScroll setContentSize:CGSizeMake(300, 301)];
    CGPoint p=CGPointMake(0, 0);
    [self.bgScroll setContentOffset:p animated:YES];
    
    
}

- (IBAction)next
{
    NSLog(@"%@",self.fName.text);
    
    if(self.fName.text.length <=0 || self.email.text.length <=0 || self.telephone.text.length <=0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil
                                                          message:@"All Field must be filled!"
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        
        if([self IsValidEmail:self.email.text])
        {
        
            [data.personalArray removeAllObjects];
            [data.personalArray addObject:self.fName.text];
            [data.personalArray addObject:self.email.text];
            [data.personalArray addObject:self.telephone.text];
            //[data.personalArray addObject:self.country.text];
            //[data.personalArray addObject:self.department.text];
            
            NSString *nibname=@"";
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                nibname=@"PessengerInfoViewController_iPhone";
            } else {
                nibname=@"PessengerInfoViewController_iPad";
            }
            
            PessengerInfoViewController *BSVC=[[PessengerInfoViewController alloc]initWithNibName:nibname bundle:nil];
            BSVC.totallPessengers = data.totallPessengers;
            BSVC.totallAdults = data.totallAdults;
            BSVC.totallInfants = data.totallInfants;
            [self.navigationController pushViewController:BSVC animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil
                                                           message:@"Please provide valid email address!"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            
            [alert show];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if(textField.tag == 3)
    {
        [self.bgScroll setContentSize:CGSizeMake(300, 401)];
        CGPoint p=CGPointMake(0, 80);
        [self.bgScroll setContentOffset:p animated:YES];
    }
    else if(textField.tag == 4)
    {
        [self.bgScroll setContentSize:CGSizeMake(300, 401)];
        CGPoint p=CGPointMake(0, 120);
        [self.bgScroll setContentOffset:p animated:YES];
    }
    else if(textField.tag == 5)
    {
        [self.bgScroll setContentSize:CGSizeMake(300, 401)];
        CGPoint p=CGPointMake(0, 160);
        [self.bgScroll setContentOffset:p animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    //if(textField.tag == 3)
    //{
        [self.bgScroll setContentSize:CGSizeMake(300, 301)];
        CGPoint p=CGPointMake(0, 0);
        [self.bgScroll setContentOffset:p animated:YES];
    //}
    

    
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range     replacementString:(NSString *)string {
    if (textField!=email) {
        
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        
        if  ([string isEqualToString:filtered])
            return  YES;
        else
            return NO;
    }
    
    else
        return YES;
}

- (IBAction)goback:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)nextView {
    
    NSLog(@"%@",self.fName.text);
    
    if(self.fName.text.length <=0 || self.email.text.length <=0 || self.telephone.text.length <=0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil
                                                       message:@"All Field must be filled!"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        
        if([self IsValidEmail:self.email.text])
        {
            
            [data.personalArray removeAllObjects];
            [data.personalArray addObject:self.fName.text];
            [data.personalArray addObject:self.email.text];
            [data.personalArray addObject:self.telephone.text];
            //[data.personalArray addObject:self.country.text];
            //[data.personalArray addObject:self.department.text];
            
            NSString *nibname=@"";
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                nibname=@"PessengerInfoViewController_iPhone";
            } else {
                nibname=@"PessengerInfoViewController_iPad";
            }
            
            PessengerInfoViewController *BSVC=[[PessengerInfoViewController alloc]initWithNibName:nibname bundle:nil];
            BSVC.totallPessengers = data.totallPessengers;
            BSVC.totallAdults = data.totallAdults;
            BSVC.totallInfants = data.totallInfants;
            [self.navigationController pushViewController:BSVC animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil
                                                           message:@"Please provide valid email address!"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            
            [alert show];
        }
    }

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
            NSString *email1=[alertView textFieldAtIndex:1].text;
            NSArray *arr=[[NSArray alloc]initWithObjects:name,email1, nil];
            
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

#pragma mark - email valid or Not

-(BOOL) IsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (IBAction)goHome:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
