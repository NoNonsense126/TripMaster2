//
//  Traveller+CoreDataProperties.h
//  TripMaster2
//
//  Created by admin on 1/27/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Traveller.h"

@class Vacation;

NS_ASSUME_NONNULL_BEGIN

@interface Traveller (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSNumber *budget;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Vacation *destination;

@end

NS_ASSUME_NONNULL_END
