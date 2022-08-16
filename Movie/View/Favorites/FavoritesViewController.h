//
//  FavoritesViewController.h
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import <UIKit/UIKit.h>
#import "MovieListViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface FavoritesViewController : UIViewController
- (void)registerLikeButtonTappedNotification;
- (void)registerUnlikeButtonTappedNotification;
@end

NS_ASSUME_NONNULL_END
