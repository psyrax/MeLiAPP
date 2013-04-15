//
//  OGLNavigationViewController.m
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/12/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import "OGLNavigationViewController.h"

@interface OGLNavigationViewController ()

@end

@implementation OGLNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tableDataMaker:)
                                                     name:@"Resultados"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setItem:)
                                                     name:@"ItemData"
                                                   object:nil];
        
        [[self navigationBar] setTintColor:[UIColor blackColor]];
        [self setNavigationBarHidden:YES];
        
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
#pragma mark - Table Data Maker
-(void)tableDataMaker:(NSNotification *)notificacion
{
    resultadosTabla = [[OGLResultadosTableViewController alloc] initWithStyle:UITableViewStylePlain
                                                                     withData:[notificacion object]
                       ];
    [self setNavigationBarHidden:NO animated:YES];
    [self pushViewController:resultadosTabla animated:YES];
    
}

#pragma mark - Query Show
-(void)queryShow
{
    [self setNavigationBarHidden:YES animated:YES];
    [self popToRootViewControllerAnimated:YES];
}
#pragma  mark - Set Item
-(void)setItem:(NSNotification *)itemNotification
{
    if (itemView) {
        itemView = nil;
    }
    itemView = [[OGLItemViewController alloc] init];
    [itemView setItemData:[itemNotification object]];
    [itemView setItemDisplay];
    [self pushViewController:itemView animated:YES];
    
}

@end
