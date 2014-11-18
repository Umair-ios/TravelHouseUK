//
//  LoaderAlertView.h
//  Grindr
//
//  Created by Mazhar Iqbal on 22/12/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoaderAlertView : UIAlertView {
	UIActivityIndicatorView *activityView;
    BOOL CancelTitleSet;
}

@property (nonatomic, retain) UIActivityIndicatorView *activityView;

- (id)initWithCustomTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;

@end
