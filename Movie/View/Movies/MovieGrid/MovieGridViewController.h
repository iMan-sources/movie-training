//
//  MovieGridViewController.h
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import <UIKit/UIKit.h>
#import "MoviesViewModel.h"
#import "MovieListViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MovieGridViewController : UIViewController
- (void)reloadData;

- (void)loadViewModel:(MoviesViewModel *)viewModel;
@property(weak, nonatomic) id<MovieVCChildViewDelegate> delegate;

- (void)endRefreshing;
@end

NS_ASSUME_NONNULL_END
