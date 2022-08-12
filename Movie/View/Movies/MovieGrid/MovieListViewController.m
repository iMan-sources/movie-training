//
//  MovieListViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import "MovieListViewController.h"
#import "Images.h"
#import "MovieListViewCell.h"
#import "FavoritesViewModel.h"
#import "NotificationNames.h"
#import "AlertManager.h"
@interface MovieListViewController ()<MovieListViewCellDelegate>
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) MoviesViewModel *moviesViewModel;
@property (strong, nonatomic) FavoritesViewModel *favoriteViewModel;

@property(strong, nonatomic) NSMutableArray<NSIndexPath *> *likedCellIndexPaths;
@property (nonatomic) BOOL isRefreshing;
@property(strong, nonatomic) id<AlertManagerDelegate> alertManager;
@end

@implementation MovieListViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    [self layout];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData];
}

#pragma mark - API



#pragma mark - Layout
-(void) layout{
    [self.view addSubview:self.tableView];
}

#pragma mark - Action
-(void) didRefreshed: (UIRefreshControl *) sender{
    self.isRefreshing = true;
    [self.delegate didRefreshControlCalled];
}

#pragma mark - Instance Helpers
- (void)reloadData{
    [self.likedCellIndexPaths removeAllObjects];
    [self.tableView reloadData];
}

- (void)loadViewModel:(MoviesViewModel *)viewModel{
    self.moviesViewModel = viewModel;
}

- (void)endRefreshing{
    if (self.isRefreshing) {
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - Helpers

-(void) setup{
    [self configRereshControl];
    [self configTableView];
    
    self.isRefreshing = false;
    
    [self configFavoriteViewModel];
    
    self.likedCellIndexPaths = [[NSMutableArray alloc] init];
    
    [self configAlertManager];
}

-(void) configFavoriteViewModel{
    self.favoriteViewModel = [[FavoritesViewModel alloc] init];
}

-(void) postNotificationWhenLikeButtonTapped{
    [[NSNotificationCenter defaultCenter] postNotificationName:LikeButtonTappedNotification object:nil];
}

-(void) postNotificationWhenUnlikeButtonTapped{
    [[NSNotificationCenter defaultCenter] postNotificationName:UnlikeButtonTappedNotification object:nil];
}

-(void) configTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:[MovieListViewCell getNibName] bundle:nil] forCellReuseIdentifier:[MovieListViewCell getReuseIdentifier]];
    
    self.tableView.rowHeight = 150.0;
    
    [self.tableView addSubview:self.refreshControl];
}

-(void) configRereshControl{
    self.refreshControl = [[UIRefreshControl alloc] init];
    NSAttributedString *attrs = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [self.refreshControl setAttributedTitle:attrs];
    [self.refreshControl addTarget:self action:@selector(didRefreshed:) forControlEvents:UIControlEventValueChanged];
}

-(void) configAlertManager{
    self.alertManager = [[AlertManager alloc] init];
}

#pragma mark - Core Data
-(void) insertNewFavoriteMovie: (Movie *)movie{
    [self.favoriteViewModel insertMovieToCoreDataWithMovie:movie withSuccess:^{
    
        //send insert noti to FavoriteVC to reload view
        [self postNotificationWhenLikeButtonTapped];
        
    } withError:^(NSError * _Nonnull error) {
        [self.alertManager showErrorMessageWithDescription:[error localizedDescription] inVC:self withSelection:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

-(void) deleteExistFavorite: (Movie *)movie{
    [self.favoriteViewModel deleteMovieFromCoreDataWithMovie:movie withSuccess:^{
        //send unlike noti
        [self postNotificationWhenUnlikeButtonTapped];
    } withError:^(NSError * _Nonnull error) {
        [self.alertManager showErrorMessageWithDescription:[error localizedDescription] inVC:self withSelection:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}
#pragma mark - Delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat height = scrollView.frame.size.height;
    //load to the end
    if (offsetY > contentHeight - height) {
        [self.delegate scrollViewDidEndDragging];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Movie *movie = [self.moviesViewModel didSelectRowAtIndexPath:indexPath];
    if (movie!=nil) {
        [self.delegate didCellSelected:movie];
    }

}

- (void)didLikeButtonTapped:(UITableViewCell *)cell{
    MovieListViewCell *movieListCell = (MovieListViewCell *)cell;
    
    Movie *movie = [movieListCell getMovie];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if ([self.likedCellIndexPaths containsObject: indexPath]) {
        //check if cell selected, it will be removed from array (toggle click)
        [self.likedCellIndexPaths removeObject:indexPath];
        
        [self deleteExistFavorite:movie];
    }else{
        //set selected button image by indexpath becasue table will deque whenever scroll -> save selected cell indexpath in VC
        [self.likedCellIndexPaths addObject:indexPath];
        
        //insert new movie to core data
        [self insertNewFavoriteMovie: movie];
        
    }
}

#pragma mark - Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    __weak MovieListViewController *weakSelf = self;
    
    NSInteger sections = [weakSelf.moviesViewModel numberOfSectionsInTableView];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    __weak MovieListViewController *weakSelf = self;
    NSInteger rows = [weakSelf.moviesViewModel numberOfRowsInSection:section];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak MovieListViewController *weakSelf = self;
    Movie *movie = [weakSelf.moviesViewModel cellForRowAtIndexPath:indexPath];
   
    MovieListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MovieListViewCell getReuseIdentifier] forIndexPath:indexPath];
    
    [self insertNewIndexToSelectedIndexPathArray:indexPath withMovie:movie];
    
    [cell bindingData:movie];
    
    //populate button image by indexpaths array
    if ([_likedCellIndexPaths containsObject:indexPath]) {
        [cell changeImageButtonByFavorite:YES];
    }else{
        [cell changeImageButtonByFavorite:NO];
    }
    
    cell.delegate = self;
    
    return cell;
}

-(void) insertNewIndexToSelectedIndexPathArray: (NSIndexPath *)indexPath withMovie: (Movie *)movie{

    [self.favoriteViewModel checkIfMovieIsFavorite:movie withSuccess:^(BOOL isFavorited) {
        if (isFavorited && ![self.likedCellIndexPaths containsObject:indexPath]) {
            [self.likedCellIndexPaths addObject:indexPath];
        }
    } withError:^(NSError * _Nonnull error) {
        [self.alertManager showErrorMessageWithDescription:[error localizedDescription] inVC:self withSelection:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

@end
