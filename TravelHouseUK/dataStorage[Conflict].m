//
//  dataStorage.m
//  TravelHouseUK
//
//  Created by AR on 29/01/2014.
//
//

#import "dataStorage.h"

@implementation dataStorage{
    }
static dataStorage *sharedAwardCenter = nil;    // static instance variable
@synthesize pessengersArray,personalArray,totallPessengers,totallInfants,totallAdults,totallChilds,temptotallInfants,itenArray,searchQuery,requestItenary,sessionId,Description,Amount,dataArray,image;

+ (dataStorage *)sharedCenter {
    if (sharedAwardCenter == nil) {
        sharedAwardCenter = [[dataStorage alloc] init];
    }
    return sharedAwardCenter;
}

-(id)init {
    if ( (self = [super init]) )
    {
        pessengersArray = [[NSMutableArray alloc] init];
        personalArray = [[NSMutableArray alloc] init];
        itenArray=[[NSMutableArray alloc]init];
        totallAdults = 0;
        totallInfants = 0;
        totallPessengers = 0;
        totallChilds = 0;
        temptotallInfants=0;
        
        
    }
    temptotallInfants=totallInfants;
    return self;
}

-(void)clearData
{
    [pessengersArray removeAllObjects];
    [personalArray removeAllObjects];
    [itenArray removeAllObjects];
    totallAdults = 0;
    totallInfants = 0;
    totallPessengers = 0;
    totallChilds = 0;
    temptotallInfants=0;
    [dataArray removeAllObjects];
    searchQuery=@"";
    requestItenary=@"";
    Description=@"";
}

-(NSString *)makePaxDetails
{
    NSString *paxDetails=@"";
    if([pessengersArray count]>0)
    {
        NSMutableArray *arr=[pessengersArray objectAtIndex:0];
        
        NSString *email=[personalArray objectAtIndex:1];
        NSString *phone=[personalArray objectAtIndex:2];
        NSString *gender=[arr objectAtIndex:0];
        NSString *fname=[arr objectAtIndex:1];
        NSString *lname=[arr objectAtIndex:2];
        NSString *dob=[arr objectAtIndex:3];
        NSString *passport=[arr objectAtIndex:4];
        
        paxDetails=[NSString stringWithFormat:@"<ClientDetail>\n"
                    "<ClientId>ADT1</ClientId>\n"
                    "<Title>MR</Title>\n"
                    "<FirstName>%@</FirstName>\n"
                    "<LastName>%@</LastName>\n"
                    "<Age />\n"
                    "<DOB>%@</DOB>\n"
                    "<Gender>%@</Gender>\n"
                    "<Email>%@</Email>\n"
                    "<Mobile>%@</Mobile>\n"
                    "<Phone>%@</Phone>\n"
                    "<Meal>FPML</Meal>\n"
                    "<Seat>C</Seat>\n"
                    "<Passport>%@</Passport>\n"
                    "<Nationality />\n"
                    "</ClientDetail>\n",fname,lname,dob,gender,email,phone,phone,passport];
        
        
        paxDetails=[NSString stringWithFormat:@"%@<PaxDetail>\n"
                    "<NoOfAdult>%d</NoOfAdult>\n"
                    "<NoOfChild>%d</NoOfChild>\n"
                    "<NoOfInfant>%d</NoOfInfant>\n"
                    "<AdditionalDetails>\n",paxDetails,totallAdults,totallChilds,totallInfants];
        
        /*<PaxDetail>
         <NoOfAdult>2</NoOfAdult>
         <NoOfChild>1</NoOfChild>
         <NoOfInfant>2</NoOfInfant>
         <AdditionalDetails>
         <LocalId>ADT1</LocalId>
         <LocalId>ADT2</LocalId>
         <LocalId>CHD1</LocalId>
         <LocalId>INF1</LocalId>
         <LocalId>INF2</LocalId>
         </AdditionalDetails>
         */
        
        
        int i=0;

        while(i<totallAdults)
        {
            paxDetails=[NSString stringWithFormat:@"%@<LocalId>ADT%d</LocalId>\n",paxDetails,i+1];
            i++;
        }
        
        while(i<totallAdults+totallChilds)
        {
            paxDetails=[NSString stringWithFormat:@"%@<LocalId>CHD%d</LocalId>\n",paxDetails,i+1-totallAdults];
            i++;
        }
        
        while(i<totallAdults+totallChilds+totallInfants)
        {
            paxDetails=[NSString stringWithFormat:@"%@<LocalId>INF%d</LocalId>\n",paxDetails,i+1-totallAdults-totallChilds];
            i++;
        }
        
        paxDetails=[paxDetails stringByAppendingString:@"</AdditionalDetails>\n"];
        
        
        i=0;
        
        temptotallInfants=totallInfants;
        while(i<totallAdults)
        {
            arr=[pessengersArray objectAtIndex:i];
            gender=[arr objectAtIndex:0];
            fname=[arr objectAtIndex:1];
            lname=[arr objectAtIndex:2];
            dob=[arr objectAtIndex:3];
            passport=[arr objectAtIndex:4];
        
            if (temptotallInfants!=0) {
                temptotallInfants=temptotallInfants-1;
                paxDetails=[NSString stringWithFormat:@"%@<Adult>\n"
                            "<LocalId>ADT%d</LocalId>\n"
                            "<Type>ADT</Type>\n"
                            "<Title>MR</Title>\n"
                            "<FirstName>%@</FirstName>\n"
                            "<LastName>%@</LastName>\n"
                            "<Age />\n"
                            "<DOB>%@</DOB>\n"
                            "<Gender>%@</Gender>\n"
                            "<Email />\n"
                            "<Phone />\n"
                            "<Meal>FPML</Meal>\n"
                            "<Seat>C</Seat>\n"
                            "<Passport>%@</Passport>\n"
                            "<Nationality />\n"
                            "<InfAsso>INF%d</InfAsso>\n"
                            "</Adult>\n",paxDetails,i+1,fname,lname,dob,gender,passport,i+1];
                
                
            }
            else{
                paxDetails=[NSString stringWithFormat:@"%@<Adult>\n"
                            "<LocalId>ADT%d</LocalId>\n"
                            "<Type>ADT</Type>\n"
                            "<Title>MR</Title>\n"
                            "<FirstName>%@</FirstName>\n"
                            "<LastName>%@</LastName>\n"
                            "<Age />\n"
                            "<DOB>%@</DOB>\n"
                            "<Gender>%@</Gender>\n"
                            "<Email />\n"
                            "<Phone />\n"
                            "<Meal>FPML</Meal>\n"
                            "<Seat>C</Seat>\n"
                            "<Passport>%@</Passport>\n"
                            "<Nationality />\n"
                            "<InfAsso />\n"
                            "</Adult>\n",paxDetails,i+1,fname,lname,dob,gender,passport];

            }
           i++;
        }
        
        while(i<totallAdults+totallChilds)
        {
            arr=[pessengersArray objectAtIndex:i];
            gender=[arr objectAtIndex:0];
            fname=[arr objectAtIndex:1];
            lname=[arr objectAtIndex:2];
            dob=[arr objectAtIndex:3];
            passport=[arr objectAtIndex:4];
            paxDetails=[NSString stringWithFormat:@"%@<Child>\n"
                        "<LocalId>CHD%d</LocalId>\n"
                        "<Type>CHD</Type>\n"
                        "<Title>Master</Title>\n"
                        "<FirstName>%@</FirstName>\n"
                        "<LastName>%@</LastName>\n"
                        "<Age />\n"
                        "<DOB>%@</DOB>\n"
                        "<Gender>%@</Gender>\n"
                        "<Email />\n"
                        "<Phone />\n"
                        "<Meal>FPML</Meal>\n"
                        "<Seat>C</Seat>\n"
                        "<Passport>%@</Passport>\n"
                        "<Nationality />\n"
                        "<InfAsso/>\n"
                        "</Child>\n",paxDetails,i+1-totallAdults,fname,lname,dob,gender,passport];
            i++;
        }
        
        while(i<totallAdults+totallChilds+totallInfants)
        {
            arr=[pessengersArray objectAtIndex:i];
            gender=[arr objectAtIndex:0];
            fname=[arr objectAtIndex:1];
            lname=[arr objectAtIndex:2];
            dob=[arr objectAtIndex:3];
            passport=[arr objectAtIndex:4];
            paxDetails=[NSString stringWithFormat:@"%@<Infant>\n"
                        "<LocalId>INF%d</LocalId>\n"
                        "<Type>INF</Type>\n"
                        "<Title>Master</Title>\n"
                        "<FirstName>%@</FirstName>\n"
                        "<LastName>%@</LastName>\n"
                        "<Age />\n"
                        "<DOB>%@</DOB>\n"
                        "<Gender>%@</Gender>\n"
                        "<Email />\n"
                        "<Phone />\n"
                        "<Meal>FPML</Meal>\n"
                        "<Seat>C</Seat>\n"
                        "<Passport>%@</Passport>\n"
                        "<Nationality />\n"
                        "<InfAsso/>\n"
                        "</Infant>\n",paxDetails,i+1-totallAdults-totallChilds,fname,lname,dob,gender,passport];
            i++;
        }
        paxDetails=[paxDetails stringByAppendingString:@"</PaxDetail>\n"];
        
    }
    
    
    return paxDetails;
    
    /*<ClientDetail>
     <ClientId>ADT1</ClientId>
     <Title>MR</Title>
     <FirstName>KUNDAN</FirstName>
     <LastName>KUMAR</LastName>
     <Age />
     <DOB>06-06-1992</DOB>
     <Gender></Gender>
     <Email>kundan@crystaltravel.co.uk</Email>
     <Mobile>33132131</Mobile>
     <Phone>321321321</Phone>
     <Meal>FPML</Meal>
     <Seat>C</Seat>
     <Passport />
     <Nationality />
     </ClientDetail>
     */
}

@end
