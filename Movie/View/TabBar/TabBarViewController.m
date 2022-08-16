//
//  TabBarViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "TabBarViewController.h"
#import "Storyboard.h"
#import "SettingsViewController.h"
#import "FavoritesViewController.h"
#import "MoviesViewController.h"
#import "AboutViewController.h"
#import "ViewControllerIdentifiers.h"
#import "Images.h"
@interface TabBarViewController ()
@property(strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic) UIStoryboard *story;

@end

@implementation TabBarViewController

#pragma mark - Lifecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setup];
    [self layout];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Helpers

- (void)setup{
    
    
    self.story = [UIStoryboard storyboardWithName:[Storyboard getStoryboardName] bundle:nil];
    
    [self configTabBarController];
}

- (void)configTabBarController{
    self.tabBarController = [[UITabBarController alloc] init];
    
    UINavigationController *movieListNC = [self configMoviesVC];
    UINavigationController *aboutNC = [self configAboutVC];
    UINavigationController *settingsNC = [self configSettingsVC];
    UINavigationController *favoritesNC = [self configFavoritesVC];
    
    NSArray<UINavigationController *> *viewControllers = [[NSArray alloc] initWithObjects:movieListNC, favoritesNC, settingsNC, aboutNC, nil];
    
    for (UINavigationController *item in viewControllers) {
        item.navigationBar.backgroundColor = [UIColor systemBlueColor];
        item.navigationBar.barTintColor = [UIColor whiteColor];
    }
    
    self.tabBarController.viewControllers = viewControllers;
    
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.backgroundColor = [UIColor systemBlueColor];
    self.tabBarController.tabBar.barTintColor = [UIColor systemGrayColor];
    
    [self configTabBarFontSize];
    
}


- (void)configTabBarFontSize{
    NSDictionary *attrs = @{
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    };
    
    [[UITabBarItem appearance] setTitleTextAttributes: attrs forState:UIControlStateNormal];
}

- (void)layout{
    [[self.tabBarController view] setFrame:self.view.bounds];
    [self.view addSubview:[self.tabBarController view]];
}

#pragma mark - initialize tabbar VCs
- (UINavigationController *)configMoviesVC{
    MoviesViewController *movielistVC = [self.story instantiateViewControllerWithIdentifier:[ViewControllerIdentifiers getMoviesVCIdentifier]];
    
    UINavigationController *movielistNC = [[UINavigationController alloc] initWithRootViewController:movielistVC];
    
    movielistNC.tabBarItem.image = [Images getHomeImage];
    movielistNC.tabBarItem.title = @"Movies";
    return movielistNC;
}

- (UINavigationController *)configAboutVC{
    AboutViewController *aboutVC = [self.story instantiateViewControllerWithIdentifier:[ViewControllerIdentifiers getAboutVCIdentifer]];
    
    UINavigationController *aboutNC = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    
    aboutNC.tabBarItem.title = @"About";
    aboutNC.tabBarItem.image = [Images getAboutImage];
    return aboutNC;
}

- (UINavigationController *)configSettingsVC{
    SettingsViewController *settingsVC = [self.story instantiateViewControllerWithIdentifier:[ViewControllerIdentifiers getSettingsVCIdentifier]];
    
    UINavigationController *settingsNC = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    
    settingsNC.tabBarItem.title = @"Settings";
    settingsNC.tabBarItem.image = [Images getSettingImage];
    
    return settingsNC;
}

- (UINavigationController *)configFavoritesVC{
    FavoritesViewController *favoritesVC = (FavoritesViewController *)[self.story instantiateViewControllerWithIdentifier:[ViewControllerIdentifiers getFavoritesVCIdentifer]];
    
    //send noti when like button tapped in movie list vc
    [favoritesVC registerLikeButtonTappedNotification];
    [favoritesVC registerUnlikeButtonTappedNotification];
    
    UINavigationController *favoritesNC = [[UINavigationController alloc] initWithRootViewController:favoritesVC];

    favoritesNC.tabBarItem.title = @"Favorites";
    favoritesNC.tabBarItem.image = [Images getHeartImage];
    return favoritesNC;
}




@end
