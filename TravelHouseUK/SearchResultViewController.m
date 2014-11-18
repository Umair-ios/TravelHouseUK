//
//  SearchResultViewController.m
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 31/12/2013.
//
//

#import "SearchResultViewController.h"
#import "BookingStep1ViewController.h"
#import "SearchFlightComponents.h"
#import "CustomCell.h"
#import "PersonalinfoViewController.h"
#import "dataStorage.h"
#import "FareDetailViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController
@synthesize gtotal,dairpcode,dairpname,ddate,dtime,aairpcode,aairpname,adate,airlogo,atime,fltnum;
@synthesize pageno,totalpages;

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

    [scroller setContentSize:CGSizeMake(320, 1000)];
    
    page=0;
    //pageno.text=[NSString stringWithFormat:@"%d",page+1];
    totalpages.text=[NSString stringWithFormat:@"%lu",(unsigned long)[searchResponse count]];
    //[scroller addSubview:firstview];
    //[scroller addSubview:secondview];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        myRect=CGRectMake(0, 0, 320, 0);
    }
    else
    {
        myRect=CGRectMake(0, 0, 728, 0);
    }
    for(int i=0;i<[searchResponse count];i++)
        [self setData:[searchResponse objectAtIndex:i] andindex:i];
    
    
}

-(void)setData:(NSMutableArray *)arr andindex:(int)index
{
    @try{
    
        UIView *tempview;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            tempview=[[UIView alloc]initWithFrame:CGRectMake(5, myRect.origin.y, 310, 2)];
        }
        else
        {
            tempview=[[UIView alloc]initWithFrame:CGRectMake(20, myRect.origin.y, 728, 2)];
        }
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
        NSString *gt=[arr objectAtIndex:0];
        
        NSString *nibName=@"CustomCell_iPhone";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            nibName=@"CustomCell_iPhone";
        }
        else
        {
            nibName=@"CustomCell_iPad";
        }
        CustomCell *sfc=[[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:1];
        sfc.index=index;
        
        NSArray *subviews=[sfc subviews];
        for(int i=0;i<[subviews count];i++)
        {
            NSObject *obj=[subviews objectAtIndex:i];
            if([obj isKindOfClass:[UIButton class]])
            {
                UIButton *temp=(UIButton*)obj;
                temp.tag=index;
            }
        }
        
        sfc.Delegate=self;
        sfc.gtotal.text=[NSString stringWithFormat:@"£%@",gt];
        
        [tempview addSubview:sfc];
        
        CGRect rec=tempview.frame;
        rec.size.height+=sfc.frame.size.height-5;
        [tempview setFrame:rec];
        
        CGRect temp;
        
        BOOL isinbound=false;
        for(int i=1;i<[arr count];i++)
        {
            flightdata *fldata=[arr objectAtIndex:i];
            
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
            
            sfc=[[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:3];
            
            sfc.dtime.text=fldata.dTime;
            sfc.ddate.text=fldata.dDate;
            sfc.dairpname.text=fldata.dAirpName;
            sfc.dairpcode.text=fldata.dAirpCode;
            sfc.atime.text=fldata.aTime;
            sfc.adate.text=fldata.aDate;
            sfc.aairpname.text=fldata.aAirpName;
            sfc.aairpcode.text=fldata.aAirpCode;
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
            
            
            
        }
        
        
        temp=pageview.frame;
        temp.origin.x=20;
        temp.origin.y=rec.size.height+10;
        [pageview setFrame:temp];
        //[scroller addSubview:pageview];
        
        rec.size.height+=5;
        [tempview setFrame:rec];
        
        [Generalfunctionclass addColoredlayer:tempview forColor:@"gray"];
        //[scroller addSubview:tempview];
        [scroller setContentSize:CGSizeMake(320, myRect.size.height+rec.size.height+10)];
        
        myRect.size.height+=rec.size.height;
        myRect.origin.y=myRect.size.height+10;
        myRect.size.height+=10;
    }
    @catch (NSException *ex) {
        NSLog(@"%@",[ex description]);
    }
    /*UIView *v=[[UIView alloc]initWithFrame:CGRectMake(5, 5, 310, 0)];
    NSString *gt=[arr objectAtIndex:0];
    
    NSString *nibName=@"CustomCell_iPhone";
    CustomCell *sfc=[[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:1];
    
    sfc.gtotal.text=gt;
    gtotal.text=gt;
    
    id copyOfView =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:topview]];
    UIView *myView = (UIView *)copyOfView;
    
    NSArray *ar= myView.subviews;
    for(int i=0;i<[ar count];i++)
    {
        NSObject *btview=[ar objectAtIndex:i];
        if([btview isKindOfClass:[UIButton class]])
        {
            UIButton *myb=(UIButton*)btview;
            [[myb titleLabel] setFont:[UIFont systemFontOfSize:10]];
        }
    }
    
    [v addSubview:sfc];
    
    CGRect rec=v.frame;
    rec.size.height+=topview.frame.size.height;
    [v setFrame:rec];
    
    CGRect temp;
    
    BOOL isinbound=false;
    for(int i=1;i<[arr count];i++)
    {
        flightdata *fldata=[arr objectAtIndex:i];
        if(fldata.isReturn==true && isinbound==false)
        {
            isinbound=true;
            id copyOfView =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:inboundview]];
            myView = (UIView *)copyOfView;
            temp=myView.frame;
            temp.origin.y=rec.size.height;
            [myView setFrame:temp];
            
            [v addSubview:myView];
            rec.size.height+=inboundview.frame.size.height;
            [v setFrame:rec];
        }
        
        dtime.text=fldata.dTime;
        ddate.text=fldata.dDate;
        dairpname.text=fldata.dAirpName;
        dairpcode.text=fldata.dAirpCode;
        atime.text=fldata.aTime;
        adate.text=fldata.aDate;
        aairpname.text=fldata.aAirpName;
        aairpcode.text=fldata.aAirpCode;
        fltnum.text=fldata.FltNum;
        
        id copyOfView =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:flightdataview]];
        myView = (UIView *)copyOfView;
        temp=myView.frame;
        temp.origin.y=rec.size.height;
        [myView setFrame:temp];
        [v addSubview:myView];
        rec.size.height+=flightdataview.frame.size.height;
        [v setFrame:rec];
        
        if(fldata.TransitTime!=nil && fldata.TransitTime.length>5)
        {
            transienttime.text=fldata.TransitTime;
            
            id copyOfView =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:transienttime]];
            myView = (UIView *)copyOfView;
            temp=myView.frame;
            temp.origin.x=5;
            temp.origin.y=rec.size.height;
            [myView setFrame:temp];
            [v addSubview:myView];
            rec.size.height+=transienttime.frame.size.height;
            [v setFrame:rec];
        }
        
    }
    
    [Generalfunctionclass addColoredlayer:v forColor:@"gray"];
    [scroller addSubview:v];
    [scroller setContentSize:CGSizeMake(320, rec.size.height+10)];
    */
}

-(void)ResquestIT
{
   // BookingStep1ViewController *BSVC=[[BookingStep1ViewController alloc]initWithNibName:@"BookingStep1ViewController" bundle:nil];
    
    //[self.navigationController pushViewController:BSVC animated:YES];
    
    PersonalinfoViewController *BSVC=[[PersonalinfoViewController alloc]initWithNibName:@"PersonalinfoViewController" bundle:nil];
    
    [self.navigationController pushViewController:BSVC animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestit:(id)sender {
    
    //BookingStep1ViewController *BSVC=[[BookingStep1ViewController alloc]initWithNibName:@"BookingStep1ViewController" bundle:nil];
    
    //[self.navigationController pushViewController:BSVC animated:YES];
    
    UIButton *temp=(UIButton*)sender;
    
    NSString *re=[[dataStorage sharedCenter].itenArray objectAtIndex:temp.tag];
    [dataStorage sharedCenter].totallAdultFare=[[searchResponse objectAtIndex:temp.tag] objectAtIndex:0];
    NSLog(@"Total childs fares: %lu",(unsigned long)[dataStorage sharedCenter].child.count);
    NSLog(@"Total infants fares: %lu",(unsigned long)[dataStorage sharedCenter].infant.count);
    if ([dataStorage sharedCenter].infant.count>0) {
   
        [dataStorage sharedCenter].totallInfantFare=[[dataStorage sharedCenter].infant objectAtIndex:temp.tag];
 
    }else {
        [dataStorage sharedCenter].totallInfantFare=0;
    }
    if ([dataStorage sharedCenter].child.count>0) {
        
        [dataStorage sharedCenter].totallChildFare=[[dataStorage sharedCenter].child objectAtIndex:temp.tag];
        
    }else {
        [dataStorage sharedCenter].totallChildFare=0;
    }

    NSString *amount=[[searchResponse objectAtIndex:temp.tag] objectAtIndex:0];
    [dataStorage sharedCenter].dataArray=[searchResponse objectAtIndex:temp.tag];
    [dataStorage sharedCenter].requestItenary=re;
    [dataStorage sharedCenter].Amount=amount;
    
   
    NSLog(@"Total adults fare: %@",[dataStorage sharedCenter].totallAdultFare);

    
    /*NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"PersonalinfoViewController_iPhone";
    } else {
        nibname=@"PersonalinfoViewController_iPad";
    }
    
    PersonalinfoViewController *BSVC=[[PersonalinfoViewController alloc]initWithNibName:nibname bundle:nil];*/
    
    NSString *nibname=@"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibname=@"FareDetailViewController_iPhone";
    } else {
        nibname=@"FareDetailViewController_iPad";
    }
    
    FareDetailViewController *BSVC=[[FareDetailViewController alloc]initWithNibName:nibname bundle:nil];
    BSVC.bookingDone=false;
    
    [self.navigationController pushViewController:BSVC animated:YES];
    
}

-(void)setSearchResponse:(NSMutableArray *)sr
{
    searchResponse=[[NSMutableArray alloc]initWithArray:sr];
}

- (IBAction)goback:(id)sender {
    [SVProgressHUD dismiss];

    UIButton * btn=(UIButton*)sender;
    
    NSLog(@"btn tag : %lD",(long)btn.tag);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextpage:(id)sender
{
    /*
    page+=1;
    if(page<[searchResponse count])
    {
        pageno.text=[NSString stringWithFormat:@"%d",page+1];
        [self setData:[searchResponse objectAtIndex:page]];
        
        [firstview setHidden:false];
        [secondview setHidden:false];
        
        if(page%2==0)
            [firstview setFrame:CGRectMake(325, 5, firstview.frame.size.width, firstview.frame.size.height)];
        else
            [secondview setFrame:CGRectMake(325, 5, firstview.frame.size.width, firstview.frame.size.height)];
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationCurveEaseIn
                         animations:^{
                             
                             if(page%2==0)
                             {
                                 [firstview setFrame:CGRectMake(5, 5, firstview.frame.size.width, firstview.frame.size.height)];
                                 [secondview setFrame:CGRectMake(-325, 5, firstview.frame.size.width, firstview.frame.size.height)];
                             }
                             else
                             {
                                 [secondview setFrame:CGRectMake(5, 5, firstview.frame.size.width, firstview.frame.size.height)];
                                 [firstview setFrame:CGRectMake(-325, 5, firstview.frame.size.width, firstview.frame.size.height)];
                             }
                             
                             
                             
                         }
                         completion:^(BOOL finished) {
                             
                             if(page%2==0)
                             {
                                 [secondview setHidden:YES];
                             }
                             else
                             {
                                 [firstview setHidden:YES];
                             }
                             
                         }];
        
    }
    else
        page-=1;*/
}

- (IBAction)prevpage:(id)sender
{
    /*page-=1;
    if(page>=0)
    {
        pageno.text=[NSString stringWithFormat:@"%d",page+1];
        [self setData:[searchResponse objectAtIndex:page]];
        
        [firstview setHidden:false];
        [secondview setHidden:false];
        
        if(page%2==0)
            [firstview setFrame:CGRectMake(-325, 5, firstview.frame.size.width, firstview.frame.size.height)];
        else
            [secondview setFrame:CGRectMake(-325, 5, firstview.frame.size.width, firstview.frame.size.height)];
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             if(page%2==0)
                             {
                                 [firstview setFrame:CGRectMake(5, 5, firstview.frame.size.width, firstview.frame.size.height)];
                                 [secondview setFrame:CGRectMake(325, 5, firstview.frame.size.width, firstview.frame.size.height)];
                             }
                             else
                             {
                                 [secondview setFrame:CGRectMake(5, 5, firstview.frame.size.width, firstview.frame.size.height)];
                                 [firstview setFrame:CGRectMake(325, 5, firstview.frame.size.width, firstview.frame.size.height)];
                             }
                             
                             
                             
                         }
                         completion:^(BOOL finished) {
                             
                             if(page%2==0)
                             {
                                 [secondview setHidden:YES];
                             }
                             else
                             {
                                 [firstview setHidden:YES];
                             }
                             
                         }];
        
    }
    else
        page+=1;*/
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
