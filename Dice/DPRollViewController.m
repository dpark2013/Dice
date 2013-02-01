//
//  DPRollViewController.m
//  Dice
//
//  Created by Dan Park on 1/31/13.
//  Copyright (c) 2013 Dan Park. All rights reserved.
//

#import "DPRollViewController.h"

@interface DPRollViewController ()
<UITableViewDataSource, UITableViewDelegate>
{
    NSUInteger totalScore, currentScore, rollTimes;
    NSUInteger dice1Value, dice2Value;
    IBOutlet UITableView *tableView;
}
@end

@implementation DPRollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Roll Dices";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 2;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    
    switch (indexPath.section)
    {
        case 0:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Total Score";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", totalScore];;
            }
            else if (indexPath.row == 1){
                cell.textLabel.text = @"Current Score";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", currentScore];;
            } else {
                cell.textLabel.text = @"Rolled";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", rollTimes];;
            }
        }
            break;
        case 1:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"Six Side Dice - %d", indexPath.row + 1];
            if (0  == dice1Value || 0 == dice2Value) {
                cell.detailTextLabel.text = @"Ready";
            } else {
                if (indexPath.row == 0) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", dice2Value];
                } else {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", dice1Value];
                }
            }
        }
            break;
            
        default:
            break;
    }
    
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
     [detailViewController release];
     */
}

- (IBAction)rollDices:(id)sender {
#define DiceFaces 6
    dice1Value = random() % DiceFaces + 1;
    dice2Value = random() % DiceFaces + 1;
    currentScore = dice1Value + dice2Value;
    
    if (dice1Value == dice2Value) {
        currentScore *=2;
    }
    totalScore += currentScore;
    
    rollTimes++;
    [tableView reloadData];
}

- (IBAction)resetDices:(id)sender {
    rollTimes = 0;
    dice1Value = 0;
    dice2Value = 0;
    currentScore = 0;
    [tableView reloadData];
}

- (void)dealloc {
    [tableView release];
    [super dealloc];
}
@end
