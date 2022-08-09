//
//  NotificationNames.h
//  Movie
//
//  Created by AnhVT12.REC on 8/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
static NSString * const LikeButtonTappedNotification = @"like_button_tapped_notification";
static NSString * const UnlikeButtonTappedNotification = @"unlike_button_tapped_notification";
static NSString * const SideMenuNotification = @"side_menu_notification";
static NSString * const DidFilterTypeChangedNotification = @"did_filter_type_changed";
static NSString * const DidSortTypeChangedNotification = @"did_sort_type_changed";
static NSString * const DidMovieRateChangedNotification = @"did_movie_rate_slided";

static NSString * const DidReleaseYearChangedNotification = @"did_release_year_changed";
@interface NotificationNames : NSObject

@end

NS_ASSUME_NONNULL_END
