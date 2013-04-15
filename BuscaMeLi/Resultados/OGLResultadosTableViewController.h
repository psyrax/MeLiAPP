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
<UIScrollViewDelegate>
{
    UIView *footer;
    UIActivityIndicatorView *paginando;
}

@property (nonatomic, retain) NSMutableArray *dataArray;

- (id)initWithStyle:(UITableViewStyle)style withData:(NSMutableArray *)data;
@end
