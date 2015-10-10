//
//  PccpaListViewController.m
//  iOSCrud
//
//  Created by 朱梦晓 on 15-10-8.
//  Copyright (c) 2015年 Pccpa. All rights reserved.
//

#import "PccpaListViewController.h"
#import "PccpaDBHelper.h"
#import "PccpaAddViewController.h"
#import "PccpaDetailViewController.h"

@interface PccpaListViewController ()

@end

@implementation PccpaListViewController

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
    
    PccpaDBHelper * helper = [[PccpaDBHelper alloc]init];
    self.list = [helper getTaskList];

    
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(cell==nil)
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    PccpaTask * task = (PccpaTask *)self.list[indexPath.row];
    cell.textLabel.text = task.taskName;
    
    
    
       
    return cell;
}

-(IBAction)backToList:(UIStoryboardSegue *)segue 
{
    UIViewController * srcs = segue.sourceViewController;
    if([srcs isKindOfClass:[PccpaAddViewController class]])
    {
    
        PccpaAddViewController * src = segue.sourceViewController;
        if(src.item!=nil){
            PccpaDBHelper * helper = [[PccpaDBHelper alloc]init];
            [helper addTask:src.item];
            self.list = [helper getTaskList];
            [self.tableView reloadData];
        }
    }
    else if([srcs isKindOfClass:[PccpaDetailViewController class]])
    {
        PccpaDetailViewController * src= segue.sourceViewController;
        if(src.task!=nil)
        {
            PccpaDBHelper * helper = [[PccpaDBHelper alloc]init];
            [helper updateTask:src.task];
            self.list = [helper getTaskList];
            [self.tableView reloadData];
        }
        
    }
   
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        PccpaTask * task =(PccpaTask *)self.list[indexPath.row];
        [self.list removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // delete from the db.
        
        PccpaDBHelper * helper = [[PccpaDBHelper alloc]init];
        
        [helper deleteTask:task];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
-(IBAction)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([sender isKindOfClass:[UITableViewCell class]])
    {
    NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
    PccpaTask * task =(PccpaTask *)self.list[indexPath.row];
    PccpaDetailViewController *detail = (PccpaDetailViewController *)segue.destinationViewController;
    detail.task = task;
    }
}

@end
