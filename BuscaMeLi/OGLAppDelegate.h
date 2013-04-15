//
//  OGLAppDelegate.h
//  BuscaMeLi
//
//  Created by Jose Luis Espinoza Cuevas on 4/10/13.
//  Copyright (c) 2013 OGLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OGLNavigationViewController.h"
#import "OGMeliAPI.h"
#import "OGLSearchViewController.h"


@interface OGLAppDelegate : UIResponder <UIApplicationDelegate>


{
    OGLNavigationViewController *mainVC;
    OGMeLiAPI *MeLiAPI;
    OGLSearchViewController *searchView;

}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
