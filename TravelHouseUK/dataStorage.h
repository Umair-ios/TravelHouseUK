//
//  dataStorage.h
//  TravelHouseUK
//
//  Created by AR on 29/01/2014.
//
//

#import <Foundation/Foundation.h>

@interface dataStorage : NSObject
{
    NSMutableArray *pessengersArray;
    NSMutableArray *personalArray;
    NSMutableArray * itenArray,*dataArray,*child,*infant;
    NSString *searchQuery;
    NSString *requestItenary;
    NSString *Description;
}
@property (strong,nonatomic)UIImage* image;

@property (nonatomic,strong) NSMutableArray *pessengersArray;
@property (nonatomic,strong) NSMutableArray *personalArray;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *itenArray;
@property (nonatomic,strong) NSMutableArray *child;
@property (nonatomic,strong) NSMutableArray *infant;
@property (nonatomic,strong) NSString *searchQuery;
@property (nonatomic,strong) NSString *requestItenary;
@property (nonatomic,strong) NSString *sessionId;
@property (nonatomic,strong) NSString *Description;
@property (nonatomic,strong) NSString *Amount;
@property (nonatomic,strong) NSString *TotalAmount;
@property (nonatomic,strong) NSString *totallChildFare;
@property (nonatomic,strong) NSString *totallInfantFare;
@property (nonatomic,strong) NSString *totallAdultFare;

@property (nonatomic) int totallChilds;
@property (nonatomic) int totallInfants;
@property (nonatomic) int totallAdults;
@property (nonatomic) int totallPessengers;
@property (nonatomic) int temptotallInfants;



+ (dataStorage *)sharedCenter;
-(NSString *)makePaxDetails;
-(void)clearData;

@end
