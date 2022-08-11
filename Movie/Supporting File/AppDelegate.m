//
//  AppDelegate.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "AppDelegate.h"
#import "UserDefaultsNames.h"
#import "User.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    [self setupSettingsDefault];
    [self configNavBar];

    [self configTabBar];



    return YES;
}

//- (void)prepareLocalNotification
//    {
//    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//    } else  {
//        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
//    }
//}

-(void) configNavBar{
    UINavigationBarAppearance *navBarAppearance = [[UINavigationBarAppearance alloc] init];
    [navBarAppearance configureWithOpaqueBackground];

    navBarAppearance.backgroundColor =  [UIColor systemBlueColor];

    NSDictionary *attrs = @{
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };

    navBarAppearance.titleTextAttributes = attrs;

    [UINavigationBar appearance].standardAppearance = navBarAppearance;
    [UINavigationBar appearance].scrollEdgeAppearance = navBarAppearance;
}

-(void) configTabBar{

    NSDictionary *normalAttrs = @{
        NSFontAttributeName: [UIFont systemFontOfSize:14],
    };

    UITabBarItemAppearance *tabBarItemAppearance = [[UITabBarItemAppearance alloc] init];


    tabBarItemAppearance.normal.titleTextAttributes = normalAttrs;
    tabBarItemAppearance.selected.titleTextAttributes = normalAttrs;

    UITabBarAppearance *tabbarAppearance = [[UITabBarAppearance alloc] init];
    tabbarAppearance.inlineLayoutAppearance = tabBarItemAppearance;
    tabbarAppearance.stackedLayoutAppearance = tabBarItemAppearance;
    tabbarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance;

    [tabbarAppearance configureWithOpaqueBackground];
    tabbarAppearance.backgroundColor = [UIColor systemBlueColor];

    [UITabBar appearance].standardAppearance = tabbarAppearance;
    [UITabBar appearance].scrollEdgeAppearance = tabbarAppearance;
}

-(void) setupSettingsDefault{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:FilterTypeUserDefaults] == nil) {
        [standardUserDefaults setObject:@"0" forKey:FilterTypeUserDefaults];
    }
    if ([standardUserDefaults objectForKey: SortTypeUserDefaults] == nil) {
        [standardUserDefaults setObject:@"0" forKey:SortTypeUserDefaults];
    }
    
    [self setupFilterMovieRateAndReleaseYear:standardUserDefaults];
    [self setupUserInforInUserDefault:standardUserDefaults];
}

-(void) setupFilterMovieRateAndReleaseYear: (NSUserDefaults *) standardUserDefaults{
    if ([standardUserDefaults objectForKey:MovieRateUserDefaults] == nil) {
        [standardUserDefaults setObject:@"0.0" forKey:MovieRateUserDefaults];
    }
    if ([standardUserDefaults objectForKey: ReleaseYearUserDefaults] == nil) {
        [standardUserDefaults setObject:@"1970" forKey:ReleaseYearUserDefaults];
    }
}

-(void) setupUserInforInUserDefault: (NSUserDefaults *) standardUserDefaults{
    
    if ([standardUserDefaults objectForKey:UserInforNameDefaults] == nil) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSDateFormatter *mmddccyy = [[NSDateFormatter alloc] init];
        mmddccyy.timeStyle = NSDateFormatterNoStyle;
        mmddccyy.dateFormat = @"MM/dd/yyyy";
        NSDate *d = [mmddccyy dateFromString:@"12/11/2005"];
    
        User *user = [[User alloc] initWithName:@"default name" withBirthday:d withGender:@"Male" withImagePath:@"" withEmail:@"default@mail.com"];
        [dict setValue:[user getName] forKey: @"name"];
        [dict setValue:[user getGender] forKey: @"gender"];
        [dict setValue:[user getBirthDay] forKey: @"date"];
        [dict setValue:[user getImagePath] forKey: @"imagePath"];
        [dict setValue:[user getEmail] forKey:@"email"];
        
        [standardUserDefaults setObject:dict forKey:UserInforNameDefaults];
    }
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Coredata"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }

    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
