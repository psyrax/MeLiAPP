//
//  OGLItemViewController.m
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/14/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import "OGLItemViewController.h"

@interface OGLItemViewController ()

@end

@implementation OGLItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setItemDisplay
{
    
    [self makeGalleryScroll];
    [self renderDescription];
}
-(void)makeGalleryScroll
{
    UIScrollView *picScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    int frameX = 0;
    for (NSDictionary *pic in [[self itemData] objectForKey:@"pictures"]) {
        UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake((picScroll.frame.size.width*frameX), 0, picScroll.frame.size.width, picScroll.frame.size.height)];
        [picView setImageWithURL:[pic objectForKey:@"url"]  placeholderImage:[UIImage imageNamed:@"imgs/placeholder.jpg"] ];
        [picView setContentMode:UIViewContentModeScaleAspectFit];
        [picScroll addSubview:picView];
        frameX ++;

    }
    [picScroll setContentSize:CGSizeMake((picScroll.frame.size.width*frameX), picScroll.frame.size.height)];
    [picScroll setScrollEnabled:YES];
    [picScroll setPagingEnabled:YES];
    [picScroll setShowsHorizontalScrollIndicator:YES];
    [[self view] addSubview:picScroll];
}
-(void)renderDescription
{
    NSLog(@"%@", [[self itemData] objectForKey:@"fullDescriptions"]);
}

@end
