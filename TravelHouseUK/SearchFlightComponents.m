//
//  SearchFlightComponents.m
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 21/01/2014.
//
//

#import "SearchFlightComponents.h"

@implementation SearchFlightComponents
@synthesize gtotal,dairpcode,dairpname,ddate,dtime,aairpcode,aairpname,adate,airlogo,atime,fltnum,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)requestit:(id)sender
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
