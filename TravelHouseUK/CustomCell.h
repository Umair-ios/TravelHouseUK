//
//  CustomCell.h
//  American Taxi
//
//  Created by AR on 7/18/13.
//  Copyright (c) 2013 Babar Shabbir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface CustomCell : UITableViewCell<UIAlertViewDelegate>
{
    
}

@property (nonatomic) int index;

@property (nonatomic, strong) id Delegate;
@property (nonatomic, strong) NSString *url;

@property (weak, nonatomic) IBOutlet UILabel *gtotal;
@property (weak, nonatomic) IBOutlet UILabel *dtime;
@property (weak, nonatomic) IBOutlet UILabel *ddate;
@property (weak, nonatomic) IBOutlet UILabel *dairpname;
@property (weak, nonatomic) IBOutlet UILabel *dairpcode;
@property (weak, nonatomic) IBOutlet UILabel *dterminal;
@property (weak, nonatomic) IBOutlet UILabel *aterminal;
@property (weak, nonatomic) IBOutlet UILabel *atime;
@property (weak, nonatomic) IBOutlet UILabel *adate;
@property (weak, nonatomic) IBOutlet UILabel *aairpname;
@property (weak, nonatomic) IBOutlet UILabel *aairpcode;
@property (weak, nonatomic) IBOutlet UILabel *fltnum;
@property (weak, nonatomic) IBOutlet UILabel *equiptype;
@property (weak, nonatomic) IBOutlet UIImageView *airlogo;
- (IBAction)requestit:(id)sender;
- (IBAction)directCall:(id)sender;


@end
