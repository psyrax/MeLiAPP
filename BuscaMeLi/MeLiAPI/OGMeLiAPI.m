//
//  OGMeLiAPI.m
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/10/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import "OGMeLiAPI.h"

@implementation OGMeLiAPI
@synthesize sitesMeli, selectedSite, queryResult, nextPaginate, queryString;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        [self setSelectedSite:@"MLM"];
        [self setQueryString:@"Nerf"];
        [self getMeLiQuery];
    }
    return self;
}

-(void)getMeLi:(NSString *)url
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLConnection *coneccion;
    coneccion = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    NSURL *compareURL = [[ connection currentRequest ] URL];
    if (  [compareURL isEqual:[NSURL URLWithString:@"https://api.mercadolibre.com/sites"] ] ) {
        [self setSitesMeli:[self getData:data]];
        NSLog(@"sites: %@", [self sitesMeli]);
    }
    else if ( [ compareURL isEqual:[NSURL URLWithString:[self queryString] ] ] )
    {
 
        [self setQueryResult:[self getData:data]];
        NSMutableArray *resultados = [[NSMutableArray alloc] init];
        for (NSDictionary *resultado in [[self queryResult] objectForKey:@"results"]) {
            [resultados addObject:resultado];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Resultados"
                                                            object:resultados];
    }
}

-(id)getData:(NSData *)data
{
    NSError *error;
    NSDictionary *JSONMeLi = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
    return JSONMeLi;
}

-(void)getMeLiSites
{
    [self getMeLi:@"https://api.mercadolibre.com/sites"];
    
}

-(void)paginateToNext
{
    
}

-(void)getMeLiQuery
{
    [self setQueryString:[NSString
                          stringWithFormat:@"https://api.mercadolibre.com/sites/%@/search?q=%@",
                          [self selectedSite], [self queryString] ]
     ];
    [self getMeLi:[self queryString]];
}
@end
