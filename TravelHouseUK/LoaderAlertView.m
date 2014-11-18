//
//  LoaderAlertView.h
//  Grindr
//
//  Created by Mazhar Iqbal on 22/12/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "LoaderAlertView.h"


@implementation LoaderAlertView

@synthesize activityView;


- (id)initWithCustomTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles {
	
    if (self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil])
    {
	
        
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(139.0f-18.0f,self.frame.size.height, 37.0f, 37.0f);
        [self addSubview:activityView];
        [activityView startAnimating];
        
        
        NSLog(@"Cancel title set %@",cancelButtonTitle);
        
        if([cancelButtonTitle isEqualToString:@""] || cancelButtonTitle == nil)
        {
            CancelTitleSet = NO;
        }
        else
        {
            CancelTitleSet = YES;
        }
        
	}
    
	return self;
}

- (void)layoutSubviews {
	for (UIView *view in self.subviews) {
		if ([[[view class] description] isEqualToString:@"UIActivityIndicatorView"]) {
            
            if(!CancelTitleSet)
			view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - 20, 37.0f, 37.0f);
            else
                view.frame = CGRectMake(view.frame.origin.x, 27, 37.0f, 37.0f);
		}
	}
}
/*
-(void)dismissAlert
{
	[self dismissWithClickedButtonIndex:0 animated:TRUE];
	[self release];
}*/

-(void)dealloc
{
    
    [activityView release];
	[super dealloc];
	

}





//_sharedIAPManager = [[InAppPurchaseManager alloc] init];
//_sharedIAPManager.allProducts = [NSArray arrayWithObjects:
//                                 kInAppProductId_TestProduct,
//                                 kInAppProductId_Level1,
//                                 kInAppProductId_Level2,
//                                 kInAppProductId_Level3,
//                                 kInAppProductId_Level4,
//                                 kInAppProductId_Level5,
//                                 kInAppProductId_Level8,
//                                 kInAppProductId_Level9,
//                                 kInAppProductId_Level10,
//                                 kInAppProductId_UnLockAllLevels,
//                                 kInAppProductId_RemoveAdds,
//                                 nil];


@end
