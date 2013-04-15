//
//  OGLNavigationViewController.h
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/12/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OGLResultadosTableViewController.h"
#import "OGLItemViewController.h"
@interface OGLNavigationViewController : UINavigationController
{
    OGLResultadosTableViewController *resultadosTabla;
    OGLItemViewController *itemView;
}
@end
