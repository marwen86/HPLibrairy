//
//  HPLDataDownloaderManager.m
//  HPLibrairy
//
//  Created by Dev iOS on 02/11/2015.
//  Copyright © 2015 Dev iOS. All rights reserved.
//

#import "HPLDataDownloaderManager.h"
#import "AFNetworking.h"
#import "BookOrder.h"

#define BOOKS_DOWNOLAOD_BASE_URL @"http://henri-potier.xebia.fr/books"


@implementation HPLDataDownloaderManager

+ (instancetype)sharedInstance {
    
    static HPLDataDownloaderManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HPLDataDownloaderManager alloc] init];
    });
    return sharedInstance;
}


-(void)loadHPLBooks
{
  
    
  
    NSString* stringURL = [NSString stringWithFormat:@"%@",BOOKS_DOWNOLAOD_BASE_URL];
    NSString* webStringURL = [stringURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL* url = [NSURL URLWithString:webStringURL];
    
   
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];


    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      
        NSArray *responseArray= (NSArray *)responseObject;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KLoadHPLBooksResponse"
                                                            object:responseArray];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
   
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error Retrieving Books"
                                      message:[error localizedDescription]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           //Handel your yes please button action here
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                           
                                       }];
        
        [alert addAction:cancelButton];
    }];
    
  
    [operation start];
}

-(void)loadHPLOffersForBookList:(NSArray *)booksArray
{
    NSString *listOfBooksStr=[booksArray componentsJoinedByString:@","];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@/{%@}/commercialOffers", BOOKS_DOWNOLAOD_BASE_URL,listOfBooksStr];
    NSString* webStringURL = [stringURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL* url = [NSURL URLWithString:webStringURL];
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KLoadHPLBooksOfferResponse"
                                                            object:responseDict];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error Retrieving Books"
                                      message:[error localizedDescription]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //Handel your yes please button action here
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
        
        [alert addAction:cancelButton];
     
    }];
    
    
    [operation start];
}


@end
