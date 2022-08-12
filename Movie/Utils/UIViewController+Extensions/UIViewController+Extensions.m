//
//  UIViewController+Extensions.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "UIViewController+Extensions.h"
#import "Images.h"
#import "NotificationNames.h"
@interface UIViewController()

@end
@implementation UIViewController (Extensions)

- (void)bringVCToView:(UIViewController *)viewController withView:(UIView *)view{
    [self addChildViewController: viewController];
    [[viewController view] setFrame:view.bounds];
    [view addSubview:[viewController view]];
    [viewController didMoveToParentViewController:self];
}

-(void) configLeftBarItemButtons{
    UIButton *sideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sideButton setImage:[Images getMenuHamburgerImage] forState:UIControlStateNormal];
    [sideButton addTarget:self action:@selector(didSideButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [sideButton setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:sideButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void) registerTapGestureToEndEditing{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didViewTapped:)];
    [tapGesture setCancelsTouchesInView:YES];
    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark - Action
-(void) didSideButtonTapped: (UIButton *) sender{
    NSLog(@"🛑 didSideButtonTapped");
    //post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:SideMenuNotification object:nil];
}

-(void) didViewTapped: (UITapGestureRecognizer *) sender{
    [self.view endEditing:YES];
    [self.view resignFirstResponder];
}


@end
