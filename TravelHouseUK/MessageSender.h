//
//  MessageSender.h
//  TravelHouseUK
//
//  Created by Muhammad Saad Zia on 10/06/2014.
//
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface MessageSender : NSObject


+ (MessageSender *)sharedCenter;

-(void)contactService:(NSArray*)params;
-(void)bookingService:(NSArray*)params;
-(void)subscribeService:(NSArray*)params;
@end
