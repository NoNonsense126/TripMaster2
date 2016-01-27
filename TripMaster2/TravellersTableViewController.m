//
//  TravellerTableViewController.m
//  TripMaster1
//
//  Created by Fiaz Sami on 12/28/15.
//  Copyright © 2015 mobilemakers. All rights reserved.
//

#import "AppDelegate.h"
#import "TravellersTableViewController.h"
#import "Traveller.h"
#import "Vacation.h"
//@class Traveller;

@interface TravellersTableViewController () <UITextFieldDelegate>

@property NSManagedObjectContext *moc;
@property NSArray *travellers;
@property NSArray *vacations;

@end

@implementation TravellersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self loadVacations];
    
    [self loadTravellers:@0];
}

- (void)loadVacations {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Vacation"];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortByName];
    
    NSError *error;
    
    self.vacations = [self.moc executeFetchRequest:request error:&error];
    
    if (error == nil) {
        [self.tableView reloadData];
    } else {
        NSLog(@"AN ERROR OCCURRED : %@", error);
    }
}

- (void)loadTravellers:(NSNumber *)withAge {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Traveller"];

    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *sortByBudget = [[NSSortDescriptor alloc] initWithKey:@"budget" ascending:NO];

    request.sortDescriptors = @[sortByBudget, sortByName];

    NSPredicate *agePredicate = [NSPredicate predicateWithFormat:@"age >= %@", withAge];
    request.predicate = agePredicate;

    NSError *error;

    self.travellers = [self.moc executeFetchRequest:request error:&error];

    if (error == nil) {
        [self.tableView reloadData];
    } else {
        NSLog(@"AN ERROR OCCURRED");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    Traveller *traveller = [NSEntityDescription insertNewObjectForEntityForName:@"Traveller" inManagedObjectContext:self.moc];
    traveller.name = textField.text;
    traveller.age = [NSNumber numberWithInt:arc4random_uniform(100)];
    traveller.budget = [NSNumber numberWithInt:100 + arc4random_uniform(400)];
    
    traveller.destination = [self.vacations objectAtIndex:arc4random_uniform((int)self.vacations.count)];

    NSError *error;

    if ([self.moc save:&error]) {
        [self loadTravellers:@5];
    } else {
        NSLog(@"AN ERROR HAS OCCURRED : %@", error);
    }

    textField.text = nil;
    return [textField resignFirstResponder];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.travellers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TravellerCell" forIndexPath:indexPath];

    Traveller *traveller = [self.travellers objectAtIndex:indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@", traveller.name];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"age: %@\nbudget: $%@\nvacations: %@", traveller.age, traveller.budget, traveller.destination.name];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

@end
