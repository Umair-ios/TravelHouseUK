//
//  Generalfunctionclass.m
//  American Taxi
//
//  Created by Muhammad Saad Zia on 9/30/13.
//  Copyright (c) 2013 Babar Shabbir. All rights reserved.
//

#import "Generalfunctionclass.h"


@implementation Generalfunctionclass


+(void)addColoredlayer:(UIView *)v forColor:(NSString *)color
{
        UIColor *col=nil;
    color=[color lowercaseString];
    if([color isEqualToString:@"red"])
    {
        
        col=[UIColor colorWithRed:153.0f/255.0f green:47.0f/255.0f blue:47.0f/255.0f alpha:1];
    }
    
    else if([color isEqualToString:@"green"])
    {
        
        col=[UIColor colorWithRed:83.0f/255.0f green:147.0f/255.0f blue:63.0f/255.0f alpha:1];
    }
    
    else if([color isEqualToString:@"yellow"])
    {
        
        col=[UIColor colorWithRed:187.0f/255.0f green:96.0f/255.0f blue:8.0f/255.0f alpha:1];
    }
    else if([color isEqualToString:@"purple"])
    {
        
        col=[UIColor colorWithRed:106.0f/255.0f green:58.0f/255.0f blue:178.0f/255.0f alpha:200.0f/255.0f];
    }
    else if([color isEqualToString:@"gray"])
    {
        
        col=[UIColor colorWithRed:88.0f/255.0f green:91.0f/255.0f blue:92.0f/255.0f alpha:200.0f/255.0f];
    }
    else if([color isEqualToString:@"brown"])
    {
        
        col=[UIColor colorWithRed:48.0f/255.0f green:31.0f/255.0f blue:13.0f/255.0f alpha:200.0f/255.0f];
    }
    else if([color isEqualToString:@"blue"])
    {
        
        col=[UIColor colorWithRed:47.0f/255.0f green:102.0f/255.0f blue:153.0f/255.0f alpha:128.0f/255.0f];
    }
    else if([color isEqualToString:@"black"])
    {
        
        col=[UIColor colorWithRed:23.0f/255.0f green:23.0f/255.0f blue:23.0f/255.0f alpha:255.0f/255.0f];
    }
    else
    {
        
        col=[UIColor colorWithRed:153.0f/255.0f green:47.0f/255.0f blue:47.0f/255.0f alpha:1];
    }
    
    
    v.clipsToBounds=YES; // Important!
    
    v.layer.borderWidth=1;
    v.layer.borderColor=col.CGColor;
    v.layer.cornerRadius=0;
}

@end
