//
//  TravelnewsViewController.m
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 07/01/2014.
//
//

#import "TravelnewsViewController.h"


@interface TravelnewsViewController ()

@end

@implementation TravelnewsViewController

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
    
    /*[scroller setContentSize:CGSizeMake(scroller.frame.size.width, 450)];
    
    for(int i=0;i<[_borderedlayer count];i++)
    {
        [Generalfunctionclass addColoredlayer:[_borderedlayer objectAtIndex:i] forColor:@"gray"];
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
    
    NSString* url = @"http://www.travelhouseuk.co.uk/news/";
    
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
    [SVProgressHUD dismiss];

    //[SVProgressHUD showSuccessWithStatus:@"Done!"];
    NSLog(@"finish");
}


-(void)webView:(UIWebView *)wbView didFailLoadWithError:(NSError *)error {
    
    //[spinner removeFromSuperview];
    [SVProgressHUD showSuccessWithStatus:@"Error!"];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
