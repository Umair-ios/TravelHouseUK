//
//  CustomCell.m
//  American Taxi
//
//  Created by AR on 7/18/13.
//  Copyright (c) 2013 Babar Shabbir. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell
@synthesize gtotal,dairpcode,dairpname,ddate,dtime,aairpcode,aairpname,adate,airlogo,atime,fltnum,Delegate,index,url;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //[Generalfunctionclass addColoredlayer:cancelbtn forColor:@"g"];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)getpostimage
{
    
    if(url.length>0 && url!=nil)
    {
        NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:url];
        if(data!=NULL)
        {
            UIImage *postimage=[[UIImage alloc]initWithData:data];
            [airlogo setImage:postimage];
        }
        else
        {
            NSURL *uri=[[NSURL alloc]initWithString:url];
            NSData *imgdata=[[NSData alloc]initWithContentsOfURL:uri];
            UIImage *postimage=[[UIImage alloc]initWithData:imgdata];
            [airlogo setImage:postimage];
            [[NSUserDefaults standardUserDefaults] setObject:imgdata forKey:url];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        //[delegate performSelector:@selector(reloaddata)];
    }
    
    
    
}


- (IBAction)requestit:(id)sender
{
    UIButton *t=(UIButton*)sender;
    [t setTag:index];
    [Delegate performSelector:@selector(requestit:) withObject:sender];
}

- (IBAction)directCall:(id)sender {
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:02031373050"]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Soryy" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
        
    }
}



@end
