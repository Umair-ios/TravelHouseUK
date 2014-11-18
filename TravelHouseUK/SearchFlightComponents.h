//
//  SearchFlightComponents.h
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 21/01/2014.
//
//

#import <UIKit/UIKit.h>

@interface SearchFlightComponents : UIView
{
    IBOutlet UIView *topview;
    
    IBOutlet UIView *flightdataview;
    
    IBOutlet UIView *inboundview;
    
    IBOutlet UILabel *transienttime;
}

@property (nonatomic,retain) id delegate;
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


@end
