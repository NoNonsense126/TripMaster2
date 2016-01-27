//
//  VacationsTableViewController.m
//  TripMaster2
//
//  Created by Fiaz Sami on 1/7/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

#import "AppDelegate.h"
#import "VacationsTableViewController.h"
#import "Vacation.h"

@interface VacationsTableViewController () <UITextFieldDelegate>

@property NSManagedObjectContext *moc;
@property NSArray *vacations;

@end

@implementation VacationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadVacations];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Vacation"];
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@", textField.text];
    NSError *error;
    NSArray *results = [self.moc executeFetchRequest:request error:&error];
    if (error == nil && results.count == 0) {
        Vacation *vacation =
        [NSEntityDescription insertNewObjectForEntityForName:@"Vacation" inManagedObjectContext:self.moc];
        vacation.name = textField.text;

        NSError *error;
        if ([self.moc save:&error]) {
            [self loadVacations];
        } else {
            NSLog(@"AN ERROR HAS OCCURRED : %@", error);
        }
    }
    textField.text = nil;
    return [textField resignFirstResponder];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vacations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VacationCell" forIndexPath:indexPath];

    Vacation *vacation = self.vacations[indexPath.row];
    cell.textLabel.text = vacation.name;

    cell.detailTextLabel.text = [NSString stringWithFormat:@"travellers: %li", vacation.travellers.count];
    
    
    return cell;
}

@end
