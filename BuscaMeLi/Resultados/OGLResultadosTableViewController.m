//
//  OGLResultadosTableViewController.m
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/10/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import "OGLResultadosTableViewController.h"

@interface OGLResultadosTableViewController ()
 
@end


@implementation OGLResultadosTableViewController


@synthesize tableData, dataArray;

- (id)initWithStyle:(UITableViewStyle)style withData:(NSMutableArray *)data
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setDataArray:data];
        [[self tableView] setRowHeight:80];
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [footer setBackgroundColor:[UIColor grayColor]];
        UILabel *mas = [[UILabel alloc] init];
        [mas setText:@"Ver más resultados"];
        [mas setTextColor:[UIColor whiteColor]];
        [mas setBackgroundColor:[UIColor clearColor]];
        [mas setFrame:footer.frame];
        [footer setUserInteractionEnabled:YES];
        UITapGestureRecognizer *masTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(masTapped)];
        [footer addGestureRecognizer:masTap];
        [footer addSubview:mas];
        [[self tableView] setTableFooterView:footer];
        //NSLog(@"%@", data);
    }
    return self;
}

-(void)masTapped
{
    NSLog(@"LOL");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[self dataArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if ( cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
   
    NSDictionary *cellResultado = [[NSDictionary alloc] initWithDictionary:[dataArray
                                                                            objectAtIndex:indexPath.row]
                            ];
    NSString *texto = [cellResultado objectForKey:@"title"];
    cell.textLabel.text = texto;
    NSString *precio = [cellResultado objectForKey:@"price"];
    NSDictionary *ubicacion = [cellResultado objectForKey:@"address"];
    NSString *estado = [ubicacion objectForKey:@"state_name"];
    NSString *condicion = [cellResultado objectForKey:@"condition"];
    NSString *condicionFancy;
    if ( [condicion isEqualToString:@"new"] ) {
        condicionFancy = @"Nuevo";
    } else if ( [condicion isEqualToString:@"used"] ){
        condicionFancy = @"Usado";
    }else
    {
        condicionFancy = @"N/A";
    }
    NSString *textoDetalle = [NSString stringWithFormat:@"$%@ %@ | %@", precio, condicionFancy, estado];
    cell.detailTextLabel.text = textoDetalle;
    
    [cell.imageView setImageWithURL:[cellResultado objectForKey:@"thumbnail"] placeholderImage:[UIImage imageNamed:@"imgs/placeholder.jpg"]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSLog(@"Selected: %@", [[dataArray objectAtIndex:indexPath.row] objectForKey:@"id"]);
}

@end
