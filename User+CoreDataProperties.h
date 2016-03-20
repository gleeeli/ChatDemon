//
//  User+CoreDataProperties.h
//  
//
//  Created by luoluo on 16/3/18.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *from;
@property (nullable, nonatomic, retain) NSString *to;
@property (nullable, nonatomic, retain) NSString *time;

@end

NS_ASSUME_NONNULL_END
