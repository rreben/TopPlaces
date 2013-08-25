//
//  TopPlacesTableViewController.m
//  TopPlaces
//
//  Created by Rupert Rebentisch on 20.07.13.
//  Copyright (c) 2013 Rupert Rebentisch. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotosInPlaceTableViewController.h"

@interface TopPlacesTableViewController ()
@property NSArray * topPlaces;
@end

@implementation TopPlacesTableViewController

@synthesize topPlaces = _topPlaces;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self.topPlaces sortedArrayUsingComparator:<#^NSComparisonResult(id obj1, id obj2)cmptr#>]
    self.topPlaces = [[FlickrFetcher topPlaces] sortedArrayUsingComparator:^(id obj1, id obj2){
        NSDictionary * dict1, *dict2;
        dict1 = obj1;
        dict2 = obj2;
        return [[dict1 valueForKeyPath:@"woe_name"] localizedCompare:[dict2 valueForKeyPath:@"woe_name"]];
//        return [[dict1 valueForKeyPath:@"woe_name"] localizedCompare:[dict2 valueForKeyPath:@"woe_name"]];

//        if ([[dict1 valueForKeyPath:@"woe_name"] localizedCompare:[dict2 valueForKeyPath:@"woe_name"]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        
//        if ([dict1 valueForKeyPath:@"woe_name"] < [dict2 valueForKeyPath:@"woe_name"]) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        
//        return (NSComparisonResult)NSOrderedSame;
    }];

    
    //[self.tableView setDelegate:self];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSDictionary * dict = [self.topPlaces objectAtIndex:indexPath.row];
    PhotosInPlaceTableViewController * piptvc = segue.destinationViewController;
    piptvc.place = dict;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 5;
    return [[FlickrFetcher topPlaces] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TopPlaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TopPlaceCell"];
    }
    NSDictionary * dict = [self.topPlaces objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict valueForKeyPath:@"woe_name"];
    cell.detailTextLabel.text = [dict valueForKeyPath:@"_content"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
