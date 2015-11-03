//
//  BookOrder+CoreDataProperties.h
//  
//
//  Created by Dev iOS on 02/11/2015.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BookOrder.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookOrder (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *isbn;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *cover;

@end

NS_ASSUME_NONNULL_END
