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


@synthesize dataArray;

- (id)initWithStyle:(UITableViewStyle)style withData:(NSMutableArray *)data
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(addPage:)
                                                     name:@"Paginacion" object:nil
         ];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(endPage:)
                                                     name:@"sinResultados"
                                                   object:nil
         ];
        [self setDataArray:data];
        [[self tableView] setRowHeight:80];
        footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [footer setUserInteractionEnabled:YES];
        [[self tableView] setTableFooterView:footer];
        UIBarButtonItem *queryMaker = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:[self parentViewController] action:@selector(queryShow)];
        [[self navigationItem] setLeftBarButtonItem:queryMaker animated:YES];
        
    }
    return self;
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
    [[cell detailTextLabel] sizeToFit];
    
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
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"SelectedItem"
     object:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGSize contentSize = [scrollView contentSize];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat offset = scrollView.contentOffset.y;

    if ( ( contentSize.height - offset ) <= (screenBounds.size.height + 200) ) {
        if ( ![paginando isAnimating] )
        {
            [paginando startAnimating];
            [self setActivityIndicator];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getNext" object:nil];
        }
      
       
    }
}
-(void)setActivityIndicator
{
    paginando = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [paginando setFrame:CGRectMake( ( (footer.bounds.size.width/2) - (paginando.frame.size.width/2) ), ( (footer.bounds.size.height/2) - (paginando.frame.size.height/2) ), paginando.frame.size.width, paginando.frame.size.height)];
    [paginando setHidesWhenStopped:YES];
    [paginando stopAnimating];
    [footer addSubview:paginando];

}
#pragma mark - Add Page
-(void)addPage:(NSNotification *)notificacionPagina
{
    [[self dataArray] addObjectsFromArray:[notificacionPagina object]];
    [[self tableView] reloadData];
    [paginando stopAnimating];
}
#pragma mark - End Page
-(void)endPage:(NSNotification *)notificacionEnd
{
    [paginando removeFromSuperview];
    UILabel *end = [[UILabel alloc] init];
    [end setText:@"No hay mas resultados"];
    [end sizeToFit];
    [end setFrame:CGRectMake( ( (footer.bounds.size.width/2) - (end.frame.size.width/2) ), ( (footer.bounds.size.height/2) - (end.frame.size.height/2) ), end.frame.size.width, end.frame.size.height)];
    [footer addSubview:end];
}
@end
