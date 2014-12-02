//
//  PessengerInfoViewController.m
//  TravelHouseUK
//
//  Created by AR on 28/01/2014.
//
//

#import "PessengerInfoViewController.h"
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "

@interface PessengerInfoViewController ()

@end

@implementation PessengerInfoViewController{
    int searchType;
    NSMutableData *myWebData;
    NSString *error;
    NSString *paymentId;
    int check;
    NSString *pnrNo;
}

@synthesize PessengersView,bgScroll,pessengersCounter,pessengerNumberLbl,totallPessengers,fname,lName,gender,dob,passport,pickupdate,barBtn,accesoryview,totallAdults,totallInfants,totallChilds;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    data.sessionId=nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    rights.text=[NSString stringWithFormat:@"All Rights Reserved %@",yearString];

    
    self.gender.delegate = self;
    self.fname.delegate = self;
    self.lName.delegate = self;
    self.passport.delegate = self;

    pessengerData = [[NSMutableArray alloc] init];
    data = [dataStorage sharedCenter];
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];

    self.dob.inputAccessoryView=accesoryview;
    self.dob.inputView=pickupdate;
    self.dob.delegate=self;
    

    
    
    
    NSLog(@"%d",self.pessengersCounter);
    
    
    if( self.pessengersCounter <= 0)
    {
        self.pessengersCounter = 1;
    }
    else if ((self.pessengersCounter - 1) < data.pessengersArray.count)
    {
        NSMutableArray *array = [data.pessengersArray objectAtIndex:self.pessengersCounter-1];
        self.fname.text = [array objectAtIndex:1];
        self.lName.text = [array objectAtIndex:2];
        self.gender.text = [array objectAtIndex:0];
        self.dob.text = [array objectAtIndex:3];
        self.passport.text = [array objectAtIndex:4];
        
    }

    
    if(self.pessengersCounter <= self.totallAdults)
        self.pessengerNumberLbl.text = [NSString stringWithFormat:@"Adult - %d",self.pessengersCounter];
    else if(self.pessengersCounter <= self.totallAdults + self.totallInfants)
        self.pessengerNumberLbl.text = [NSString stringWithFormat:@"Infant - %d",self.pessengersCounter];
    else
        self.pessengerNumberLbl.text = [NSString stringWithFormat:@"Childs - %d",self.pessengersCounter];

    
    [self settingScroller];
    
    
    
    //Picker
    
    arrState= [[NSArray alloc] initWithObjects:@"Mr.",@"Ms.",@"Mrs.",@"Miss", nil];
    pktStatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 43, 320, 480)];
    pktStatePicker.delegate = self;
    pktStatePicker.dataSource = self;
    [pktStatePicker  setShowsSelectionIndicator:YES];
    gender.text=@"Mr.";
    
    self.gender.inputView =  pktStatePicker  ;
    
    // Create done button in UIPickerView
    
    mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    [barItems addObject:doneBtn];
    [mypickerToolbar setItems:barItems animated:YES];
    self.gender.inputAccessoryView = mypickerToolbar;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Setting Scroller

-(void) settingScroller
{
    //bgScroll.delegate = self;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //---------- For passenger1view ---
        self.PessengersView.frame = CGRectMake(0, 0, bgScroll.frame.size.width, bgScroll.frame.size.height);
        [bgScroll addSubview:self.PessengersView];
        
        bgScroll.contentSize = CGSizeMake(self.PessengersView.frame.origin.x + self.PessengersView.frame.size.width, 270);
        
    }
    else
    {
        
       
        //---------- For passenger1view ---
        self.PessengersView.frame = CGRectMake(0, 0, bgScroll.frame.size.width, bgScroll.frame.size.height);
        [bgScroll addSubview:self.PessengersView];
        
        bgScroll.contentSize = CGSizeMake(self.PessengersView.frame.origin.x + self.PessengersView.frame.size.width, 270);
        
    }
    
    
    
    
}

#pragma mark - Next Pessenger

- (IBAction)nextPessenger
{
    NSLog(@"pessengersCounter :%d \n totallPessengers:%d",self.pessengersCounter,self.totallPessengers);
    //self.totallPessengers = 1;
    
    if (self.pessengersCounter < self.totallPessengers)
    {
        if(self.fname.text.length <=0 || self.lName.text.length <=0 || self.gender.text.length <=0 || self.dob.text.length <=0 || self.passport.text.length <=0)
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
            [pessengerData removeAllObjects];
            
            
            
            if([self.gender.text isEqualToString:@"Mr."])
            {
                [pessengerData addObject:@"M"];
            }
            else
            {
                [pessengerData addObject:@"F"];
            }
            
            [pessengerData addObject:self.fname.text];
            [pessengerData addObject:self.lName.text];
            [pessengerData addObject:self.dob.text];
            [pessengerData addObject:self.passport.text];
            [pessengerData addObject:self.gender.text];
            
            NSLog(@"inserting on : %d",self.pessengersCounter - 1);
            
            if (self.pessengersCounter > data.pessengersArray.count)
                [data.pessengersArray insertObject:pessengerData atIndex:self.pessengersCounter - 1];
            else
                [data.pessengersArray replaceObjectAtIndex:self.pessengersCounter-1 withObject:pessengerData];
            
            
            NSString *nibname=@"";
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                nibname=@"PessengerInfoViewController_iPhone";
            } else {
                nibname=@"PessengerInfoViewController_iPad";
            }
            
            PessengerInfoViewController *FVC=[[PessengerInfoViewController alloc]initWithNibName:nibname bundle:nil];
            FVC.pessengersCounter = self.pessengersCounter + 1;
            FVC.totallPessengers = self.totallPessengers;
            FVC.totallAdults = self.totallAdults;
            FVC.totallInfants = self.totallInfants;
            FVC.totallChilds = data.totallChilds;
            [self.navigationController pushViewController:FVC animated:YES];
        }
    }
    else
    {
        
        if(self.fname.text.length <=0 || self.lName.text.length <=0 || self.gender.text.length <=0 || self.dob.text.length <=0 || self.passport.text.length <=0)
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
            [pessengerData removeAllObjects];
            if([self.gender.text isEqualToString:@"Mr."])
            {
                [pessengerData addObject:@"M"];
            }
            else
            {
                [pessengerData addObject:@"F"];
            }
            
            [pessengerData addObject:self.fname.text];
            [pessengerData addObject:self.lName.text];
            [pessengerData addObject:self.dob.text];
            [pessengerData addObject:self.passport.text];
            [pessengerData addObject:self.gender.text];
            
            NSLog(@"inserting on : %d",self.pessengersCounter - 1);
            
            if (self.pessengersCounter > data.pessengersArray.count)
                [data.pessengersArray insertObject:pessengerData atIndex:self.pessengersCounter - 1];
            else
                [data.pessengersArray replaceObjectAtIndex:self.pessengersCounter-1 withObject:pessengerData];
        
            [SVProgressHUD showWithStatus:@"Loading..."];
            self.view.userInteractionEnabled=NO;
            [self airFareMatchRequest];
            
            }
    }
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    
    
    
    check=-1;
   
    if ( [elementName isEqualToString:@"GrandTotal"])
    {
        check=0;
    }

    
    if ( [elementName isEqualToString:@"SessionId"])
    {
        check=1;
    }
    
    //PNRNo
    if ( [elementName isEqualToString:@"PNRNo"])
    {
        check=2;
    }
    
    //SearchFareResponse Error
    if ( [elementName isEqualToString:@"BookFlightResponse"])
    {
        check=12;
    }
    if ( [elementName isEqualToString:@"Error"])
    {
        check=12;
    }
    if ( [elementName isEqualToString:@"error"])
    {
        check=12;
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
    }
    
    //check=-1;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
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
    
    NSLog(@"Request %@",smsg);
    

    
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
    [SVProgressHUD showSuccessWithStatus:@"Done!"];
    self.view.userInteractionEnabled=YES;
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
    
    NSLog(@"Response  %@",htmlString);
    
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
            NSString *nibname=@"";
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                nibname=@"PessengerConfirmationViewController_iPhone";
            } else {
                nibname=@"PessengerConfirmationViewController_iPad";
            }
            
            PessengerConfirmationViewController *FVC=[[PessengerConfirmationViewController alloc]initWithNibName:nibname bundle:nil];
            [self.navigationController pushViewController:FVC animated:YES];

        }
        else
        {
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
}

#pragma mark - previousPessenger

- (IBAction)previousPessenger
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"pessengersCounter:Pre-->%d",self.pessengersCounter);

}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.tag == 1)
    {
        mypickerToolbar.hidden=NO;
        pktStatePicker.hidden=NO;
    }
    else if(textField.tag == 3)
    {
    
        [bgScroll setContentSize:CGSizeMake(300, 500)];
        CGPoint p=CGPointMake(0, 80);
        [bgScroll setContentOffset:p animated:YES];
    }
    else if(textField.tag == 4)
    {
        
        [bgScroll setContentSize:CGSizeMake(300, 500)];
        CGPoint p=CGPointMake(0, 120);
        [bgScroll setContentOffset:p animated:YES];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        mydate=[NSDate date];
        
        self.dob.text=[dateFormatter stringFromDate:mydate];
        [pickupdate setMaximumDate:mydate];

    }
    else if(textField.tag == 5)
    {
        [bgScroll setContentSize:CGSizeMake(300, 500)];
        CGPoint p=CGPointMake(0, 160);
        [bgScroll setContentOffset:p animated:YES];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [bgScroll setContentSize:CGSizeMake(300, 371)];
    CGPoint p=CGPointMake(0, 0);
    [bgScroll setContentOffset:p animated:YES];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.bgScroll setContentSize:CGSizeMake(300, 301)];
    CGPoint p=CGPointMake(0, 0);
    [self.bgScroll setContentOffset:p animated:YES];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range     replacementString:(NSString *)string {
    if (textField!=dob) {
        
        
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

#pragma mark - DatePicker

- (IBAction)datechange:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    mydate=self.pickupdate.date;
    //date.text = [NSString stringWithFormat:@"%@", haircutdate.date];
    self.dob.text=[dateFormatter stringFromDate:mydate];
    
    
    
}

- (IBAction)dropDown
{
   [self.gender becomeFirstResponder];
}


- (IBAction)donechanges:(id)sender {
    
    [self textFieldShouldReturn:self.dob];
    
}


#pragma mark - UIPickerView


-(void)pickerDoneClicked

{
  	NSLog(@"Done Clicked");
    
    [self.gender resignFirstResponder];
    mypickerToolbar.hidden=YES;
    pktStatePicker.hidden=YES;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
    
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return [arrState count];
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    return [arrState objectAtIndex:row];
    
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    self.gender.text = [arrState objectAtIndex:row];
    
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

- (IBAction)next {
    
    NSLog(@"pessengersCounter :%d \n totallPessengers:%d",self.pessengersCounter,self.totallPessengers);
    //self.totallPessengers = 1;
    
    if (self.pessengersCounter < self.totallPessengers)
    {
        if(self.fname.text.length <=0 || self.lName.text.length <=0 || self.gender.text.length <=0 || self.dob.text.length <=0 || self.passport.text.length <=0)
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
            [pessengerData removeAllObjects];
            
            
            
            if([self.gender.text isEqualToString:@"Mr."])
            {
                [pessengerData addObject:@"M"];
            }
            else
            {
                [pessengerData addObject:@"F"];
            }
            
            [pessengerData addObject:self.fname.text];
            [pessengerData addObject:self.lName.text];
            [pessengerData addObject:self.dob.text];
            [pessengerData addObject:self.passport.text];
            [pessengerData addObject:self.gender.text];
            
            NSLog(@"inserting on : %d",self.pessengersCounter - 1);
            
            if (self.pessengersCounter > data.pessengersArray.count)
                [data.pessengersArray insertObject:pessengerData atIndex:self.pessengersCounter - 1];
            else
                [data.pessengersArray replaceObjectAtIndex:self.pessengersCounter-1 withObject:pessengerData];
            
            
            NSString *nibname=@"";
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                nibname=@"PessengerInfoViewController_iPhone";
            } else {
                nibname=@"PessengerInfoViewController_iPad";
            }
            
            PessengerInfoViewController *FVC=[[PessengerInfoViewController alloc]initWithNibName:nibname bundle:nil];
            FVC.pessengersCounter = self.pessengersCounter + 1;
            FVC.totallPessengers = self.totallPessengers;
            FVC.totallAdults = self.totallAdults;
            FVC.totallInfants = self.totallInfants;
            FVC.totallChilds = data.totallChilds;

            [self.navigationController pushViewController:FVC animated:YES];
        }
    }
    else
    {
        
        if(self.fname.text.length <=0 || self.lName.text.length <=0 || self.gender.text.length <=0 || self.dob.text.length <=0 || self.passport.text.length <=0)
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
            [pessengerData removeAllObjects];
            if([self.gender.text isEqualToString:@"Mr."])
            {
                [pessengerData addObject:@"M"];
            }
            else
            {
                [pessengerData addObject:@"F"];
            }
            
            [pessengerData addObject:self.fname.text];
            [pessengerData addObject:self.lName.text];
            [pessengerData addObject:self.dob.text];
            [pessengerData addObject:self.passport.text];
            [pessengerData addObject:self.gender.text];
            
            NSLog(@"inserting on : %d",self.pessengersCounter - 1);
            
            if (self.pessengersCounter > data.pessengersArray.count)
                [data.pessengersArray insertObject:pessengerData atIndex:self.pessengersCounter - 1];
            else
                [data.pessengersArray replaceObjectAtIndex:self.pessengersCounter-1 withObject:pessengerData];
            
            NSString *nibname=@"";
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                nibname=@"PessengerConfirmationViewController_iPhone";
            } else {
                nibname=@"PessengerConfirmationViewController_iPad";
            }
            
            PessengerConfirmationViewController *FVC=[[PessengerConfirmationViewController alloc]initWithNibName:nibname bundle:nil];
            [self.navigationController pushViewController:FVC animated:YES];
        }
    }

}

- (IBAction)goHome:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
