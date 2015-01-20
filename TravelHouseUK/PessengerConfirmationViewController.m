//  PessengerConfirmationViewController.m
//  TravelHouseUK
//
//  Created by AR on 28/01/2014.
//
//

#import "PessengerConfirmationViewController.h"
#import "dataStorage.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomCell.h"
#import "BookingConditionViewController.h"
#import "FareDetailViewController.h"
#import "ErrorpageViewController.h"

// Set the environment:
// - For live charges, use PayPalEnvironmentProduction (default).
// - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
// - For testing, use PayPalEnvironmentNoNetwork.
#define kPayPalEnvironment PayPalEnvironmentSandbox

#define paypalresponsekey1 @"response"
#define paypalresponsekey2 @"proof_of_payment"
#define paypalresponsesubkey1 @"adaptive_payment"
#define paypalresponsesubkey2 @"rest_api"
#define paypalresponseidkey1 @"id"
#define paypalresponseidkey2 @"pay_key"
#define paypalresponseidkey3 @"payment_id"

@interface PessengerConfirmationViewController ()

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@end

@implementation PessengerConfirmationViewController

@synthesize pessengersInfo,totallPessengers,bgScroller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    // Preconnect to PayPal early
    
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentProduction];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    rights.text=[NSString stringWithFormat:@"All Rights Reserved %@",yearString];

    
    data = [dataStorage sharedCenter];
    
    paymentId=@"";
    
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.languageOrLocale = @"en_GB";
    
    _payPalConfig.merchantName = @"TravelHouseUK";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"http://www.americantaxi.com"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"http://m.travelhouseuk.co.uk/user-agreement.php?mark=iphone"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    //_payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;
    self.acceptCreditCards=YES;
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    
   /* NSString *paxdetais=[data makePaxDetails];
    
    NSLog(@"Airfare Match Request : <FareMatchRequest>\n"
          "<FlightDetail>\n"
          "%@"
          "</FlightDetail>\n"
          "%@"
          "<SearchDetail>\n"
          "%@"
          "</SearchDetail>\n"
          "</FareMatchRequest>",data.requestItenary,paxdetais,data.searchQuery);*/
    
    //[self airFareMatchRequest];
    
    UIImageView *imageView=[[UIImageView alloc]initWithImage:data.image];
    [bgScroller addSubview:imageView];

    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        int x = 51,y = 111+imageView.frame.size.height,width = 230,height = 25;
        
        pessengerlabel.frame=CGRectMake(pessengerlabel.frame.origin.x,y-30 ,pessengerlabel.frame.size.width ,pessengerlabel.frame.size.height );

        for (int i = 0; i < data.pessengersArray.count; i++)
        {
            
            NSMutableArray *array = [data.pessengersArray objectAtIndex:i];
            
            UILabel *pNum = [[UILabel alloc] init];
            pNum.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1];
            [pNum setFrame:CGRectMake(x, y, width, height)];
            pNum.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pNum.userInteractionEnabled=NO;
            [pNum setFont:[UIFont boldSystemFontOfSize:18]];
            pNum.text= [NSString stringWithFormat:@"PASSENGER %d",i+1];
            [self.bgScroller addSubview:pNum];
            
            
            y = y + height + 10*2;
            
            UILabel *pNameTitle = [[UILabel alloc] init];
            pNameTitle.textColor = [UIColor blackColor];
            [pNameTitle setFrame:CGRectMake(x, y, width, height)];
            pNameTitle.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pNameTitle.userInteractionEnabled=NO;
            [pNameTitle setFont:[UIFont systemFontOfSize:18]];
            pNameTitle.text= [NSString stringWithFormat:@"Name:"];
            [self.bgScroller addSubview:pNameTitle];
            
            
            
            x = x + width + 10*10;
            
            UILabel *pName = [[UILabel alloc] init];
            pName.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1];
            [pName setFrame:CGRectMake(x, y, width, height)];
            pName.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pName.userInteractionEnabled=NO;
            [pName setFont:[UIFont systemFontOfSize:18]];
            pName.text= [NSString stringWithFormat:@"%@ %@ %@",[array objectAtIndex:5],[array objectAtIndex:1],[array objectAtIndex:2]];
            [self.bgScroller addSubview:pName];
            
            
            
            y = y + height + 10*2;
            x = 51;
            
            UILabel *pDOB = [[UILabel alloc] init];
            pDOB.textColor = [UIColor blackColor];
            [pDOB setFrame:CGRectMake(x, y, width, height)];
            pDOB.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pDOB.userInteractionEnabled=NO;
            [pDOB setFont:[UIFont systemFontOfSize:18]];
            pDOB.text= [NSString stringWithFormat:@"Date of Birth:"];
            [self.bgScroller addSubview:pDOB];
            
            
            
            x = x + width + 10*10;
            
            UILabel *pBirth = [[UILabel alloc] init];
            pBirth.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1];
            [pBirth setFrame:CGRectMake(x, y, width, height)];
            pBirth.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pBirth.userInteractionEnabled=NO;
            [pBirth setFont:[UIFont systemFontOfSize:18]];
            pBirth.text= [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
            [self.bgScroller addSubview:pBirth];
            
            
            
            y = y + height + 10*2;
            x = 51;
            
            UILabel *Passport = [[UILabel alloc] init];
            Passport.textColor = [UIColor blackColor];
            [Passport setFrame:CGRectMake(x, y, width, height)];
            Passport.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            Passport.userInteractionEnabled=NO;
            [Passport setFont:[UIFont systemFontOfSize:18]];
            Passport.text= [NSString stringWithFormat:@"Passport:"];
            [self.bgScroller addSubview:Passport];
            
            
            
            x = x + width + 10*10;
            
            UILabel *PassportNum = [[UILabel alloc] init];
            PassportNum.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1];
            [PassportNum setFrame:CGRectMake(x, y, width, height)];
            PassportNum.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            PassportNum.userInteractionEnabled=NO;
            [PassportNum setFont:[UIFont systemFontOfSize:18]];
            PassportNum.text= [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
            [self.bgScroller addSubview:PassportNum];
            
            
            y = y + height + 10*2;
            x = 51;
        }
        
        
        
        self.bgScroller.contentSize = CGSizeMake(768, y);
        
    }
    else
    {
        
         //---------- For passengerview ---
        
        /*for (int i =0; i < 4; i++)
        {
            self.pessengersInfo.frame = CGRectMake(0, 40, 320, 115);
            self.pessengersInfo.backgroundColor = [UIColor clearColor];
            [self.bgScroller addSubview:self.pessengersInfo];
            
            
        }
        
       self.bgScroller.contentSize = CGSizeMake(320, self.pessengersInfo.frame.origin.y + self.pessengersInfo.frame.size.height);*/
        
        
        int x = 21,y = 40+imageView.frame.size.height,width = 130,height = 15;
        
        pessengerlabel.frame=CGRectMake(pessengerlabel.frame.origin.x,y-30 ,pessengerlabel.frame.size.width ,pessengerlabel.frame.size.height );
        for (int i = 0; i < data.pessengersArray.count; i++)
        {
            
            NSMutableArray *array = [data.pessengersArray objectAtIndex:i];
            
            UILabel *pNum = [[UILabel alloc] init];
            pNum.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1];
            [pNum setFrame:CGRectMake(x, y, width, height)];
            pNum.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pNum.userInteractionEnabled=NO;
            [pNum setFont:[UIFont boldSystemFontOfSize:12]];
            pNum.text= [NSString stringWithFormat:@"PASSENGER %d",i+1];
            [self.bgScroller addSubview:pNum];
            
            y = y + height + 10;
            
            UILabel *pNameTitle = [[UILabel alloc] init];
            pNameTitle.textColor = [UIColor blackColor];
            [pNameTitle setFrame:CGRectMake(x, y, width, height)];
            pNameTitle.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pNameTitle.userInteractionEnabled=NO;
            [pNameTitle setFont:[UIFont systemFontOfSize:12]];
            pNameTitle.text= [NSString stringWithFormat:@"Name:"];
            [self.bgScroller addSubview:pNameTitle];
            
            
            
            x = x + width + 10;
            
            UILabel *pName = [[UILabel alloc] init];
            pName.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1];
            [pName setFrame:CGRectMake(x-20, y, width+40, height)];
            pName.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pName.userInteractionEnabled=NO;
            [pName setFont:[UIFont systemFontOfSize:12]];
            pName.text= [NSString stringWithFormat:@"%@ %@ %@",[array objectAtIndex:5],[array objectAtIndex:1],[array objectAtIndex:2]];
            pName.textAlignment=NSTextAlignmentCenter;

            [self.bgScroller addSubview:pName];

            
            
            y = y + height + 10;
            x = 21;
            
            UILabel *pDOB = [[UILabel alloc] init];
            pDOB.textColor = [UIColor blackColor];
            [pDOB setFrame:CGRectMake(x, y, width, height)];
            pDOB.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pDOB.userInteractionEnabled=NO;
            [pDOB setFont:[UIFont systemFontOfSize:12]];
            pDOB.text= [NSString stringWithFormat:@"Date of Birth:"];
            [self.bgScroller addSubview:pDOB];
            
            
            
            x = x + width + 10;
            
            UILabel *pBirth = [[UILabel alloc] init];
            pBirth.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1];
            [pBirth setFrame:CGRectMake(x-20, y, width+40, height)];
            pBirth.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            pBirth.userInteractionEnabled=NO;
            [pBirth setFont:[UIFont systemFontOfSize:12]];
           
            pBirth.text= [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
           
            pBirth.textAlignment=NSTextAlignmentCenter;

            [self.bgScroller addSubview:pBirth];

            
            
            y = y + height + 10;
            x = 21;
            
            UILabel *Passport = [[UILabel alloc] init];
            Passport.textColor = [UIColor blackColor];
            [Passport setFrame:CGRectMake(x, y, width, height)];
            Passport.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            Passport.userInteractionEnabled=NO;
            [Passport setFont:[UIFont systemFontOfSize:12]];
            Passport.text= [NSString stringWithFormat:@"Passport:"];
            [self.bgScroller addSubview:Passport];
            
            
            
            x = x + width + 10;
            
            UILabel *PassportNum = [[UILabel alloc] init];
            PassportNum.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1];
            [PassportNum setFrame:CGRectMake(x-20, y, width+40, height)];
            PassportNum.backgroundColor=[UIColor clearColor];
            //pNum.textColor=[UIColor whiteColor];
            PassportNum.userInteractionEnabled=NO;
            [PassportNum setFont:[UIFont systemFontOfSize:12]];
            PassportNum.text= [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
            PassportNum.textAlignment=NSTextAlignmentCenter;
            [self.bgScroller addSubview:PassportNum];
            
            
            y = y + height + 10;
            x = 21;
        }
        
        
        self.bgScroller.contentSize = CGSizeMake(320, y);
        
    }
    
    
}

-(void)airFareMatchRequest
{
    searchType=0;
    NSString *paxdetais=[data makePaxDetails];
    
    NSLog(@"Airfare Match Request : <FareMatchRequest>\n"
          "<FlightDetail>\n"
          "%@"
          "</FlightDetail>\n"
          "%@"
          "<SearchDetail>\n"
          "%@"
          "</SearchDetail>\n"
          "</FareMatchRequest>",data.requestItenary,paxdetais,data.searchQuery);
    
    NSString *smsg=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                    "<soap:Body>\n"
                    "<AirFareMatch xmlns=\"http://tempuri.org/\">\n"
                    "<bookingXML>\n"
                    "<![CDATA["
                    "<FareMatchRequest>\n"
                    "<FlightDetail>\n"
                    "%@"
                    "</FlightDetail>\n"
                    "%@"
                    "<SearchDetail>\n"
                    "%@"
                    "</SearchDetail>\n"
                    "</FareMatchRequest>"
                    "]]>"
                    "</bookingXML>\n"
                    "</AirFareMatch>\n"
                    "</soap:Body>\n"
                    "</soap:Envelope>",data.requestItenary,paxdetais,data.searchQuery];
    
    // create a url to your asp.net web service.
    NSURL *tmpURl=[NSURL URLWithString:[NSString stringWithFormat:@"http://services.crystaltravel.co.uk/XMLAPI/FLIGHT/FLIGHTSERVICE.ASMX?op=AirFareMatch"]];
    
    // create a request to your asp.net web service.
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:tmpURl];
    
    //Host: services.test.crystaltravel.co.uk
    [theRequest addValue:@"services.crystaltravel.co.uk" forHTTPHeaderField:@"Host"];
    
    
    // add http content type - to your request
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // add  SOAPAction - webMethod that is going to be called
    [theRequest addValue:@"http://tempuri.org/AirFareMatch" forHTTPHeaderField:@"SOAPAction"];
    
    // count your soap message lenght - which is required to be added in your request
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[smsg length]];
    // add content length
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    
    // set method - post
    [theRequest setHTTPMethod:@"POST"];
    
    // set http request - body
    [theRequest setHTTPBody:[smsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    // establish connection with your request & here delegate is self, so you need to implement connection's methods
    NSURLConnection *con=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    // if connection is established
    if(con)
    {
        myWebData=[NSMutableData data];
        // here -> NSMutableData *myWebData; -> declared in .h file
    }
}

-(void)bookFlightRequest

{
    [SVProgressHUD showWithStatus:@"Loading..."];
    searchType=1;
    NSString *paxdetais=[data makePaxDetails];
    
    NSString *smsg=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                    "<soap:Body>\n"
                    "<BookFlight xmlns=\"http://tempuri.org/\">\n"
                    "<bookingXML>\n"
                    "<![CDATA["
                    "<BookingXML>\n"
                    "<SessionId>%@</SessionId>\n"
                    "<FlightDetail>\n"
                    "%@"
                    "</FlightDetail>\n"
                    "%@"
                    "<SearchDetail>\n"
                    "%@"
                    "</SearchDetail>\n"
                    "</BookingXML>\n"
                    "]]>"
                    "</bookingXML>\n"
                    "</BookFlight>\n"
                    "</soap:Body>\n"
                    "</soap:Envelope>",data.sessionId,data.requestItenary,paxdetais,data.searchQuery];
    
    // create a url to your asp.net web service.
    NSURL *tmpURl=[NSURL URLWithString:[NSString stringWithFormat:@"http://services.crystaltravel.co.uk/XMLAPI/FLIGHT/FLIGHTSERVICE.ASMX?op=BookFlight"]];
    
    // create a request to your asp.net web service.
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:tmpURl];
    
    //Host: services.test.crystaltravel.co.uk
    [theRequest addValue:@"services.crystaltravel.co.uk" forHTTPHeaderField:@"Host"];
    
    
    // add http content type - to your request
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // add  SOAPAction - webMethod that is going to be called
    [theRequest addValue:@"http://tempuri.org/BookFlight" forHTTPHeaderField:@"SOAPAction"];
    
    // count your soap message lenght - which is required to be added in your request
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[smsg length]];
    // add content length
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    
    // set method - post
    [theRequest setHTTPMethod:@"POST"];
    
    // set http request - body
    [theRequest setHTTPBody:[smsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    // establish connection with your request & here delegate is self, so you need to implement connection's methods
    NSURLConnection *con=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    // if connection is established
    if(con)
    {
        myWebData=[NSMutableData data];
        // here -> NSMutableData *myWebData; -> declared in .h file
    }
}

// a method when connection receives response from asp.net web server
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [myWebData setLength: 0];
}
// when web-service sends data to iPhone
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [myWebData appendData:data1];
}
// when there is some error with web service
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error");
}
// when connection successfully finishes
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // check out your web-service retrieved data on log screen
    [SVProgressHUD showSuccessWithStatus:@"Done!"];
    self.view.userInteractionEnabled=YES;

    error=@"";
    NSString *htmlString = [[NSString alloc] initWithBytes: [myWebData mutableBytes] length:[myWebData length] encoding:NSUTF8StringEncoding];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&amp;"  withString:@"&"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&lt;"  withString:@"<"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&gt;"  withString:@">"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</Itinerary>"  withString:@"</Itinerary>\n\n"];//<Itinerary>
    //htmlString = [htmlString stringByReplacingOccurrencesOfString:@"""" withString:@"&quot;"];
    //htmlString = [htmlString stringByReplacingOccurrencesOfString:@"'"  withString:@"&#039;"];
   
    NSLog(@"%@",htmlString);
    
    if(searchType==0)
    {
        NSData *d=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSXMLParser *p=[[NSXMLParser alloc]initWithData:d];
        [p setDelegate:self];
        [p setShouldResolveExternalEntities:YES];
        //[p setShouldProcessNamespaces:YES];
        [p parse];
        //[self performSelectorOnMainThread:@selector(ShouldProcessPay) withObject:nil waitUntilDone:NO];
        if(data.sessionId!=nil && data.sessionId.length>0)
        {
            [self performSelectorOnMainThread:@selector(ShouldProcessPay) withObject:nil waitUntilDone:NO];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"The requested Flight is not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert setTag:123];
            [alert show];
        }
    }
    else if (searchType==1)
    {
        NSData *d=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSXMLParser *p=[[NSXMLParser alloc]initWithData:d];
        [p setDelegate:self];
        [p setShouldResolveExternalEntities:YES];
        //[p setShouldProcessNamespaces:YES];
        [p parse];
        
        
        NSArray *arr=[[NSArray alloc]initWithObjects:paymentId,htmlString, nil];
        
        [[MessageSender sharedCenter] performSelectorInBackground:@selector(bookingService:) withObject:arr];
        
        [self performSelectorOnMainThread:@selector(BookFlightResult) withObject:nil waitUntilDone:NO];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ShouldProcessPay
{
    if(data.sessionId!=nil && data.sessionId.length>0)
    {
        [self performSelectorOnMainThread:@selector(pay) withObject:nil waitUntilDone:NO];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"The requested Flight is not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert setTag:123];
        [alert show];
    }
}

-(void)ShouldBookFlight
{
    if(data.sessionId!=nil && data.sessionId.length>0)
    {
        [self performSelectorOnMainThread:@selector(bookFlightRequest) withObject:nil waitUntilDone:NO];        
    }
    else
    {
        /*UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"The requested Flight is not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert setTag:12];
        [alert show];*/
        
        NSString *nibname=@"";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            nibname=@"ErrorpageViewController_iPhone";
        } else {
            nibname=@"ErrorpageViewController_iPad";
        }
        
        ErrorpageViewController *BSVC=[[ErrorpageViewController alloc]initWithNibName:nibname bundle:nil];
        
        [self.navigationController pushViewController:BSVC animated:YES];
        
    }
}

-(void)BookFlightResult
{
    if ([BookingDecliened isEqualToString:@"Booking Decliened"]) {
        NSString *nibname=@"";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            nibname=@"FareDetailViewController_iPhone";
        } else {
            nibname=@"FareDetailViewController_iPad";
        }
        
        FareDetailViewController *BSVC=[[FareDetailViewController alloc]initWithNibName:nibname bundle:nil];
        BSVC.bookingDone=true;
        BSVC.bookingDoneWithError=true;
        BSVC.fromPcvc=YES;
        
        [self.navigationController pushViewController:BSVC animated:YES];

    }
    else if(error!=nil && error.length>1)
    {
        /*UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Booking Flight" message:error delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert setTag:1];
        [alert show];*/
        
        NSString *nibname=@"";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            nibname=@"ErrorpageViewController_iPhone";
        } else {
            nibname=@"ErrorpageViewController_iPad";
        }
        
        ErrorpageViewController *BSVC=[[ErrorpageViewController alloc]initWithNibName:nibname bundle:nil];
        
        [self.navigationController pushViewController:BSVC animated:YES];
        
    }
    else
    {
        NSString *nibname=@"";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            nibname=@"FareDetailViewController_iPhone";
        } else {
            nibname=@"FareDetailViewController_iPad";
        }
        
        FareDetailViewController *BSVC=[[FareDetailViewController alloc]initWithNibName:nibname bundle:nil];
        BSVC.bookingDone=true;
        BSVC.pnrno=pnrNo;
        BSVC.paypalid=paymentId;
        BSVC.fromPcvc=YES;
        
        [self.navigationController pushViewController:BSVC animated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==123)
    {
        if(buttonIndex==1)
        {
            [self performSelectorOnMainThread:@selector(pay) withObject:nil waitUntilDone:NO];
        }
    }
    else if (alertView.tag==12)
    {
        if(buttonIndex==1)
        {
            [self performSelectorOnMainThread:@selector(bookFlightRequest) withObject:nil waitUntilDone:NO];
        }
    }
    else if (alertView.tag==1)
    {
       
    }
    else if (alertView.tag==2)
    {
        [self performSelectorOnMainThread:@selector(bookFlightRequest) withObject:nil waitUntilDone:NO];
    }
    else if(alertView.tag==1144)
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

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    
    
    
    check=-1;
    //SearchFareResponse Error
    
    if ( [elementName isEqualToString:@"SessionId"])
    {
        check=1;
    }
    
    //PNRNo
    if ( [elementName isEqualToString:@"PNRNo"])
    {
        check=2;
    }
    
    if ( [elementName isEqualToString:@"Error"])
    {
        check=12;
    }
    
    if ( [elementName isEqualToString:@"GrandTotal"])
    {
        check=0;
    }
    

}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
   

    if(check==0)
    {
        data.Amount=string;
    }
    if(check==1)
    {
        data.sessionId=string;
    }
    if(check==2)
    {
        pnrNo=string;
    }
    
    else if(check==12)
    {
        error=string;
        if ([error isEqualToString:@"Booking Decliened"]) {
            BookingDecliened=string;

        }
    }
   
    
    //check=-1;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
}

- (IBAction)goback:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)accpetTerms:(id)sender {
    
    UIButton * temp=(UIButton*)sender;
    
    if(termsAccepted==0)
    {
        termsAccepted=1;
        [temp setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    }
    else
    {
        termsAccepted=0;
        [temp setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)bookFare:(id)sender {
    
    if(termsAccepted==1)
    {
        [self performSelectorOnMainThread:@selector(pay) withObject:nil waitUntilDone:NO];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Accept Terms and Conditions." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (IBAction)readTerms:(id)sender {
    
    NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"BookingConditionViewController_iPhone";
    } else {
        nibname=@"BookingConditionViewController_iPad";
    }
    
    BookingConditionViewController *BCVC=[[BookingConditionViewController alloc]initWithNibName:nibname bundle:nil];
    
    [self.navigationController pushViewController:BCVC animated:YES];
    
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

- (IBAction)fareMatch:(id)sender {
    
    NSString *paxdetais=[data makePaxDetails];
    
    NSString *smsg=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                    "<soap:Body>\n"
                    "<BookFlight xmlns=\"http://tempuri.org/\">\n"
                    "<bookingXML>\n"
                    "<![CDATA["
                    "<BookingXML>\n"
                    "<SessionId>%@</SessionId>\n"
                    "<FlightDetail>\n"
                    "%@"
                    "</FlightDetail>\n"
                    "%@"
                    "<SearchDetail>\n"
                    "%@"
                    "</SearchDetail>\n"
                    "</BookingXML>\n"
                    "]]>"
                    "</bookingXML>\n"
                    "</BookFlight>\n"
                    "</soap:Body>\n"
                    "</soap:Envelope>",data.sessionId,data.requestItenary,paxdetais,data.searchQuery];

    
    
    NSArray *arr=[[NSArray alloc]initWithObjects:smsg, nil];
    
    [[MessageSender sharedCenter] performSelectorInBackground:@selector(bookingService:) withObject:arr];
    
    NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"FareDetailViewController_iPhone";
    } else {
        nibname=@"FareDetailViewController_iPad";
    }
    
    FareDetailViewController *BSVC=[[FareDetailViewController alloc]initWithNibName:nibname bundle:nil];
    BSVC.bookingDone=true;
    BSVC.pnrno=pnrNo;
    BSVC.paypalid=paymentId;
    BSVC.fromPcvc=YES;
    
    [self.navigationController pushViewController:BSVC animated:YES];

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Receive Single Payment

- (void)pay {
    // Remove our last completed payment, just for demo purposes.
    self.resultText = nil;
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:[dataStorage sharedCenter].TotalAmount];
    payment.currencyCode = @"GBP";
    payment.shortDescription = [dataStorage sharedCenter].Description;
    NSLog(@"%@",[dataStorage sharedCenter].TotalAmount);
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Payment is not processible.Please try again later" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self performSelectorOnMainThread:@selector(bookFlightRequest) withObject:nil waitUntilDone:NO];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"The Payment was not Successful Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert setTag:21];
    [alert show];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
    
    NSDictionary *confirmation=completedPayment.confirmation;
    if([[confirmation allKeys] containsObject:paypalresponsekey1])
    {
        NSDictionary *tempdict=[confirmation objectForKey:paypalresponsekey1];
        paymentId=[tempdict objectForKey:paypalresponseidkey1];
    }
    if([[confirmation allKeys] containsObject:paypalresponsekey2])
    {
        NSDictionary *tempdict=[confirmation objectForKey:paypalresponsekey1];
        if([[tempdict allKeys]containsObject:paypalresponsesubkey1])
        {
            NSDictionary *tempdict2=[tempdict objectForKey:paypalresponsesubkey1];
            paymentId=[tempdict2 objectForKey:paypalresponseidkey2];
        }
        else if ([[tempdict allKeys]containsObject:paypalresponsesubkey2])
        {
            NSDictionary *tempdict2=[tempdict objectForKey:paypalresponsesubkey2];
            paymentId=[tempdict2 objectForKey:paypalresponseidkey3];
        }
    }
    
    
}

-(void)setData
{
    @try{
        NSMutableArray *arr=[dataStorage sharedCenter].dataArray;
        UIView *tempview;
        myRect.origin.y=5;
        tempview=[[UIView alloc]initWithFrame:CGRectMake(5, myRect.origin.y, 310, 2)];
        [tempview setBackgroundColor:[UIColor whiteColor]];
        [scroller addSubview:tempview];
        /*if(page%2==0)
         tempview=firstview;
         else
         tempview=secondview;*/
        
        NSArray *subs=[tempview subviews];
        for (int i=0; i<[subs count]; i++) {
            UIView *subsv=[subs objectAtIndex:i];
            [subsv removeFromSuperview];
        }
        
        //[tempview setFrame:CGRectMake(5, 5, 310, 0)];
       // NSString *gt=[arr objectAtIndex:0];
        
        NSString *nibName=@"CustomCell_iPhone";
        CustomCell *sfc=[[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:5];
        
        [tempview addSubview:sfc];
        
        CGRect rec=tempview.frame;
        rec.size.height+=sfc.frame.size.height-5;
        [tempview setFrame:rec];
        
        CGRect temp;
        
        BOOL isinbound=false;
        for(int i=1;i<[arr count];i++)
        {
            flightdata *fldata=[arr objectAtIndex:i];
            if(fldata.isReturn==true && isinbound==false)
            {
                isinbound=true;
                sfc=[[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:2];
                
                temp=sfc.frame;
                temp.origin.y=rec.size.height+5;
                [sfc setFrame:temp];
                
                [tempview addSubview:sfc];
                rec.size.height+=sfc.frame.size.height;
                [tempview setFrame:rec];
            }
            
            sfc=[[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:4];
            
            sfc.dtime.text=fldata.dTime;
            sfc.ddate.text=fldata.dDate;
            sfc.dairpname.text=fldata.dAirpName;
            sfc.dairpcode.text=fldata.dAirpCode;
            if(fldata.dTerminal==nil || [fldata.dTerminal isKindOfClass:[NSNull class]])
                fldata.dTerminal=@"";
            sfc.dterminal.text=[NSString stringWithFormat:@"Terminal :%@",fldata.dTerminal];
            sfc.atime.text=fldata.aTime;
            sfc.adate.text=fldata.aDate;
            sfc.aairpname.text=fldata.aAirpName;
            sfc.aairpcode.text=fldata.aAirpCode;
            if(fldata.aTerminal==nil || [fldata.aTerminal isKindOfClass:[NSNull class]])
                fldata.aTerminal=@"";
            sfc.aterminal.text=[NSString stringWithFormat:@"Terminal :%@",fldata.aTerminal];
            sfc.equiptype.text=fldata.EquipType;
            sfc.fltnum.text=fldata.FltNum;
            sfc.url=fldata.AirlineLogoPath;
            
            if([sfc respondsToSelector:@selector(getpostimage)])
                [sfc performSelectorInBackground:@selector(getpostimage) withObject:Nil];
            
            temp=sfc.frame;
            temp.origin.y=rec.size.height+5;
            [sfc setFrame:temp];
            [tempview addSubview:sfc];
            rec.size.height=rec.size.height+temp.size.height+10;
            [tempview setFrame:rec];
            
            if(fldata.TransitTime!=nil && fldata.TransitTime.length>5)
            {
                transienttime.text=fldata.TransitTime;
                
                id copyOfView =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:transientview]];
                UIView *myView = (UIView *)copyOfView;
                temp=myView.frame;
                temp.origin.x=5;
                temp.origin.y=rec.size.height+5;
                [myView setFrame:temp];
                [tempview addSubview:myView];
                rec.size.height=rec.size.height+transienttime.frame.size.height+10;
                [tempview setFrame:rec];
            }
            
        }
        
        
        temp=termsView.frame;
        temp.origin.x=20;
        temp.origin.y=rec.size.height+10;
        [termsView setFrame:temp];
        [scroller addSubview:termsView];
        
        rec.size.height+=5;
        rec.size.height+=termsView.frame.size.height;
        [tempview setFrame:rec];
        
        [Generalfunctionclass addColoredlayer:tempview forColor:@"gray"];
        //[scroller addSubview:tempview];
        [scroller setContentSize:CGSizeMake(320, myRect.size.height+rec.size.height+10)];
        
        myRect.size.height+=rec.size.height;
        myRect.origin.y=myRect.size.height+10;
        myRect.size.height+=10;
        
        [fareview setFrame:CGRectMake(0, 58, fareview.frame.size.width, fareview.frame.size.height)];
        [self.view addSubview:fareview];
        
    }
    @catch (NSException *ex) {
        NSLog(@"%@",[ex description]);
    }
    
}

- (IBAction)goHome:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
