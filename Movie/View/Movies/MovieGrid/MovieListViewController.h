//
//  MovieListViewController.h
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import <UIKit/UIKit.h>
#import "MoviesViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MovieVCChildViewDelegate <NSObject>

- (void)scrollViewDidEndDragging;
- (void)didRefreshControlCalled;
- (void)didCellSelected:(Movie *)movie;
@end

@interface MovieListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(weak, nonatomic) id<MovieVCChildViewDelegate> delegate;
- (void)reloadData;
- (void)loadViewModel:(MoviesViewModel *)viewModel;
- (void)endRefreshing;
@end

NS_ASSUME_NONNULL_END
