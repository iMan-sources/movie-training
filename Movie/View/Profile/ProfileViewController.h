//
//  ProfileViewController.h
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ProfileViewControllerDelegate

- (void)didButtonInProfileVCTapped: (NSInteger) tag;

@end
@interface ProfileViewController : UIViewController

@property(weak, nonatomic) id<ProfileViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
