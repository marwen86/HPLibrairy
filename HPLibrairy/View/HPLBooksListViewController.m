//
//  HPLBooksListViewController.m
//  HPLibrairy
//
//  Created by Dev iOS on 03/11/2015.
//  Copyright © 2015 Dev iOS. All rights reserved.
//

#import "HPLBooksListViewController.h"
#import "HPLCoreDataManager.h"
#import "HPLDataDownloaderManager.h"
#import "BookOrder.h"
#import "UIImageView+AFNetworking.h"

@interface HPLBooksListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)NSArray *booksList;
@property(nonatomic,weak)IBOutlet UITableView *tableView;

@end

@implementation HPLBooksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadBooksNotification:)
                                                 name:@"KLoadHPLBooksResponse" object:nil];
    self.booksList = [NSArray array];
    [[HPLDataDownloaderManager sharedInstance] loadHPLBooks];
}

-(void)loadBooksNotification:(NSNotification *)notification
{
   [self setBooksList: (NSArray *) notification.object];
   [self.tableView reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.booksList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"bookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *bookContent = [self.booksList objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = [bookContent objectForKey:@"title"];

    
    NSURL *url = [NSURL URLWithString:[bookContent objectForKey:@"cover"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    __weak UITableViewCell *weakCell = cell;
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the delete button's title based on how many items are selected.
    [self updateDeleteButtonTitle];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the delete button's title based on how many items are selected.
    [self updateButtonsToMatchTableState];
}

#pragma mark - Updating button state

- (void)updateButtonsToMatchTableState
{
    if (self.tableView.editing)
    {
        
        [self updateDeleteButtonTitle];
        
    }
    else
    {
      
        
    }
}

- (void)updateDeleteButtonTitle
{
    // Update the delete button's title, based on how many items are selected
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    
    BOOL allItemsAreSelected = selectedRows.count == self.booksList.count;
    BOOL noItemsAreSelected = selectedRows.count == 0;
    
    if (allItemsAreSelected || noItemsAreSelected)
    {
       
    }
    else
    {
       
    }
}




@end
