//
//  HPLCoreDataManager.h
//  HPLibrairy
//
//  Created by Dev iOS on 02/11/2015.
//  Copyright © 2015 Dev iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookOrder.h"

@interface HPLCoreDataManager : NSObject

@property (nonatomic,strong) NSManagedObjectContext *sharedObjectContext;

+ (id)sharedInstance;
-(void)saveNewOrderBookForContent:(NSDictionary *)bookContent;
-(void)removeOrderBook:(BookOrder *)bookOrder;

@end
