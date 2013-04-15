//
//  OGLMainViewController.m
//  BuscaMeLi
//
//  Created by Jose Espinoza on 11/04/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import "OGLMainViewController.h"

@interface OGLMainViewController ()

@end

@implementation OGLMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableDataMaker:) name:@"Resultados" object:nil];
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
    
    [self presentViewController:resultadosTabla animated:YES completion:^{
        
    }];

}
@end
