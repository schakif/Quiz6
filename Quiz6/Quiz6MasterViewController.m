//
//  Quiz6MasterViewController.m
//  Quiz6
//
//  Created by Steve Chakif on 3/28/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import "Quiz6MasterViewController.h"
#import "Tasks.h"
#import "Quiz6DetailViewController.h"

@interface Quiz6MasterViewController () {
    
}
@end

@implementation Quiz6MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) viewWillAppear:(BOOL)animated {
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!tasks) {
        tasks = [[NSMutableArray alloc] init];
    }
    
    Tasks *task = [[Tasks alloc] init];
    [task setTaskName:[NSString stringWithFormat:@"New Task"]];
    [task setUrgency:5];
    [task setDueDate:[NSDate date]];
    [tasks addObject:task];
    
    //[tasks insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Tasks *t = [tasks objectAtIndex:[indexPath row]];
    [cell.textLabel setText:[t taskName]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    UIColor *taskColor = [UIColor colorWithRed:t.urgency/10.0 green:1.0-(t.urgency/10.0) blue:0.0 alpha:0.5];
    //[cell.contentView setBackgroundColor:taskColor];
    [cell.detailTextLabel setTextColor:taskColor];
    [cell.textLabel setTextColor:taskColor];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ (%i)", [dateFormatter stringFromDate:t.dueDate], (int) t.urgency]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Quiz6DetailViewController *detailViewController = [[Quiz6DetailViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    [detailViewController setDismissBlock:^{
        [[self tableView] reloadData];
    }];
    
    [navController setModalPresentationStyle:UIModalPresentationFullScreen];
    //Different animation styles
    [navController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        //NSDate *object = tasks[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
        
        Quiz6DetailViewController *destViewController = segue.destinationViewController;
        Tasks *t = [tasks objectAtIndex:[indexPath row]];
        destViewController.task = t;
        
    }
}

@end
