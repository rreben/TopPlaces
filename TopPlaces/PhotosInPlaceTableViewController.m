//
//  PhotosInPlaceTableViewController.m
//  TopPlaces
//
//  Created by Rupert Rebentisch on 25.08.13.
//  Copyright (c) 2013 Rupert Rebentisch. All rights reserved.
//

#import "PhotosInPlaceTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"

@interface PhotosInPlaceTableViewController ()
@property NSArray * photos;
@end

@implementation PhotosInPlaceTableViewController
@synthesize photos = _photos;
@synthesize place = _place;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define _maxResults 50

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIActivityIndicatorView   *aSpinner;
    
    //throw up spinner from submit btn we created
    aSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.tabBarController.tabBar addSubview:aSpinner];
    [aSpinner startAnimating];
    // [self.topPlaces sortedArrayUsingComparator:<#^NSComparisonResult(id obj1, id obj2)cmptr#>]
    dispatch_queue_t downloadQueue = dispatch_queue_create("photos in place", NULL);
    dispatch_async(downloadQueue, ^{
        
        NSArray * tempArray = [FlickrFetcher photosInPlace:self.place maxResults:_maxResults];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setTitle:[self.place valueForKeyPath:@"woe_name"]];
            self.photos = tempArray;
            [self.tableView reloadData];
            [aSpinner stopAnimating];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSDictionary * dict = [self.photos objectAtIndex:indexPath.row];
    PhotoViewController * pvc = segue.destinationViewController;
    pvc.photo = dict;
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoInPlaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PhotoInPlaceCell"];
    }
    NSDictionary * dict = [self.photos objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict valueForKeyPath:@"ownername"];
    cell.detailTextLabel.text = [dict valueForKeyPath:@"title"];
    
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
