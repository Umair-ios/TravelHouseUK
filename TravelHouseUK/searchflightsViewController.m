//
//  searchflightsViewController.m
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 31/12/2013.
//
//

#import "searchflightsViewController.h"
#import "SearchResultViewController.h"
#import "dataStorage.h"

@interface searchflightsViewController ()

@end

@implementation searchflightsViewController{
    float adtTax;
    float adtbfare;
    float adtmarkup;
    float totaladtNumber;
    float adttotal;
    float chTax;
    float chbfare;
    float chmarkup;
    float totalchNumber;
    float chtotal;
    float infTax;
    float infbfare;
    float infmarkup;
    float totalinfNumber;
    float inftotal;

}
@synthesize departuredatepicker,returndatepicker,accesoryview;
@synthesize txtDdate,txtflyingfrom,txtflyingto,txtRdate,txtAirline,txtNoAdult,txtNoChild,txtNoInfant,txtFlyingClass,classPicker,returnRadiobtn,oneRadiobtn;

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

    
    [scroller setContentSize:CGSizeMake(scroller.frame.size.width, 580)];
    
   totaladtNumber=totalchNumber=totalinfNumber=adtbfare=adtmarkup=adtTax=adttotal=chbfare=chTax=chtotal=chmarkup=infbfare=infmarkup=infTax=inftotal=0;
    txtflyingfrom.delegate=self;
    txtflyingto.delegate=self;
    txtDdate.delegate=self;
    txtRdate.delegate=self;
    txtAirline.delegate=self;
    txtNoInfant.delegate=self;
    txtNoChild.delegate=self;
    txtNoAdult.delegate=self;
    txtFlyingClass.delegate=self;
    
    txtNoAdult.inputAccessoryView=accesoryview;
    txtNoChild.inputAccessoryView=accesoryview;
    txtNoInfant.inputAccessoryView=accesoryview;
    
    directFlight=0;
    ReturnFlight=@"R";
    [txtRdate setEnabled:true];
    
    txtFlyingClass.inputView=classPicker;
    txtFlyingClass.inputAccessoryView=accesoryview;
    txtFlyingClass.text=@"Economy";
    cabinClassValue=@"Y";
    
    //txtflyingfrom.inputView=flyingfrom;
    //txtflyingfrom.inputAccessoryView=accesoryview;
    
    //txtflyingto.inputView=flyingto;
    //txtflyingto.inputAccessoryView=accesoryview;
    
    streetTableview.rowHeight = 44;
    
    txtDdate.inputView=departuredatepicker;
    txtDdate.inputAccessoryView=accesoryview;
    
    txtRdate.inputView=returndatepicker;
    txtRdate.inputAccessoryView=accesoryview;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    mydate=[NSDate date];
    
    NSDateComponents *offset = [[NSDateComponents alloc] init] ;
    [offset setDay:3];
    myRdate = [[NSCalendar currentCalendar] dateByAddingComponents:offset toDate:mydate options:0];
    
    [departuredatepicker setMinimumDate:mydate];
    [returndatepicker setMinimumDate:mydate];
    [returndatepicker setDate:myRdate];

    
    CabinClasses=[[NSArray alloc]initWithObjects:@"Economy",@"Premium Economy",@"Business",@"FirstClass", nil];
    classPicker.delegate=self;
    classPicker.dataSource=self;
    
    UITapGestureRecognizer *tapgest=[[UITapGestureRecognizer alloc]init];
    [tapgest setNumberOfTapsRequired:1];
    [tapgest setNumberOfTouchesRequired:1];
    [tapgest addTarget:self action:@selector(removeTableview:)];
    
    
    tapgest.delegate=self;
    //[tapgest setDelaysTouchesBegan:YES];
    [scroller addGestureRecognizer:tapgest];
    jsonDataArray = [[NSMutableArray alloc]init];
}

-(void)removeTableview:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:scroller];
    //CGPoint tapPointInView = [self.view convertPoint:location toView:self->scroller];
    
    CGRect rec=streetTableview.frame;
    if(!CGRectContainsPoint(rec, location))
    {
        // NSLog(@"YES");
        if(txtAirline.isEditing)
        {
            [txtAirline resignFirstResponder];
            [streetTableview removeFromSuperview];
        }
        else if (txtflyingfrom.isEditing)
        {
            [txtflyingfrom resignFirstResponder];
            [streetTableview removeFromSuperview];
        }
        else if (txtflyingto.isEditing)
        {
            [txtflyingto resignFirstResponder];
            [streetTableview removeFromSuperview];
        }
        else if([scroller.subviews containsObject:streetTableview])
        {
            [txtflyingfrom resignFirstResponder];
            [txtflyingto resignFirstResponder];
            [txtAirline resignFirstResponder];
            [streetTableview removeFromSuperview];
        }
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if(touch.view!=scroller)
    {
        return NO;
    }
    else if ([touch.view isKindOfClass:[UILabel class]])
    {
        return NO;
    }
    else if ([touch.view isKindOfClass:[UIImageView class]])
    {
        return NO;
    }
    else
        return YES;
    
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
    
    txtFlyingClass.text=[CabinClasses objectAtIndex:row];
    if(row==0)
    {
        cabinClassValue=@"Y";
    }
    else if (row==1)
    {
        cabinClassValue=@"W";
    }
    else if (row==2)
    {
        cabinClassValue=@"C";
    }
    else if (row==3)
    {
        cabinClassValue=@"F";
    }
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [scroller setContentSize:CGSizeMake(320, 650)];
        if(textField==txtflyingfrom)
        {
            [scroller setContentSize:CGSizeMake(320, 640)];
            CGPoint p=CGPointMake(0, 30);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtflyingto)
        {
            [scroller setContentSize:CGSizeMake(320, 640)];
            CGPoint p=CGPointMake(0, 70);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtDdate)
        {
            if (textField.text.length<1) {
                mydate=departuredatepicker.date;
                textField.text=[dateFormatter stringFromDate:mydate];
            }
            
            CGPoint p=CGPointMake(0, 150);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtRdate)
        {
            if (textField.text.length<1) {

                NSDateComponents *offset = [[NSDateComponents alloc] init] ;
                [offset setDay:3];
                myRdate = [[NSCalendar currentCalendar] dateByAddingComponents:offset toDate:mydate options:0];
                textField.text=[dateFormatter stringFromDate:myRdate];
            }
            
            CGPoint p=CGPointMake(0, 200);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtAirline)
        {
            
            CGPoint p=CGPointMake(0, 350);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtFlyingClass)
        {
            
            CGPoint p=CGPointMake(0, 270);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtNoAdult || textField==txtNoChild || textField==txtNoInfant)
        {
            
            CGPoint p=CGPointMake(0, 340);
            [scroller setContentOffset:p animated:YES];
        }
    }
    else
    {
        if(textField==txtDdate)
        {
            if (textField.text.length<1) {
                mydate=departuredatepicker.date;
                textField.text=[dateFormatter stringFromDate:mydate];
            }
            
        }
        else if(textField==txtRdate)
        {
            if (textField.text.length<1) {
                mydate=returndatepicker.date;
                textField.text=[dateFormatter stringFromDate:mydate];
            }
        }
    }
    
    
}



-(IBAction)TextChange:(UITextField *)textField
{
    
    if(textField.text.length>0)
        [self performSelectorInBackground:@selector(searchHintfromservice:) withObject:textField];
    
}

-(void)searchHintfromservice:(UITextField *)textField
{
    NSString *searchtype=@"";
    if(textField==txtflyingfrom)
    {
        ffrom=@"";
        searchtype=@"departure.php";
        hintCheck=1;
    }
    else if (textField==txtflyingto)
    {
        fto=@"";
        searchtype=@"destination.php";
        hintCheck=2;
    }
    else if (textField==txtAirline)
    {
        airline=@"";
        searchtype=@"airliner.php";
        hintCheck=3;
    }
    
    NSString *searchHint = [NSString stringWithFormat:@"http://www.travelhouseuk.co.uk/includes/search/%@?term=%@",searchtype,textField.text];
    
    NSError *Error=nil;
    
    searchHint = [searchHint stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:searchHint];
    
    NSData *jsonData=[[NSData alloc]initWithContentsOfURL:url];
    
    
    if (jsonData) {
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&Error];
        
        if (Error) {
            NSLog(@"error is %@", [Error localizedDescription]);
            
            
        }
        
        else
        {
     
            @try{
            if(jsonDataArray==Nil)
                jsonDataArray=[[NSMutableArray alloc]init];
            
            [jsonDataArray removeAllObjects];
            jsonDataArray=[jsonObjects mutableCopy];
            
            if(streetTableview==nil || [streetTableview isKindOfClass: [NSNull class]])
            {
                streetTableview = [[UITableView alloc]initWithFrame:CGRectZero];
                streetTableview.rowHeight = 44;
            }
            streetTableview.delegate=self;
            streetTableview.dataSource=self;
            
            CGRect rec=textField.frame;
            //[self.view addSubview:streetTableview];
            
            //[self performSelectorOnMainThread:@selector(addtblview) withObject:nil waitUntilDone:YES];
            if(![scroller.subviews containsObject:streetTableview])
            [scroller addSubview:streetTableview];
            
            [Generalfunctionclass addColoredlayer:streetTableview forColor:@"gray"];
            
            rec.origin.x+=1;
            rec.size.width-=2;
            rec.origin.y+=rec.size.height+1;
            
            NSUInteger count=[jsonDataArray count];
            if(count>5)
            {
                count=5;
                [streetTableview setScrollEnabled:YES];
            }
            else
                [streetTableview setScrollEnabled:NO];
            
            [streetTableview setUserInteractionEnabled:YES];
            
            rec.size.height=streetTableview.rowHeight*count;
            
            //rec.size.height=self.view.frame.size.height-rec.origin.y-10;
            
            [streetTableview setFrame:rec];
            
            [streetTableview reloadData];
            }
            @catch (NSException *ex) {
                NSLog(@"Exception%@",[ex description]);
            }
        }
            
            
    }
        
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        [scroller setContentSize:CGSizeMake(320, 580)];
        if(textField==txtflyingfrom)
        {
            
            CGPoint p=CGPointMake(0, 10);
            [scroller setContentOffset:p animated:YES];
            if([scroller.subviews containsObject:streetTableview])
                [streetTableview removeFromSuperview];
        }
        else if(textField==txtflyingto)
        {
            
            CGPoint p=CGPointMake(0, 30);
            [scroller setContentOffset:p animated:YES];
            if([scroller.subviews containsObject:streetTableview])
                [streetTableview removeFromSuperview];
            
        }
        else if(textField==txtDdate)
        {
            
            CGPoint p=CGPointMake(0, 80);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtRdate)
        {
            
            CGPoint p=CGPointMake(0, 100);
            [scroller setContentOffset:p animated:YES];
        }
        else if(textField==txtAirline)
        {
            
            CGPoint p=CGPointMake(0, 210);
            [scroller setContentOffset:p animated:YES];
            if([scroller.subviews containsObject:streetTableview])
                [streetTableview removeFromSuperview];
            
        }
        else if(textField==txtFlyingClass)
        {
            
            CGPoint p=CGPointMake(0, 150);
            [scroller setContentOffset:p animated:YES];
            
            
        }
        else if(textField==txtNoAdult || textField==txtNoChild || textField==txtNoInfant)
        {
            
            CGPoint p=CGPointMake(0, 280);
            [scroller setContentOffset:p animated:YES];
        }
        
        
    }
    else
    {
        if([scroller.subviews containsObject:streetTableview])
            [streetTableview removeFromSuperview];
    }
    
    [textField resignFirstResponder];
    
    /* if(textField.tag == 0)
     {
     [businessTableView removeFromSuperview];
     }*/
    
    return YES;
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tblView numberOfRowsInSection:(NSInteger)section
{
    
    return [jsonDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tblView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // Configure the cell...
    @try {
        
        if(indexPath.row<[jsonDataArray count])
        {
            NSDictionary *dictData=[jsonDataArray objectAtIndex:indexPath.row];
            cell.textLabel.text=[dictData objectForKey:@"label"];
        }
    }
    @catch (NSException *ex) {
        NSLog(@"%@",[ex description]);
    }
    
    return cell;
    
}


- (void)tableView:(UITableView *)tblView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        if(hintCheck==1)
        {
            if(indexPath.row < jsonDataArray.count)
            {
                NSDictionary *dictData=[jsonDataArray objectAtIndex:indexPath.row];
                txtflyingfrom.text=[dictData objectForKey:@"label"];
                ffrom=[dictData objectForKey:@"id"];
            }
            //[streetTableview removeFromSuperview];
            [self textFieldShouldReturn:txtflyingfrom];
        }
        else if (hintCheck==2)
        {
            if(indexPath.row < jsonDataArray.count)
            {
                NSDictionary *dictData=[jsonDataArray objectAtIndex:indexPath.row];
                txtflyingto.text=[dictData objectForKey:@"label"];
                fto=[dictData objectForKey:@"id"];
            }
            //[streetTableview removeFromSuperview];
            [self textFieldShouldReturn:txtflyingto];
        }
        else if (hintCheck==3)
        {
            if(indexPath.row < jsonDataArray.count)
            {
                NSDictionary *dictData=[jsonDataArray objectAtIndex:indexPath.row];
                txtAirline.text=[dictData objectForKey:@"label"];
                airline=[dictData objectForKey:@"id"];
            }
            //[streetTableview removeFromSuperview];
            [self textFieldShouldReturn:txtAirline];
        }
    }
    @catch (NSException *ex) {
        NSLog(@"%@",[ex description]);
    }
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

# pragma mark

- (IBAction)subscribe:(id)sender {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Subscribe" message:@"To Subscribe to our newsletter Please enter your email." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Subscribe",nil, nil];
    alert.tag=1144;
    alert.alertViewStyle=UIAlertViewStyleLoginAndPasswordInput;
    [[alert textFieldAtIndex:0] setPlaceholder:@"Enter Your Name"];
    [[alert textFieldAtIndex:1] setPlaceholder:@"Enter Your Email"];
    [alert textFieldAtIndex:1].secureTextEntry=false;
    [alert show];
    
}

- (IBAction)ValueChanged:(id)sender {
    
    UITextField *textField=(UITextField*)sender;
    if(textField.tag==1 || textField.tag==2 || textField.tag==3)
    {
        NSString *s=textField.text;
        if(s.length>1)
        {
            textField.text=[NSString stringWithFormat:@"%c",[s characterAtIndex:1]];
        }
    }
    
}

- (IBAction)editchanged:(id)sender {
    UITextField *textField=(UITextField*)sender;
    if(textField.tag==1 || textField.tag==2 || textField.tag==3)
    {
        NSString *s=textField.text;
        if(s.length>1)
        {
            textField.text=[NSString stringWithFormat:@"%c",[s characterAtIndex:1]];
        }
    }
    
}

- (IBAction)showKeyboard:(id)sender {
    UIButton * temp=(UIButton*)sender;
    
    if(temp.tag==1)
    {
        [txtNoAdult becomeFirstResponder];
        
    }
    else if(temp.tag==2)
    {
        [txtNoChild becomeFirstResponder];
    }
    else if(temp.tag==3)
    {
        [txtNoInfant becomeFirstResponder];
    }
    
}

- (IBAction)datechange:(id)sender {
    UIDatePicker *temp=(UIDatePicker*)sender;
    
    if(temp==returndatepicker)
    {
        [departuredatepicker setMaximumDate:returndatepicker.date];
        mydate=returndatepicker.date;
        txtRdate.text=[dateFormatter stringFromDate:mydate];
    }
    else
    {
        [returndatepicker setMinimumDate:departuredatepicker.date];
        mydate=departuredatepicker.date;
        txtDdate.text=[dateFormatter stringFromDate:mydate];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.userInteractionEnabled=YES;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[dataStorage sharedCenter] clearData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchflights:(id)sender
{
    /*obj=[[NSMutableArray alloc]init];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"xmltest" ofType:@"txt"];
    NSData *data=[[NSData alloc]initWithContentsOfFile:path];
    NSXMLParser *p=[[NSXMLParser alloc]initWithData:data];
    [p setDelegate:self];
    [p setShouldResolveExternalEntities:YES];
    //[p setShouldProcessNamespaces:YES];
    [p parse];
    
    SearchResultViewController *op=[[SearchResultViewController alloc]initWithNibName:@"SearchResultViewController" bundle:nil];
    
    [op setSearchResponse:obj];
    
    [self.navigationController pushViewController:op animated:YES];*/
    
    int noadult=[txtNoAdult.text intValue];
    int nochild=[txtNoChild.text intValue];
    int noinfant=[txtNoInfant.text intValue];
    
    bool passengerCheck=true;
    NSString *passengerErrorMsg=@"";
    
    if(noadult<1)
    {
        passengerCheck=false;
        passengerErrorMsg=@"Please Enter no of Adult Passenger.";
    }
    else if (nochild>noadult*2)
    {
        passengerCheck=false;
        passengerErrorMsg=@"Max No. of children can only be double of adults count";
    }
    else if (noinfant>noadult)
    {
        passengerCheck=false;
        passengerErrorMsg=@"Max No. of Infants should not exceed to No. of Adults";
    }
    
    int returndatecheck=0;
    if([ReturnFlight isEqualToString:@"R"] && txtRdate.text.length>0)
    {
        returndatecheck=1;
    }
    else if ([ReturnFlight isEqualToString:@"R"] && txtRdate.text.length<1)
    {
        returndatecheck=0;
    }
    else if ([ReturnFlight isEqualToString:@"O"])
    {
        returndatecheck=1;
    }
    
    if(txtDdate.text.length>0 && txtflyingfrom.text.length>0 && txtflyingto.text.length>0 && ffrom.length>0 && fto.length>0 && noadult>0 && returndatecheck==1 && passengerCheck)
    {
        if (airline.length==0 || txtAirline.text.length==0) {
            airline=@"ALL";
        }
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        self.view.userInteractionEnabled=NO;
       /* NSString *soapMessage=@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
        "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
        "<soap:Body>\n"
        "<SearchFare xmlns=\"http://tempuri.org/\" >\n"
        "<InputSTR>\n"
        "<![CDATA["
        "<AirSearchQuery>\n"
        "<Master>\n"
        "<CompanyId>TravelHouseAPI</CompanyId>\n"
        "<AgentId>1</AgentId>\n"
        "<BranchId>1</BranchId>\n"
        "<CoustmerType>DIR</CoustmerType>\n"
        "</Master>\n"
        "<JourneyType>R</JourneyType>\n"
        "<Segments>\n"
        "<Segment id=\"1\">\n"
        "<Origin>LHR</Origin>\n"
        "<Destination>JER</Destination>\n"
        "<Date>01-03-2014</Date>\n"
        "</Segment>\n"
        "<Segment id=\"2\">\n"
        "<Origin>JER</Origin>\n"
        "<Destination>LHR</Destination>\n"
        "<Date>10-03-2014</Date>\n"
        "</Segment>\n"
        "</Segments>\n"
        "<PaxDetail>\n"
        "<NoAdult>1</NoAdult>\n"
        "<NoChild>0</NoChild>\n"
        "<NoInfant>0</NoInfant>\n"
        "</PaxDetail>\n"
        "<Flexi>1</Flexi>\n"
        "<Direct>0</Direct>\n"
        "<Cabin>\n"
        "<Class>Y</Class>\n"
        "</Cabin>\n"
        "<Airlines>\n"
        "<Airline>ALL</Airline>\n"
        "</Airlines>\n"
        "<FareType>SRA</FareType>\n"
        "<Availability>AF</Availability>\n"
        "<Authentication>\n"
        "<HAP>HP_138116058379845</HAP>\n"
        "<HapPassword>tha@83!</HapPassword>\n"
        "<HapType>LIVE</HapType>\n"
        "</Authentication>\n"
        "</AirSearchQuery>\n"
        "]]>"
        "</InputSTR>\n"
        "</SearchFare>\n"
        "</soap:Body>\n"
        "</soap:Envelope>";*/
        
        /*http://www.travelhouseuk.co.uk/bookings/?destIATA=JER&depIATA=LHR&Flexi=0&directflights=none&dateday=12&datemonth=03&dateyear=2014&dateday2=21&datemonth2=04&dateyear2=2014&btnTrip=return&adult=1&0=0&infant=0&class=0&airlineIATA=any#*/
        
        NSString *desc=@"";
        NSString *segments=NULL;
        if([ReturnFlight isEqualToString:@"O"])
        {
            segments=[NSString stringWithFormat:@"<Segments>\n"
                      "<Segment id=\"1\">\n"
                      "<Origin>%@</Origin>\n"
                      "<Destination>%@</Destination>\n"
                      "<Date>%@</Date>\n"
                      "</Segment>\n"
                      "</Segments>\n",ffrom,fto,txtDdate.text];
            desc=[NSString stringWithFormat:@"Oneway Ticket:%@ to %@",txtflyingfrom.text,txtflyingto.text];
        }
        else
        {
            segments=[NSString stringWithFormat:@"<Segments>\n"
                      "<Segment id=\"1\">\n"
                      "<Origin>%@</Origin>\n"
                      "<Destination>%@</Destination>\n"
                      "<Date>%@</Date>\n"
                      "</Segment>\n"
                      "<Segment id=\"2\">\n"
                      "<Origin>%@</Origin>\n"
                      "<Destination>%@</Destination>\n"
                      "<Date>%@</Date>\n"
                      "</Segment>\n"
                      "</Segments>\n",ffrom,fto,txtDdate.text,fto,ffrom,txtRdate.text];
            desc=[NSString stringWithFormat:@"Return Ticket:%@ to %@",txtflyingfrom.text,txtflyingto.text];
        }
        
        NSString *smsg=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                        "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                        "<soap:Body>\n"
                        "<SearchFare xmlns=\"http://tempuri.org/\" >\n"
                        "<InputSTR>\n"
                        "<![CDATA["
                        "<AirSearchQuery>\n"
                        "<Master>\n"
                        "<CompanyId>TravelHouseAPI</CompanyId>\n"
                        "<AgentId>1</AgentId>\n"
                        "<BranchId>1</BranchId>\n"
                        "<CoustmerType>DIR</CoustmerType>\n"
                        "</Master>\n"
                        "<JourneyType>%@</JourneyType>\n"
                        "%@"
                        "<PaxDetail>\n"
                        "<NoAdult>%d</NoAdult>\n"
                        "<NoChild>%d</NoChild>\n"
                        "<NoInfant>%d</NoInfant>\n"
                        "</PaxDetail>\n"
                        "<Flexi>0</Flexi>\n"
                        "<Direct>%d</Direct>\n"
                        "<Cabin>\n"
                        "<Class>%@</Class>\n"
                        "</Cabin>\n"
                        "<Airlines>\n"
                        "<Airline>%@</Airline>\n"
                        "</Airlines>\n"
                        "<FareType>SRA</FareType>\n"
                        "<Availability>AF</Availability>\n"
                        "<Authentication>\n"
                        "<HAP>HP_138116058379845</HAP>\n"
                        "<HapPassword>tha@83!</HapPassword>\n"
                        "<HapType>LIVE</HapType>\n"
                        "</Authentication>\n"
                        "</AirSearchQuery>\n"
                        "]]>"
                        "</InputSTR>\n"
                        "</SearchFare>\n"
                        "</soap:Body>\n"
                        "</soap:Envelope>",ReturnFlight,segments,noadult,nochild,noinfant,directFlight,cabinClassValue,airline];
        
        NSString *searchquery=[NSString stringWithFormat:@"<AirSearchQuery>\n"
                        "<Master>\n"
                        "<CompanyId>TravelHouseAPI</CompanyId>\n"
                        "<AgentId>1</AgentId>\n"
                        "<BranchId>1</BranchId>\n"
                        "<CoustmerType>DIR</CoustmerType>\n"
                        "</Master>\n"
                        "<JourneyType>%@</JourneyType>\n"
                        "%@"
                        "<PaxDetail>\n"
                        "<NoAdult>%d</NoAdult>\n"
                        "<NoChild>%d</NoChild>\n"
                        "<NoInfant>%d</NoInfant>\n"
                        "</PaxDetail>\n"
                        "<Flexi>0</Flexi>\n"
                        "<Direct>%d</Direct>\n"
                        "<Cabin>\n"
                        "<Class>Y</Class>\n"
                        "</Cabin>\n"
                        "<Airlines>\n"
                        "<Airline>%@</Airline>\n"
                        "</Airlines>\n"
                        "<Authentication>\n"
                        "<HAP>HP_138116058379845</HAP>\n"
                        "<HapPassword>tha@83!</HapPassword>\n"
                        "<HapType>LIVE</HapType>\n"
                        "</Authentication>\n"
                        "</AirSearchQuery>\n",ReturnFlight,segments,noadult,nochild,noinfant,directFlight,airline];
        
        
        [dataStorage sharedCenter].searchQuery=searchquery;
        
        
        NSLog(@"search flights qurey %@ \n %@",desc,searchquery);
        [dataStorage sharedCenter].Description=desc;
        
        // create a url to your asp.net web service.
        NSURL *tmpURl=[NSURL URLWithString:[NSString stringWithFormat:@"http://services.crystaltravel.co.uk/XMLAPI/FLIGHT/FLIGHTSERVICE.ASMX?op=SearchFare"]];
        
        // create a request to your asp.net web service.
       // NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:tmpURl];
        NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:tmpURl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
        
        //Host: services.test.crystaltravel.co.uk
        [theRequest addValue:@"services.crystaltravel.co.uk" forHTTPHeaderField:@"Host"];
        
        
        // add http content type - to your request
        [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        // add  SOAPAction - webMethod that is going to be called
        [theRequest addValue:@"http://tempuri.org/SearchFare" forHTTPHeaderField:@"SOAPAction"];
        
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
    else if (!passengerCheck)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:passengerErrorMsg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill all fields" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        [alert show];
    }
    
    
}

- (IBAction)goback:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)goHome:(id)sender {
    [SVProgressHUD dismiss];

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)done:(id)sender {
    
    [txtflyingfrom resignFirstResponder];
    [txtflyingto resignFirstResponder];
    [txtDdate resignFirstResponder];
    [txtRdate resignFirstResponder];
    [txtNoAdult resignFirstResponder];
    [txtNoInfant resignFirstResponder];
    [txtNoChild resignFirstResponder];
    [txtFlyingClass resignFirstResponder];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        CGPoint p=CGPointMake(0, 250);
        [scroller setContentOffset:p animated:YES];
    }
    
    
}

- (IBAction)setDirectFlight:(id)sender {
    UIButton * temp=(UIButton*)sender;
    
    if(directFlight==0)
    {
        directFlight=1;
        [temp setBackgroundImage:[UIImage imageNamed:@"checked@2x.png"] forState:UIControlStateNormal];
    }
    else
    {
        directFlight=0;
        [temp setBackgroundImage:[UIImage imageNamed:@"unchecked@2x.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)setReturnFlight:(id)sender {
    UIButton * temp=(UIButton*)sender;
    
    if(temp.tag==1)
    {
        ReturnFlight=@"R";
        [temp setBackgroundImage:[UIImage imageNamed:@"checked@2x.png"] forState:UIControlStateNormal];
        [oneRadiobtn setBackgroundImage:[UIImage imageNamed:@"unchecked@2x.png"] forState:UIControlStateNormal];
        [txtRdate setEnabled:YES];
    }
    else if (temp.tag==2)
    {
        ReturnFlight=@"O";
        [temp setBackgroundImage:[UIImage imageNamed:@"checked@2x.png"] forState:UIControlStateNormal];
        [returnRadiobtn setBackgroundImage:[UIImage imageNamed:@"unchecked@2x.png"] forState:UIControlStateNormal];
        [txtRdate setEnabled:false];
        txtRdate.text=@"";
    }
    
    }

- (BOOL)prefersStatusBarHidden {
    return YES;
}


// a method when connection receives response from asp.net web server
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [myWebData setLength: 0];
}
// when web-service sends data to iPhone
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [myWebData appendData:data];
}
// when there is some error with web service
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error1
{


    [SVProgressHUD showSuccessWithStatus:@"Done!"];
    self.view.userInteractionEnabled=YES;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:[error1 localizedDescription] delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
    [alert show];
    NSLog(@"Error");
}
// when connection successfully finishes
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // check out your web-service retrieved data on log screen
    NSString *htmlString = [[NSString alloc] initWithBytes: [myWebData mutableBytes] length:[myWebData length] encoding:NSUTF8StringEncoding];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&amp;"  withString:@"&"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&lt;"  withString:@"<"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&gt;"  withString:@">"];
    //htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</Itinerary>"  withString:@"</Itinerary>"];//<Itinerary>
    //htmlString = [htmlString stringByReplacingOccurrencesOfString:@"""" withString:@"&quot;"];
    //htmlString = [htmlString stringByReplacingOccurrencesOfString:@"'"  withString:@"&#039;"];
    
    if(itenaryArray==Nil || [itenaryArray isKindOfClass:[NSNull class]])
    {
        itenaryArray=[[NSMutableArray alloc]init];
        child=[[NSMutableArray alloc]init];
        infant=[[NSMutableArray alloc]init];
    }
    else
        [itenaryArray removeAllObjects];
    
    NSString *newst=htmlString;
    int itenover=0;
    while (itenover==0) {
        
        NSRange fRange=[newst rangeOfString:@"<Itinerary>"];
        NSRange lRange=[newst rangeOfString:@"</Itinerary>"];
        
        if(fRange.length>0 && lRange.length>0)
        {
            NSRange finalRange=NSMakeRange(fRange.location, lRange.location+lRange.length-fRange.location);
            
            NSLog(@"frange : %@ lrange : %@",[newst substringWithRange:fRange],[newst substringWithRange:lRange]);
            
            NSString *substr=[newst substringWithRange:finalRange];
            [itenaryArray addObject:substr];
            newst=[newst stringByReplacingCharactersInRange:finalRange withString:@""];
        }
        else
            itenover=1;
        
    }
    
   /* NSRange fRange=[newst rangeOfString:@"<Itinerary>"];
    NSRange lRange=[newst rangeOfString:@"</Itinerary>"];
    
    if(fRange.length>0 && lRange.length>0)
    {
    NSRange finalRange=NSMakeRange(fRange.location, lRange.location+lRange.length-fRange.location);
    
    NSLog(@"frange : %@ lrange : %@",[newst substringWithRange:fRange],[newst substringWithRange:lRange]);
    
    NSString *substr=[newst substringWithRange:finalRange];
    
    newst=[newst stringByReplacingCharactersInRange:finalRange withString:@""];
    }*/
    
    obj=[[NSMutableArray alloc]init];
    NSData *d=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    //NSData *d=[NSData alloc]ini
    
    NSXMLParser *p=[[NSXMLParser alloc]initWithData:d];
    [p setDelegate:self];
    [p setShouldResolveExternalEntities:YES];
    //[p setShouldProcessNamespaces:YES];
    [p parse];
    
    [self FlightResult];
    NSLog(@"%@",htmlString);
}

-(void)FlightResult
{
    
    [SVProgressHUD showSuccessWithStatus:@"Done!"];
    self.view.userInteractionEnabled=YES;

    if([obj count]>0)
    {
        [dataStorage sharedCenter].totallAdults=[txtNoAdult.text intValue];
        [dataStorage sharedCenter].totallChilds=[txtNoChild.text intValue];
        [dataStorage sharedCenter].totallInfants=[txtNoInfant.text intValue];
        [dataStorage sharedCenter].totallPessengers=[txtNoAdult.text intValue]+[txtNoChild.text intValue]+[txtNoInfant.text intValue];
        [[dataStorage sharedCenter].itenArray addObjectsFromArray:itenaryArray];
        [dataStorage sharedCenter].child=[[NSMutableArray alloc]initWithArray:child];
        [dataStorage sharedCenter].infant =[[NSMutableArray alloc]initWithArray:infant];

        
        NSLog(@"Total Passengers : %d",[dataStorage sharedCenter].totallPessengers);
        
        NSString *nibname=@"";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            nibname=@"SearchResultViewController_iPhone";
        } else {
            nibname=@"SearchResultViewController_iPad";
        }
        
        SearchResultViewController *op=[[SearchResultViewController alloc]initWithNibName:nibname bundle:nil];
        
        [op setSearchResponse:obj];
        
        [self.navigationController pushViewController:op animated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:error delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        [alert show];
    }
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    check=-1;
    NSString *attr=nil;
    
    NSArray *a=[attributeDict allValues];
    if([a count]==1)
    {
        attr=[a objectAtIndex:0];
    }
    
    if ( [elementName isEqualToString:@"Itinerary"]) {
        // addresses is an NSMutableArray instance variable
        NSLog(@"%d",iter++);
        if(dict==nil || [dict isKindOfClass:[NSNull class]])
            dict=[[NSMutableDictionary alloc]init];
        [dict removeAllObjects];
        
        //if(fl==nil || [fl isKindOfClass:[NSNull class]])
            fl=[[NSMutableArray alloc]init];
        [fl removeAllObjects];
        
    }
    if ( [elementName isEqualToString:@"markUp"])
    {
        check=102;
    }
    
    if ( [elementName isEqualToString:@"NoAdult"])
    {
        check=103;
    }
    if ( [elementName isEqualToString:@"AdTax"])
    {
        check=100;
    }
    if ( [elementName isEqualToString:@"AdtBFare"])
    {
        check=101;
    }
   
    
    if ( [elementName isEqualToString:@"NoChild"])
    {
        check=104;
    }
    if ( [elementName isEqualToString:@"CHTax"])
    {
        check=105;
    }
    if ( [elementName isEqualToString:@"ChdBFare"])
    {
        check=106;
    }
   
    if ( [elementName isEqualToString:@"NoInfant"])
    {
        check=107;
    }
    if ( [elementName isEqualToString:@"InTax"])
    {
        check=108;
    }
    if ( [elementName isEqualToString:@"InfBFare"])
    {
        check=109;
    }
    
    

        if ( [elementName isEqualToString:@"Sector"])
    {
        fldata=nil;
        fldata=[[flightdata alloc]init];
    }
    
    if ( [elementName isEqualToString:@"AirlineLogoPath"])
    {
        check=2;
    }
    
    if ( [elementName isEqualToString:@"FltNum"])
    {
        check=3;
    }
    
    if ( [elementName isEqualToString:@"Departure"])
    {
        check=4;
        da=1;
    }
    
    if ( [elementName isEqualToString:@"Arrival"])
    {
        check=5;
        da=2;
    }
    
    if ( [elementName isEqualToString:@"AirpCode"])
    {
        check=6;
    }
    if ( [elementName isEqualToString:@"Date"])
    {
        check=7;
    }
    if ( [elementName isEqualToString:@"Time"])
    {
        check=8;
    }
    if ( [elementName isEqualToString:@"AirpName"])
    {
        check=9;
    }
    if ( [elementName isEqualToString:@"TransitTime"])
    {
        check=10;
    }
    if ( [elementName isEqualToString:@"isReturn"])
    {
        check=11;
    }
    if ( [elementName isEqualToString:@"Terminal"])
    {
        check=13;
    }
    if ( [elementName isEqualToString:@"EquipType"])
    {
        check=14;
    }
    //SearchFareResponse Error
    if ( [elementName isEqualToString:@"SearchFareResponse"])
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
   
    
    if(check==100)
    {
        adtTax=[string floatValue];
    }
    if(check==101)
    {
        adtbfare=[string floatValue];
        
    }
   
    if(check==103)
    {
        totaladtNumber=[string intValue];
        
    }
    if(check==102)
    {
        adtmarkup=[string floatValue];
        
    }
    
    
    
    if(check==105)
    {
        chTax=[string floatValue];
    }
    if(check==106)
    {
        chbfare=[string floatValue];
    }
    if(check==104)
    {
        totalchNumber=[string intValue];
    }
    
   
    
    if(check==108)
    {
        infTax=[string floatValue];
    }
    if(check==109)
    {
        infbfare=[string floatValue];
    }
    if(check==107)
    {
        totalinfNumber=[string intValue];
    }
    
    
    else if(check==2)
    {
        fldata.AirlineLogoPath=string;
    }
    else if(check==3)
    {
        fldata.FltNum=string;
    }
    else if(check==10)
    {
        string=[string stringByReplacingOccurrencesOfString:@"Connection of " withString:@""];
        fldata.TransitTime=string;
    }
    else if(check==11)
    {
        fldata.isReturn=[string boolValue];
    }
    else if(check==6 && da==1)
    {
        fldata.dAirpCode=string;
    }
    else if(check==7 && da==1)
    {
        fldata.dDate=string;
    }
    else if(check==8 && da==1)
    {
        fldata.dTime=string;
    }
    else if(check==9 && da==1)
    {
        fldata.dAirpName=string;
    }
    else if(check==13 && da==1)
    {
        fldata.dTerminal=string;
    }
    else if(check==6 && da==2)
    {
        fldata.aAirpCode=string;
    }
    else if(check==7 && da==2)
    {
        fldata.aDate=string;
    }
    else if(check==8 && da==2)
    {
        fldata.aTime=string;
    }
    else if(check==9 && da==2)
    {
        fldata.aAirpName=string;
    }
    else if(check==13 && da==2)
    {
        fldata.aTerminal=string;
    }
    else if(check==14)
    {
        fldata.EquipType=string;
    }
    else if(check==12)
    {
        error=string;
    }
    
    //check=-1;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ( [elementName isEqualToString:@"Adult"])
    {
        adttotal=(adtTax+adtbfare+adtmarkup);
        [fl addObject:[NSString stringWithFormat:@"%.02f",adttotal]];
    }
    if ( [elementName isEqualToString:@"Infant"])
    {
        inftotal=(infTax+infbfare+adtmarkup);
        [infant addObject:[NSString stringWithFormat:@"%.02f", inftotal]];
        // [fl addObject:[NSString stringWithFormat:@"%.02f",adttotal]];
    }
    if ( [elementName isEqualToString:@"Child"])
    {
        chtotal=(chTax+chbfare+adtmarkup);
        [child addObject:[NSString stringWithFormat:@"%.02f", chtotal]];

        // [fl addObject:[NSString stringWithFormat:@"%.02f",adttotal]];
    }

    
    if ( [elementName isEqualToString:@"Itinerary"])
    {
        [obj addObject:fl];
    }
    
    if ( [elementName isEqualToString:@"Sector"])
    {
        [fl addObject:fldata];
    }
    
    if ( [elementName isEqualToString:@"Departure"])
    {
        da=0;
    }
    
    if ( [elementName isEqualToString:@"Arrival"])
    {
        da=0;
    }
    
}

@end
