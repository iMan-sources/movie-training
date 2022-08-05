//
//  MovieTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MovieListViewCellDelegate <NSObject>

-(void) didLikeButtonTapped: (UITableViewCell *)cell;

@end

@interface MovieListViewCell : UITableViewCell

+(NSString *) getReuseIdentifier;
+(NSString *) getNibName;


- (void)bindingData:(Movie *)movie;

-(void) changeImageButtonByFavorite: (BOOL) isFavorited;

@property(weak, nonatomic) id<MovieListViewCellDelegate> delegate;

-(Movie *) getMovie;
@end





NS_ASSUME_NONNULL_END
