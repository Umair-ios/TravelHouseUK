//
//  flightdata.h
//  HappyTaxi
//
//  Created by Muhammad Saad Zia on 12/01/2014.
//
//

#import <Foundation/Foundation.h>

@interface flightdata : NSObject
{
    
}


@property(nonatomic,retain) NSString * FltNum;
@property(nonatomic,retain) NSString * EquipType;
@property(nonatomic,retain) NSString * AirlineLogoPath;
@property(nonatomic,retain) NSString * dDate;
@property(nonatomic,retain) NSString * dTime;
@property(nonatomic,retain) NSString * dAirpName;
@property(nonatomic,retain) NSString * dAirpCode;
@property(nonatomic,retain) NSString * dTerminal;
@property(nonatomic,retain) NSString * aDate;
@property(nonatomic,retain) NSString * aTime;
@property(nonatomic,retain) NSString * aAirpName;
@property(nonatomic,retain) NSString * aAirpCode;
@property(nonatomic,retain) NSString * aTerminal;
@property(nonatomic,retain) NSString * TransitTime;
@property(nonatomic,readwrite) BOOL isReturn;

@end
