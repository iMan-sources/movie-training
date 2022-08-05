//
//  MovieDetailViewController.h
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailViewController : UIViewController

-(void) loadMovieData: (Movie *)movie;
@end

NS_ASSUME_NONNULL_END
