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
    
}
@property (nonatomic, assign) NSDictionary *sitesMeli, *queryResult;
@property (nonatomic, assign) NSString *selectedSite, *queryString, *nextPaginate;
@end
