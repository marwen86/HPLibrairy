//
//  ViewController.m
//  HPLibrairy
//
//  Created by Dev iOS on 02/11/2015.
//  Copyright © 2015 Dev iOS. All rights reserved.
//

#import "ViewController.h"
#import "HPLCoreDataManager.h"
#import "HPLDataDownloaderManager.h"
#import "BookOrder.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
     [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(loadBooksNotification:)
                                                  name:@"KLoadHPLBooksResponse" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadBooksOfferNotification:)
                                                 name:@"KLoadHPLBooksOfferResponse" object:nil];
    
    [[HPLDataDownloaderManager sharedInstance] loadHPLBooks];
}

-(void)loadBooksNotification:(NSNotification *)notification
{
    NSArray *listBooks = (NSArray *) notification.object;
    NSMutableArray *listar=[NSMutableArray array];
    [listBooks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [listar addObject:[obj objectForKey:@"isbn"]];
    }];
    [[HPLDataDownloaderManager sharedInstance] loadHPLOffersForBookList:listar];
    
}
-(void)loadBooksOfferNotification:(NSNotification *)notification
{

    NSDictionary *booksOffers = (NSDictionary *) notification.object;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
