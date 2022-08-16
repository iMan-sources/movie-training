//
//  MainViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "MainViewController.h"
#import "UIViewController+Extensions.h"
#import "ProfileViewController.h"
#import "Storyboard.h"
#import "ViewControllerIdentifiers.h"
#import "TabBarViewController.h"
#import "MovieListViewController.h"
#import "NotificationNames.h"
#import "EditProfileViewController.h"
#import "RemindersViewController.h"
#import "SettingsViewController.h"
typedef NS_ENUM(NSInteger, SideMenuStatus){
    state_close,
    state_open
};

typedef NS_ENUM(NSInteger, FooterProfileButtonSelected){
    edit_state,
    show_all_reminders_state
};

@interface MainViewController()<ProfileViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (strong, nonatomic) ProfileViewController *profileViewController;
@property (strong, nonatomic) TabBarViewController *tabBarViewController;
@property (nonatomic) UIStoryboard *story;
@property (nonatomic) SideMenuStatus sideMenuStatus;
@property(nonatomic) NSInteger slideMenuPadding;
@property (strong, nonatomic) UIWindow *window;

@end



@implementation MainViewController

#pragma mark - Lifecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark - Class Helpers

#pragma mark - Helpers

- (void)setup{
    self.story = [UIStoryboard storyboardWithName:[Storyboard getStoryboardName] bundle:nil];
    
    self.slideMenuPadding = UIScreen.mainScreen.bounds.size.width * CoefficientWidthInSreen;
    
    [self initRelatedViewControllers];
    [self bringProfileViewControllerToView];
    
    self.sideMenuStatus = state_close;
    
    [self registerSideMenuNotification];
    
}

- (void)layout{
    
}

- (void)initRelatedViewControllers{
    NSString *profileVCIdentifier = [ViewControllerIdentifiers getProfileVCIdentifer];
    
    NSString *tabBarVCIdentifier = [ViewControllerIdentifiers getTabBarVCIdentifier];
    
    self.profileViewController = [self.story instantiateViewControllerWithIdentifier: profileVCIdentifier];
    self.profileViewController.delegate = self;
    self.tabBarViewController = [self.story instantiateViewControllerWithIdentifier: tabBarVCIdentifier];
}

- (void)bringProfileViewControllerToView{
    
    [self bringVCToView:self.profileViewController withView:self.profileView];
    [self bringVCToView:self.tabBarViewController withView:self.tabBarView];
    
}

- (void)registerSideMenuNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSideBarButtonTapped:) name:SideMenuNotification object:nil];
}

- (void)handleSlideMenuWhenPushVC{
    //hide the profile VC
    if (self.sideMenuStatus == state_open) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SideMenuNotification object:nil];
    }
}

#pragma mark - Action

- (void)didSideBarButtonTapped:(NSNotification *)sender{
    switch (self.sideMenuStatus) {
        case state_close:
        {
            NSInteger padding = self.slideMenuPadding;
            [self slideTabbarViewToTheRightWithSpacing: padding];
            break;
        }
        case state_open:
        {
            [self slideTabbarViewToTheRightWithSpacing: 0];
            break;
        }
    }
}

- (void)didButtonInProfileVCTapped:(NSInteger)tag{
    EditProfileViewController *editProfileVC = [[EditProfileViewController alloc] initWithNibName:[EditProfileViewController getNibName] bundle:nil];
    if (tag == 0) {
        [self.navigationController pushViewController:editProfileVC animated:YES];
        [ self handleSlideMenuWhenPushVC];
        return;
    }
    
    RemindersViewController *reminderVC = [[RemindersViewController alloc] initWithNibName:[RemindersViewController getNibName] bundle:nil];

    UIScene *scene = [[[[UIApplication sharedApplication] connectedScenes] allObjects] firstObject];
    
    if([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]){
        self.window = [(id <UIWindowSceneDelegate>)scene.delegate window];
    }

    [self handleSlideMenuWhenPushVC];
     [self.tabBarViewController.tabBarController setSelectedIndex:2];

    UINavigationController * navController = (UINavigationController *)[self.tabBarViewController.tabBarController.viewControllers objectAtIndex:2];
    if (navController) {
        [navController pushViewController:reminderVC animated:YES];
    }
    
}


- (void)slideTabbarViewToTheRightWithSpacing:(NSInteger)padding{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect f = self.tabBarView.frame;
        f.origin.x = padding;
        self.tabBarView.frame = f;
    } completion:^(BOOL finished) {
        if (finished) {
            switch (self.sideMenuStatus) {
                case state_close:
                {
                    self.sideMenuStatus = state_open;
                    break;}
                case state_open:
                {
                    self.sideMenuStatus = state_close;
                    break;
                    
                }
            }
            
        }
    }];
}



@end
