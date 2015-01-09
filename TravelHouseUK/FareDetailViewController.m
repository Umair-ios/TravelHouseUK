//
//  FareDetailViewController.m
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 09/05/2014.
//
//

#import "FareDetailViewController.h"
#import "BookingConditionViewController.h"
#import "PersonalinfoViewController.h"
#import "dataStorage.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomCell.h"

@interface FareDetailViewController ()

@end

@implementation FareDetailViewController{
     UIView *tempview;
}

@synthesize pnrno,paypalid,txtPnrno,txtpaypalid,backbtn,bookingDone,bookingDoneWithError,fromPcvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    if (fromPcvc==NO) {
            }
    
}
-(void)takeImage{
    UIImage* image = nil;
    [termsView removeFromSuperview];
    UIGraphicsBeginImageContextWithOptions(scroller.contentSize,NO,0);
    {
        
        CGPoint savedContentOffset = scroller.contentOffset;
        CGRect savedFrame = scroller.frame;
        
        scroller.contentOffset = CGPointZero;
        scroller.frame = CGRectMake(0, 0, scroller.contentSize.width, scroller.contentSize.height);
        
        [scroller.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scroller.contentOffset = savedContentOffset;
        scroller.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    [scroller addSubview:termsView];
    
    [dataStorage sharedCenter].image=image;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    rights.text=[NSString stringWithFormat:@"All Rights Reserved %@",yearString];

    // Do any additional setup after loading the view from its nib.
    
    [self setData];
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
        [temp setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    }
    else
    {
        termsAccepted=0;
        [temp setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)bookFare:(id)sender {
    
    if(termsAccepted==1)
    {
        
        [self performSelectorInBackground:@selector(takeImage)
                               withObject:nil];

        //[self performSelectorOnMainThread:@selector(pay) withObject:nil waitUntilDone:NO];
        NSString *nibname=@"";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            nibname=@"PersonalinfoViewController_iPhone";
        } else {
            nibname=@"PersonalinfoViewController_iPad";
        }
        
        PersonalinfoViewController *BCVC=[[PersonalinfoViewController alloc]initWithNibName:nibname bundle:nil];
        
        [self.navigationController pushViewController:BCVC animated:YES];
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

-(void)setData
{
    @try{
        NSMutableArray *arr=[dataStorage sharedCenter].dataArray;
       
        int x=0;
        int bookviewx=0;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            myRect.origin.y=5;
            x=5;
            bookviewx=10;
            tempview=[[UIView alloc]initWithFrame:CGRectMake(x, myRect.origin.y, 310, 2)];
        }
        else
        {
            myRect.origin.y=10;
            x=20;
            bookviewx=20;
            tempview=[[UIView alloc]initWithFrame:CGRectMake(x, myRect.origin.y, 728, 2)];
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
        
        if(bookingDone)
        {
            if (bookingDoneWithError) {
                CGRect bookrect=bookingViewError.frame;
                bookrect.origin.y=5;
                bookrect.origin.x=bookviewx;
                [bookingViewError setFrame:bookrect];
                [backbtn setHidden:YES];
                [scroller addSubview:bookingViewError];
                [Generalfunctionclass addColoredlayer:bookingViewError forColor:@"gray"];
                
                CGRect rec=tempview.frame;
                rec.origin.y=bookingview.frame.origin.y+bookingview.frame.size.height+15;
                //rec.size.height+=bookingview.frame.size.height+5;
                [tempview setFrame:rec];
            }
            
            else{
           
            CGRect bookrect=bookingview.frame;
            bookrect.origin.y=5;
            bookrect.origin.x=bookviewx;
            [bookingview setFrame:bookrect];
            [backbtn setHidden:YES];
            [scroller addSubview:bookingview];
            [Generalfunctionclass addColoredlayer:bookingview forColor:@"gray"];
            [txtPnrno setText:pnrno];
            [txtpaypalid setText:paypalid];
            
            CGRect rec=tempview.frame;
            rec.origin.y=bookingview.frame.origin.y+bookingview.frame.size.height+5;
            //rec.size.height+=bookingview.frame.size.height+5;
            [tempview setFrame:rec];
            }
        }

        
        //[tempview setFrame:CGRectMake(5, 5, 310, 0)];
        // NSString *gt=[arr objectAtIndex:0];
        
        NSString *nibName=@"CustomCell_iPhone";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            nibName=@"CustomCell_iPhone";
        }
        else
        {
            nibName=@"CustomCell_iPad";
        }
        CustomCell *sfc=NULL;
        if(bookingDone)
        {
            sfc=[[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:6];
        }
        else
        {
            sfc=[[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:5];
        }
        
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
            
            
            
        }
        
        if(!bookingDone)
        {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                temp=grandTotalView.frame;
                temp.origin.x=10;
                temp.origin.y=rec.size.height+10;
                [grandTotalView setFrame:temp];
            }else{
                temp=grandTotalView.frame;
                temp.origin.x=25;
                temp.origin.y=rec.size.height+10;
                [grandTotalView setFrame:temp];

            }
            
            [scroller addSubview:grandTotalView];
            
            CGRect temp1=termsView.frame;
            temp1.origin.x=20;
            temp1.origin.y=rec.size.height+temp.size.height+20;
            [termsView setFrame:temp1];

            [scroller addSubview:termsView];
            
            rec.size.height+=15;
            rec.size.height+=termsView.frame.size.height+grandTotalView.frame.size.height;
            [tempview setFrame:rec];
        }
        
        [Generalfunctionclass addColoredlayer:tempview forColor:@"gray"];
        //[scroller addSubview:tempview];
        int w;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            w=320;
        } else {
            w=750;
        }
        if(!bookingDone)
            
            [scroller setContentSize:CGSizeMake(w, myRect.size.height+rec.size.height+10)];
        else
            [scroller setContentSize:CGSizeMake(w, myRect.size.height+rec.size.height+bookingview.frame.size.height+20)];
        
        myRect.size.height+=rec.size.height;
        myRect.origin.y=myRect.size.height+10;
        myRect.size.height+=10;
        
        //[fareview setFrame:CGRectMake(0, 58, fareview.frame.size.width, fareview.frame.size.height)];
        //[self.view addSubview:fareview];
        adultFareLabel.text=[NSString stringWithFormat:@"£%@  x%d",[dataStorage sharedCenter].totallAdultFare,[dataStorage sharedCenter].totallAdults];
        childFareLabel.text=[NSString stringWithFormat:@"£%@  x%d",[dataStorage sharedCenter].totallChildFare,[dataStorage sharedCenter].totallChilds];
        InfantFareLabel.text=[NSString stringWithFormat:@"£%@  x%d",[dataStorage sharedCenter].totallInfantFare,[dataStorage sharedCenter].totallInfants];
        infantTotalLabel.text=[NSString stringWithFormat:@"£%.02f",[dataStorage sharedCenter].totallInfants*[[dataStorage sharedCenter].totallInfantFare floatValue]];
        adultTotalLabel.text=[NSString stringWithFormat:@"£%.02f",[dataStorage sharedCenter].totallAdults*[[dataStorage sharedCenter].totallAdultFare floatValue]];
        childTotalLabel.text=[NSString stringWithFormat:@"£%.02f",[dataStorage sharedCenter].totallChilds*[[dataStorage sharedCenter].totallChildFare floatValue]];
        airlineFailuireFee.text=[NSString stringWithFormat:@"£1.50   x%d",[dataStorage sharedCenter].totallPessengers-[dataStorage sharedCenter].totallInfants ];
        totalAirlineFailureFee.text=[NSString stringWithFormat:@"£%.02f",1.50*([dataStorage sharedCenter].totallPessengers-[dataStorage sharedCenter].totallInfants) ];
        totalProtection.text=[NSString stringWithFormat:@"£2.50   x%d",[dataStorage sharedCenter].totallPessengers-[dataStorage sharedCenter].totallInfants ];
        totalProtectionTotalfee.text=[NSString stringWithFormat:@"£%.02f",2.50*([dataStorage sharedCenter].totallPessengers-[dataStorage sharedCenter].totallInfants) ];
        grandeTotal.text=[NSString stringWithFormat:@"£%.02f",[dataStorage sharedCenter].totallInfants*[[dataStorage sharedCenter].totallInfantFare floatValue]+[dataStorage sharedCenter].totallAdults*[[dataStorage sharedCenter].totallAdultFare floatValue]+[dataStorage sharedCenter].totallChilds*[[dataStorage sharedCenter].totallChildFare floatValue]+1.50*([dataStorage sharedCenter].totallPessengers-[dataStorage sharedCenter].totallInfants)+2.50*([dataStorage sharedCenter].totallPessengers-[dataStorage sharedCenter].totallInfants)];
        [dataStorage sharedCenter].TotalAmount=[NSString stringWithFormat:@"%.02f",[dataStorage sharedCenter].totallInfants*[[dataStorage sharedCenter].totallInfantFare floatValue]+[dataStorage sharedCenter].totallAdults*[[dataStorage sharedCenter].totallAdultFare floatValue]+[dataStorage sharedCenter].totallChilds*[[dataStorage sharedCenter].totallChildFare floatValue]+1.50*([dataStorage sharedCenter].totallPessengers-[dataStorage sharedCenter].totallInfants)+2.50*([dataStorage sharedCenter].totallPessengers-[dataStorage sharedCenter].totallInfants)];
        if ([dataStorage sharedCenter].totallChildFare==NULL) {
            childFareLabel.hidden=childLabel.hidden=childTotalLabel.hidden=YES;
        }
        if ([dataStorage sharedCenter].totallInfantFare==NULL) {
            InfantFareLabel.hidden=infantLabel.hidden=infantTotalLabel.hidden=YES;
        }

    }
    @catch (NSException *ex) {
        NSLog(@"%@",[ex description]);
    }
    
}

- (IBAction)goHome:(id)sender {
    [SVProgressHUD dismiss];

    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

- (IBAction)subscribe:(id)sender {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Subscribe" message:@"To Subscribe to our newsletter Please enter your email." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Subscribe",nil, nil];
    alert.tag=1144;
    alert.alertViewStyle=UIAlertViewStyleLoginAndPasswordInput;
    [[alert textFieldAtIndex:0] setPlaceholder:@"Enter Your Name"];
    [[alert textFieldAtIndex:1] setPlaceholder:@"Enter Your Email"];
    [alert textFieldAtIndex:1].secureTextEntry=false;
    [alert show];
    
}

#pragma mark

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
