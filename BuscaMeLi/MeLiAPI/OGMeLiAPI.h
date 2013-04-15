//
//  OGMeLiAPI.h
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/10/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OGMeLiAPI : NSObject <NSURLConnectionDataDelegate>

{
    int offsetQ, offsetC;
    
}
@property (nonatomic, retain) NSDictionary *sitesMeli, *queryResult;
@property (nonatomic, retain) NSString *selectedSite, *queryString, *nextPaginate, *queryURL, *itemId;
@property (nonatomic, retain) NSNumber *accion;
@property (nonatomic, retain) NSMutableDictionary *itemData;
-(void)paginateToNext;
-(void)getMeLiQuery;
-(void)getMeLiItem:(NSString *)item;
@end
