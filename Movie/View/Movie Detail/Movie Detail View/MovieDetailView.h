//
//  MovieDetailView.h
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MovieDetailViewDelegate <NSObject>

- (void)didReminderTapped;
- (void)didLikeButtonTapped:(BOOL)isFavorite;
@end
@interface MovieDetailView : UIView

- (void)bindingData:(Movie *)movie;
@property(weak, nonatomic) id<MovieDetailViewDelegate> delegate;

- (void)addRemindLabel:(NSDate *)date;

- (void)changeImageButtonByFavorite:(BOOL)isFavorited;

@end

NS_ASSUME_NONNULL_END
