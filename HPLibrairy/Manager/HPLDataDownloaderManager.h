//
//  HPLDataDownloaderManager.h
//  HPLibrairy
//
//  Created by Dev iOS on 02/11/2015.
//  Copyright © 2015 Dev iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPLDataDownloaderManager : NSObject

-(void)loadHPLBooks;
-(void)loadHPLOffersForBookList:(NSArray *)boooksArray;

+ (id)sharedInstance;

@end
