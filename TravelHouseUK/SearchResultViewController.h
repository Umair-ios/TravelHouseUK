//
//  SearchResultViewController.h
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 31/12/2013.
//
//

#import <UIKit/UIKit.h>
#import "flightdata.h"

@interface SearchResultViewController : UIViewController
{
    IBOutlet UILabel *rights;
       NSMutableArray *searchResponse;
    int page;
    
    __weak IBOutlet UIScrollView *scroller
    ;
    IBOutlet UIView *grandTotalView;
    IBOutlet UIView *topview;
    
    IBOutlet UIView *flightdataview;
    
    IBOutlet UIView *inboundview;
    
    IBOutlet UIView *transientview;
    IBOutlet UILabel *transienttime;
    IBOutlet UIView *firstview;
    IBOutlet UIView *secondview;
    IBOutlet UIView *pageview;
    CGRect myRect;
}

@property (weak, nonatomic) IBOutlet UILabel *pageno;
@property (weak, nonatomic) IBOutlet UILabel *totalpages;


@property (weak, nonatomic) IBOutlet UILabel *gtotal;
@property (weak, nonatomic) IBOutlet UILabel *dtime;
@property (weak, nonatomic) IBOutlet UILabel *ddate;
@property (weak, nonatomic) IBOutlet UILabel *dairpname;
@property (weak, nonatomic) IBOutlet UILabel *dairpcode;
@property (weak, nonatomic) IBOutlet UILabel *atime;
@property (weak, nonatomic) IBOutlet UILabel *adate;
@property (weak, nonatomic) IBOutlet UILabel *aairpname;
@property (weak, nonatomic) IBOutlet UILabel *aairpcode;
@property (weak, nonatomic) IBOutlet UILabel *fltnum;
@property (weak, nonatomic) IBOutlet UIImageView *airlogo;
- (IBAction)requestit:(id)sender;

- (IBAction)goHome:(id)sender;
-(void)setSearchResponse:(NSMutableArray *)sr;
- (IBAction)goback:(id)sender;
- (IBAction)subscribe:(id)sender;
- (IBAction)nextpage:(id)sender;
- (IBAction)prevpage:(id)sender;
@end
