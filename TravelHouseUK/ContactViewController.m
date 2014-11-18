//
//  ContactViewController.m
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 31/12/2013.
//
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController
@synthesize txtname,txtemail,txtphone,txtdpt,txtcomment,classPicker,accesoryview;

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

    [scroller setContentSize:CGSizeMake(scroller.frame.size.width, 680)];
    
    for(int i=0;i<[_borderedlayer count];i++)
    {
        [Generalfunctionclass addColoredlayer:[_borderedlayer objectAtIndex:i] forColor:@"gray"];
    }
    
    txtname.delegate=self;
    txtemail.delegate=self;
    txtphone.delegate=self;
    txtdpt.delegate=self;
    txtcomment.delegate=self;
    
    txtphone.inputAccessoryView=accesoryview;
    
    txtdpt.inputView=classPicker;
    txtdpt.inputAccessoryView=accesoryview;
    txtdpt.text=@"Sales";
    
    CabinClasses=[[NSArray alloc]initWithObjects:@"Sales",@"Customer service",@"Marketing", nil];
    classPicker.delegate=self;
    classPicker.dataSource=self;
    
    /*NSString *urlAddress = @"<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2482.7117336605534!2d-0.14012683729553216!3d51.518504385752955!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x48761b2a3e3211e1%3A0x5a8e243aaf525e3d!2sTravel+House+UK!5e0!3m2!1sen!2sus!4v1398083778377\" width=\"300\" height=\"460\" frameborder=\"0\" style=\"border:0\"></iframe>";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webview loadRequest:requestObj];*/
    CGRect rect=myWebview.frame;
    
    /*NSString *embedHTML = @"<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2482.7117336605534!2d-0.14012683729553216!3d51.518504385752955!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x48761b2a3e3211e1%3A0x5a8e243aaf525e3d!2sTravel+House+UK!5e0!3m2!1sen!2sus!4v1398083778377\" width=\"300\" height=\"460\" frameborder=\"0\" style=\"border:0\"></iframe>";*/
    
    NSString *embedHTML = @"<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2482.7117336605534!2d-0.14012683729553216!3d51.518504385752955!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x48761b2a3e3211e1%3A0x5a8e243aaf525e3d!2sTravel+House+UK!5e0!3m2!1sen!2sus!4v1398083778377\"";
    
    
    embedHTML =[NSString stringWithFormat:@"%@ width=\"%f\" height=\"%f\" frameborder=\"0\" style=\"border:0\"></iframe>",embedHTML,rect.size.width,rect.size.height];
    
   // NSString *html = [NSString stringWithFormat:embedHTML];
    
    [webview loadHTMLString:embedHTML baseURL:nil];
    
}

#pragma mark - UipickerDelegate

-(NSInteger) numberOfComponentsInPickerView: (UIPickerView *)thePickerView {
    return 1;
}
-(NSInteger)pickerView: (UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [CabinClasses count];
}
-(NSString *)pickerView: (UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [CabinClasses objectAtIndex:row];
}

-(void)pickerView: (UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    txtdpt.text=[CabinClasses objectAtIndex:row];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goback:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)mailShare:(id)sender {
    
    
    if(txtname.text.length<1 || txtphone.text.length<1 || txtemail.text.length<1 || txtcomment.text.length<1)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Please fill all fields."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil] ;
        [alertView show];
    }
    else if(![self IsValidEmail:txtemail.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Please enter a valid email address."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil] ;
        [alertView show];
    }
    else
    {
        NSArray *arr=[[NSArray alloc]initWithObjects:txtname.text,txtphone.text,txtemail.text,txtdpt.text,txtcomment.text, nil];
    
        [[MessageSender sharedCenter] performSelectorInBackground:@selector(contactService:) withObject:arr];
    }
    
    /*if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        if(mailController!=nil)
        {
            mailController.mailComposeDelegate = (id)self;
            NSString *storytitle=[NSString stringWithFormat:@"<table width=\"320\">"
                                 "<tr><td width=\"100\">Name : </td><td width=\"200\">%@</td></tr> "
                                  "<tr><td width=\"100\">Email : </td><td>%@</td></tr>"
                                  "<tr><td width=\"100\">Phone : </td><td>%@</td></tr>"
                                  "<tr><td width=\"100\">Department : </td><td>%@</td></tr>"
                                  "<tr><td width=\"100\">Comment : </td><td>%@</td></tr></table> ",txtname.text,txtemail.text,txtphone.text,txtdpt.text,txtcomment.text];
            
            [mailController setToRecipients:[NSArray arrayWithObjects:@"tahir@travelhouseuk.co.uk",nil]];
            [mailController setSubject:@"TravelHouseUK"];
            [mailController setMessageBody:storytitle isHTML:YES];
            
            //[self presentModalViewController:mailController animated:YES];
            [self presentViewController:mailController animated:YES completion:^(){
                
                
            }];
            
            
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                             message:@"Your Email Account is Not Configured on this Device"
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil] ;
        [alertView show];
    }*/
    
}

-(void)SubcribeMail
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        if(mailController!=nil)
        {
            mailController.mailComposeDelegate = (id)self;
            NSString *storytitle=@"";
            
            [mailController setToRecipients:[NSArray arrayWithObjects:@"Ayataullah@travelhouseuk.co.uk",nil]];
            [mailController setSubject:@"NewsLetter Subsciption"];
            [mailController setMessageBody:storytitle isHTML:YES];
            
            //[self presentModalViewController:mailController animated:YES];
            [self presentViewController:mailController animated:YES completion:^(){
                
                
            }];
            
            
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"Your Email Account is Not Configured on this Device"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil] ;
        [alertView show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    NSString *resultString=@"";
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            resultString=@"Mail: canceled";
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            resultString=@"Mail: saved";
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            resultString=@"Mail: sent";
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            resultString=@"Mail: failed";
            break;
        default:
            NSLog(@"Result: not sent");
            resultString=@"Mail: not sent";
            break;
    }
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:resultString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    
    [controller dismissViewControllerAnimated:YES completion:^{
        
        [alert show];
        
    }];
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

//NSURL *url = [[ [ NSURL alloc ] initWithString: @"http://www.quranreading.com/" ]autorelease];
//[[UIApplication sharedApplication] openURL:url];

- (IBAction)subscribe:(id)sender {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Subscribe" message:@"To Subscribe to our newsletter Please enter your email." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Subscribe",nil, nil];
    alert.tag=1144;
    alert.alertViewStyle=UIAlertViewStyleLoginAndPasswordInput;
    [[alert textFieldAtIndex:0] setPlaceholder:@"Enter Your Name"];
    [[alert textFieldAtIndex:1] setPlaceholder:@"Enter Your Email"];
    [alert textFieldAtIndex:1].secureTextEntry=false;
    [alert show];
    
}

- (IBAction)socialShare:(id)sender {
    
    UIButton *temp=(UIButton*)sender;
    NSURL *url = nil;
    
    if(temp.tag==1)
    {
        url = [ [ NSURL alloc ] initWithString: @"https://www.facebook.com/travelhouseuk" ];
    }
    if(temp.tag==2)
    {
        url = [ [ NSURL alloc ] initWithString: @"https://twitter.com/travelhouseuk" ];
    }
    if(temp.tag==3)
    {
        url = [ [ NSURL alloc ] initWithString: @"http://www.linkedin.com/company/travelhouseuk" ];
    }
    if(temp.tag==4)
    {
        url = [ [ NSURL alloc ] initWithString: @"https://plus.google.com/+travelhouseuk/posts" ];
    }
    if(temp.tag==5)
    {
        url = [ [ NSURL alloc ] initWithString: @"" ];
    }
    if(temp.tag==6)
    {
        url = [ [ NSURL alloc ] initWithString: @"" ];
    }
    
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)showMap:(id)sender {
    
    CGRect rect=myWebview.frame;
    [webview setFrame:rect];
    
    [self.view addSubview:myWebview];
    
}

- (IBAction)closeMap:(id)sender {
    [myWebview removeFromSuperview];
}

-(BOOL)IsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [scroller setContentSize:CGSizeMake(320, 780)];
        if(textField==txtname)
        {
            
            CGPoint p=CGPointMake(0, 260);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtemail)
        {
            
            CGPoint p=CGPointMake(0, 290);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtphone)
        {
            
            CGPoint p=CGPointMake(0, 320);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtdpt)
        {
            
            CGPoint p=CGPointMake(0, 350);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtcomment)
        {
            
            CGPoint p=CGPointMake(0, 380);
            [scroller setContentOffset:p animated:YES];
        }
        
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        [scroller setContentSize:CGSizeMake(320, 680)];
        if(textField==txtname)
        {
            
            CGPoint p=CGPointMake(0, 220);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtemail)
        {
            
            CGPoint p=CGPointMake(0, 250);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtphone)
        {
            
            CGPoint p=CGPointMake(0, 280);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtdpt)
        {
            
            CGPoint p=CGPointMake(0, 310);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtcomment)
        {
            
            CGPoint p=CGPointMake(0, 340);
            [scroller setContentOffset:p animated:YES];
        }
        
        
    }
    
    [textField resignFirstResponder];
    
    /* if(textField.tag == 0)
     {
     [businessTableView removeFromSuperview];
     }*/
    
    return YES;
}

- (IBAction)done:(id)sender {
    
    [txtdpt resignFirstResponder];
    [txtphone resignFirstResponder];
    
}

- (IBAction)goHome:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
