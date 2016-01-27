//
//  Vacation+CoreDataProperties.h
//  TripMaster2
//
//  Created by admin on 1/27/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Vacation.h"

@class Traveller;

NS_ASSUME_NONNULL_BEGIN

@interface Vacation (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Traveller *> *travellers;

@end

@interface Vacation (CoreDataGeneratedAccessors)

- (void)addTravellersObject:(Traveller *)value;
- (void)removeTravellersObject:(Traveller *)value;
- (void)addTravellers:(NSSet<Traveller *> *)values;
- (void)removeTravellers:(NSSet<Traveller *> *)values;

@end












NS_ASSUME_NONNULL_END
