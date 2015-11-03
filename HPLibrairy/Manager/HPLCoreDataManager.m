//
//  HPLCoreDataManager.m
//  HPLibrairy
//
//  Created by Dev iOS on 02/11/2015.
//  Copyright © 2015 Dev iOS. All rights reserved.
//

#import "HPLCoreDataManager.h"
#import <CoreData/CoreData.h>
#import "BookOrder+CoreDataProperties.h"

@implementation HPLCoreDataManager

+ (instancetype)sharedInstance {
    
    static HPLCoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HPLCoreDataManager alloc] init];
    });
    return sharedInstance;
}


-(void)saveNewOrderBookForContent:(NSDictionary *)bookContent
{
    BookOrder *newManuz = [NSEntityDescription insertNewObjectForEntityForName:@"BookOrder"
                                                              inManagedObjectContext:[[HPLCoreDataManager sharedInstance] sharedObjectContext]];
    [newManuz setTitle:[bookContent objectForKey:@"bookTitle"]];
    [newManuz setIsbn:[bookContent objectForKey:@"bookIsbn"]];
    [newManuz setPrice:[bookContent objectForKey:@"bookPrice"]];
    [newManuz setCover:[bookContent objectForKey:@"bookCover"]];

}

-(void)removeOrderBook:(BookOrder *)bookOrder
{
    NSError *error = nil;
    NSManagedObjectContext *currentContext=[[HPLCoreDataManager sharedInstance] sharedObjectContext];
    [currentContext deleteObject:bookOrder];
    [currentContext save:&error];


}
@end
