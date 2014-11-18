//
//  FAQViewController.m
//  TravelHouseUK
//
//  Created by AR on 06/01/2014.
//
//

#import "FAQViewController.h"

@interface FAQViewController ()

@end

@implementation FAQViewController

@synthesize borderedlayer,faqScroller;

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

    
    
    
   /* if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            [faqScroller setContentSize:CGSizeMake(faqScroller.frame.size.width, 4471)];//3621
            faqScroller.frame = CGRectMake(0, 60, 320, 370);
        }
        else
        {
            
            [faqScroller setContentSize:CGSizeMake(faqScroller.frame.size.width, 5500)];
            faqScroller.frame = CGRectMake(0, 60, 320, 458);
        }
    }
    
    
    for(int i=0;i<[borderedlayer count];i++)
    {
        [Generalfunctionclass addColoredlayer:[borderedlayer objectAtIndex:i] forColor:@"gray"];
    }*/
    
    
    
    webView = [[UIWebView alloc] init];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            webView.frame = CGRectMake(0, 60, 320, 370);
        }
        else
        {
            
            webView.frame = CGRectMake(0, 60, 320, 458);
        }
    }
    else
    {
        webView.frame = CGRectMake(0, 80, 768, 914);
    }
    
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    NSString* url = @"http://m.travelhouseuk.co.uk/faqs.php?mark=iphone";
    
    NSURL* nsUrl = [NSURL URLWithString:url];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    
    
    [webView loadRequest:request];
    
    
    spinner = [[UIActivityIndicatorView alloc]       initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    
    
    //[spinner startAnimating];
    //[self.view addSubview:spinner];
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)wbView {
    
    //[spinner removeFromSuperview];
    [SVProgressHUD showSuccessWithStatus:@"Done!"];
}


-(void)webView:(UIWebView *)wbView didFailLoadWithError:(NSError *)error {
    
    //[spinner removeFromSuperview];
    
    [SVProgressHUD showSuccessWithStatus:@"Done!"];
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

- (IBAction)goHome:(id)sender {
    
    [SVProgressHUD dismiss];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
