//
//  OGLResultadosTableViewController.h
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/10/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface OGLResultadosTableViewController : UITableViewController


@property (nonatomic, assign) NSMutableDictionary *tableData;
@property (nonatomic, retain) NSMutableArray *dataArray;

- (id)initWithStyle:(UITableViewStyle)style withData:(NSMutableArray *)data;
@end
