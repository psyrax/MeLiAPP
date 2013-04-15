//
//  OGMeLiAPI.m
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/10/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import "OGMeLiAPI.h"

@implementation OGMeLiAPI
@synthesize sitesMeli, selectedSite, queryResult, nextPaginate, queryString, itemId, itemData;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        [self setSelectedSite:@"MLM"];
        [self setQueryString:@""];
        offsetQ = 0;
        offsetC = 0;
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
    

    switch ([[self accion] intValue]) {
        case 0:
        {
            [self setSitesMeli:[self getData:data]];
        }
            break;
        case 1:
        {
            [self setQueryResult:[self getData:data]];
            NSMutableArray *resultados = [[NSMutableArray alloc] init];
            for (NSDictionary *resultado in [[self queryResult] objectForKey:@"results"]) {
                [resultados addObject:resultado];
            }
            if ( offsetQ > 0){
               
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Paginacion"
                                                                    object:resultados];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Resultados"
                                                                    object:resultados];
            }
        }
            break;
        case 3:
        {
            [self setItemData:[NSMutableDictionary dictionaryWithDictionary:[self getData:data]]];
            [self getMeLiItemDescription];
        }
            break;
        case 4:
        {
            [[self itemData] setObject:[self getData:data] forKey:@"fullDescriptions"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ItemData"
                                                                object:[self itemData]];
        }
            break;
 
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
    [self setAccion:[NSNumber numberWithInt:0]];
    [self getMeLi:@"https://api.mercadolibre.com/sites"];
   
}

-(void)paginateToNext
{
    NSDictionary *paging = [queryResult objectForKey:@"paging"];
    offsetC ++;
    offsetQ = offsetC * 50;
    if ( [ [paging objectForKey:@"total"] intValue ] > offsetQ )
    {
        [self getMeLiQuery];
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sinResultados" object:nil];
    }

}

-(void)getMeLiQuery
{
    [self setQueryURL:[NSString
                          stringWithFormat:@"https://api.mercadolibre.com/sites/%@/search?q=%@&offset=%@",
                          [self selectedSite], [self queryString], [NSString stringWithFormat:@"%i", offsetQ] ]
     ];
    [self setAccion:[NSNumber numberWithInt:1]];
    [self getMeLi:[self queryURL]];
   
}
#pragma  mark - Item de ML
-(void)getMeLiItem:(NSString *)item
{
    [self setItemId:item];
    [self setAccion:[NSNumber numberWithInt:3]];
    [self getMeLi:[NSString stringWithFormat:@"https://api.mercadolibre.com/items/%@", [self itemId]]];
}
-(void)getMeLiItemDescription
{
    [self setAccion:[NSNumber numberWithInt:4]];
    [self getMeLi:[NSString stringWithFormat:@"https://api.mercadolibre.com/items/%@/descriptions", [self itemId]]];
}
@end
