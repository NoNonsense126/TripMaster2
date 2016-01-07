//
//  Vacation+CoreDataProperties.h
//  TripMaster2
//
//  Created by Fiaz Sami on 1/7/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Vacation.h"

NS_ASSUME_NONNULL_BEGIN

@interface Vacation (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
