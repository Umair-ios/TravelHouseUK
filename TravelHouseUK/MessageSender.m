//
//  MessageSender.m
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 10/06/2014.
//
//

#import "MessageSender.h"
#import "SBJson.h"
#import "XMLReader.h"

#define SecurityKey  @"2014TRV1PH3M@ILs3RV3r"
#define baseurl @"http://m.travelhouseuk.co.uk/iphoneemail.php"

@implementation MessageSender
static MessageSender *sharedAwardCenter = nil;    // static instance variable

+ (MessageSender *)sharedCenter {
    if (sharedAwardCenter == nil) {
        sharedAwardCenter = [[MessageSender alloc] init];
        
    }
    return sharedAwardCenter;
}

-(id)init
{
    self=[super init];
    if(self)
    {
        }
    
    return self;
}

#pragma mark - contactService Method
-(void)contactService:(NSArray*)params
{
    //dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
	//dispatch_async(concurrentQueue, ^{
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    NSError *error=nil;
    NSString *txtType=@"contact";
    /*NSString *strWithURL = [NSString stringWithFormat:@"%@txtSecure=%@&txtType=%@&txtName=%@&txtTelephone=%@&txtEmail=%@&txtDepartment=%@&txtMessage=%@",baseurl,SecurityKey,txtType,[params objectAtIndex:0],[params objectAtIndex:1],[params objectAtIndex:2],[params objectAtIndex:3],[params objectAtIndex:4]];*/
    
    NSString *strWithURL = [NSString stringWithFormat:@"%@",baseurl];
    
    NSString *data = [NSString stringWithFormat:@"txtSecure=%@&txtType=%@&txtName=%@&txtTelephone=%@&txtEmail=%@&txtDepartment=%@&txtMessage=%@",SecurityKey,txtType,[params objectAtIndex:0],[params objectAtIndex:1],[params objectAtIndex:2],[params objectAtIndex:3],[params objectAtIndex:4]];
    
    //strWithURL = [strWithURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"strConfirmChallenge=%@",strWithURL);
    
    //NSURL *myURL = [NSURL URLWithString:strWithURL];
    
    //NSString *response=[NSString stringWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:&error];
    
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[strWithURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //NSString *bodydata=[NSString stringWithFormat:@"data=%@",jsonString];
    
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[data UTF8String] length:[data length]];
    [request setHTTPBody:req];
    NSURLResponse* response;
    //NSError* error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    [SVProgressHUD showSuccessWithStatus:@"Done!"];
    if(!error)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Contact Us" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        //return response;
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Contact Us" message:@"Some Error occured. Please try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint AndDictionary:(NSDictionary *)dic{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
#pragma mark - bookingService Method
-(void)bookingService:(NSArray*)params
{

    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:[params objectAtIndex:1] error:&parseError];
    NSLog(@" %@", xmlDictionary);
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:xmlDictionary
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    
    /*
    NSError *error = nil;
    NSDictionary *dict = [XMLReader dictionaryForXMLString:[params objectAtIndex:1] error:&error];

    NSString *jsonString = [self bv_jsonStringWithPrettyPrint:YES AndDictionary:dict];
    */
     
    NSString *txtType=@"booking";
    
    NSString *strWithURL = [NSString stringWithFormat:@"%@",baseurl];
    
    NSString *data = [NSString stringWithFormat:@"txtSecure=%@&txtType=%@&txtPay=non&txtMail=%@",SecurityKey,txtType,jsonString];
    
    //strWithURL = [strWithURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"strConfirmChallenge=%@",strWithURL);
    
    //NSURL *myURL = [NSURL URLWithString:strWithURL];
    
    //NSString *response=[NSString stringWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:&error];
    
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[strWithURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //NSString *bodydata=[NSString stringWithFormat:@"data=%@",jsonString];
    
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[data UTF8String] length:[data length]];
    [request setHTTPBody:req];
    NSURLResponse* response;
    //NSError* error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
  //  NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSString *myString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"bookingService responseString=%@",myString);
    
}

#pragma mark - subscribeService Method
-(void )subscribeService:(NSArray*)params
{
    //dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
	//dispatch_async(concurrentQueue, ^{
    
    NSString *name=[params objectAtIndex:0];
    NSString *mail=[params objectAtIndex:1];
    
    if(name.length<1 || mail.length<1)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Subcsribe" message:@"Please fill all fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (![self IsValidEmail:mail])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Subcsribe" message:@"Please enter valid email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [SVProgressHUD showWithStatus:@"Loading..."];
        NSError *error=nil;
        NSString *txtType=@"subscribe";
        /*NSString *strWithURL = [NSString stringWithFormat:@"%@txtSecure=%@&txtType=%@&txtName=%@&txtEmail=%@",baseurl,SecurityKey,txtType,[params objectAtIndex:0],[params objectAtIndex:1]];*/
        
        NSString *strWithURL = [NSString stringWithFormat:@"%@",baseurl];
        
        NSString *data = [NSString stringWithFormat:@"txtSecure=%@&txtType=%@&txtName=%@&txtEmail=%@",SecurityKey,txtType,[params objectAtIndex:0],[params objectAtIndex:1]];
        
        //strWithURL = [strWithURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"strConfirmChallenge=%@",strWithURL);
        
       // NSURL *myURL = [NSURL URLWithString:strWithURL];
        
        //NSString *response=[NSString stringWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:&error];
        
        NSData* responseData = nil;
        NSURL *url=[NSURL URLWithString:[strWithURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        responseData = [NSMutableData data] ;
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        //NSString *bodydata=[NSString stringWithFormat:@"data=%@",jsonString];
        
        [request setHTTPMethod:@"POST"];
        NSData *req=[NSData dataWithBytes:[data UTF8String] length:[data length]];
        [request setHTTPBody:req];
        NSURLResponse* response;
        //NSError* error = nil;
        responseData = [NSURLConnection sendSynchronousRequest:request     returningResponse:&response error:&error];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSLog(@"the final output is:%@",responseString);
        
        [SVProgressHUD showSuccessWithStatus:@"Done!"];
        if(!error)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Subcsribe" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            //return response;
            
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Subcsribe" message:@"Some Error occured. Please try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    //return @"error";
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

@end
