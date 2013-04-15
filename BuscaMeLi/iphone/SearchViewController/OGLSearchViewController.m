//
//  OGLSearchViewController.m
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/12/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import "OGLSearchViewController.h"
#import "NSString+URLEncode.h"


@interface OGLSearchViewController ()

@end

@implementation OGLSearchViewController

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
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 100.0f, 280.0f, 31.0f)];
    [searchText setBackgroundColor:[UIColor whiteColor]];
    [searchText setPlaceholder:@"¿Qué estas buscando?"];
    [searchText setBorderStyle:UITextBorderStyleRoundedRect];
    [searchText setReturnKeyType:UIReturnKeyGo];
    [searchText setDelegate:self];
    [[self view] addSubview:searchText];
	
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSString *queryRaw = [NSString stringWithFormat:@"%@", [textField text]];
    NSString *safeString = [queryRaw urlencode];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"querySet"
                                                        object:safeString];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
