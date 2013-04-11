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
@property (nonatomic, assign) NSDictionary *sitesMeli;
@property (nonatomic, assign) NSDictionary *queryResult;
@property (nonatomic, assign) NSString *selectedSite;
@property (nonatomic, assign) NSString *queryString;

@end