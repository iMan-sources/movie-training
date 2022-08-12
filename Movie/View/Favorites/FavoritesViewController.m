//
//  FavoritesViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "FavoritesViewController.h"
#import "MovieListViewCell.h"
#import "FavoritesViewModel.h"
#import "AlertManager.h"
#import "NotificationNames.h"
#import "UIViewController+Extensions.h"
#import "ViewControllerIdentifiers.h"
#import "MovieDetailViewController.h"
#import "Storyboard.h"

@interface FavoritesViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *favoritesTableView;
@property (strong, nonatomic) UISearchController *searchController;
@property(strong, nonatomic) FavoritesViewModel *favoritesViewModel;
@property(strong, nonatomic) id<AlertManagerDelegate> alertManager;
@property (nonatomic,strong) UIStoryboard *story;
@end

@implementation FavoritesViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigationBar];
    
    [self setup];
    
    [self fetchFavoriteMovies];
    
}


#pragma mark - Navigation
-(void) configNavigationBar{
    [self configLeftBarItemButtons];
    self.navigationItem.title = @"Favorites";

}
#pragma mark - API

-(void) didLikeButtonTappedInMovieListVC: (NSNotification *) sender{
    [self fetchFavoriteMovies];
}

-(void) didDeleteButtonTappedInMovieListVC: (NSNotification *) sender{
    [self fetchFavoriteMovies];
}

#pragma mark - Helper
-(void) setup{
    
    [self configStoryboard];
    
    [self configViewModel];

    [self configFavoritesTableView];

    [self configAlertController];
   
}
-(void) configStoryboard{
    self.story = [UIStoryboard storyboardWithName:[Storyboard getStoryboardName] bundle:nil];
}
-(void) configAlertController{
    self.alertManager = [[AlertManager alloc] init];
}

-(void) configViewModel{
    self.favoritesViewModel = [[FavoritesViewModel alloc] init];
}

-(void) layout{
    
}

-(void) searchMovieWithName: (NSString *)movieName{
    __weak FavoritesViewController *weakSelf = self;
    [weakSelf.favoritesViewModel searchMoviesInCoreDataWithName:movieName withSuccess:^{
        [weakSelf.favoritesTableView reloadData];
    } withError:^(NSError * _Nonnull error) {
        [self.alertManager showErrorMessageWithDescription:[error localizedDescription] inVC:self withSelection:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

-(void) fetchFavoriteMovies{

    __weak FavoritesViewController *weakSelf = self;
    [weakSelf.favoritesViewModel getMovieFromCoreDataWithSuccess:^(NSArray<Movie *> * _Nonnull movies) {
        [weakSelf.favoritesTableView reloadData];
    } withError:^(NSError * _Nonnull error) {
        [self.alertManager showErrorMessageWithDescription:[error localizedDescription] inVC:self withSelection:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }];

}

-(void) configFavoritesTableView{
    self.favoritesTableView.delegate = self;
    self.favoritesTableView.allowsMultipleSelectionDuringEditing = false;

    self.favoritesTableView.dataSource = self;
    [self.favoritesTableView registerNib:[UINib nibWithNibName:[MovieListViewCell getNibName] bundle:nil] forCellReuseIdentifier:[MovieListViewCell getReuseIdentifier]];
    [self configSearchController];
    self.favoritesTableView.rowHeight = 150.0;
}

-(void) configSearchController{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.hidesNavigationBarDuringPresentation = false;
    [self.searchController.searchBar sizeToFit];
    self.favoritesTableView.tableHeaderView = self.searchController.searchBar;
    
}

-(void) registerLikeButtonTappedNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLikeButtonTappedInMovieListVC:) name:LikeButtonTappedNotification object:nil];
}

- (void)registerUnlikeButtonTappedNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDeleteButtonTappedInMovieListVC:) name:UnlikeButtonTappedNotification object:nil];
}

#pragma mark - Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = [self.favoritesViewModel numberOfSectionsInTableView];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = [self.favoritesViewModel numberOfRowsInSection:section];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieListViewCell *favoriteCell = [tableView dequeueReusableCellWithIdentifier:[MovieListViewCell getReuseIdentifier] forIndexPath:indexPath];

    Movie *movie = [self.favoritesViewModel cellForRowAtIndexPath:indexPath];
    
    [favoriteCell changeImageButtonByFavorite:YES];
    [favoriteCell setLikeButtonUserInteract:NO];
    
    [favoriteCell bindingData:movie];
    
    
    return favoriteCell;
}

#pragma mark - Delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    UITextField *tf =  searchController.searchBar.searchTextField;
    NSString *content = tf.text;
    if ([content isEqualToString:@""]) {
        //display all results
        [self fetchFavoriteMovies];
        return;
    }
    [self searchMovieWithName:content];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Movie *movie = [self.favoritesViewModel cellForRowAtIndexPath:indexPath];
    NSString *movieName = [movie getTitle];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //show alert
        [self.alertManager showRemoveMovieAlertWithName:movieName inVC: self withYesSelection:^{
            //do st if yes selected
            [self.favoritesViewModel deleteMovieFromCoreDataWithMovie:movie withSuccess:^{
                [self fetchFavoriteMovies];
            } withError:^(NSError * _Nonnull error) {
                [self.alertManager showErrorMessageWithDescription:[error localizedDescription] inVC:self withSelection:^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }];
        } withNoSelection:^{
            //do st if no selected
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //move vc to detail
    NSString *movieDetailIdentifier = [ViewControllerIdentifiers getMovieDetailVCIdentifier];
    MovieDetailViewController *movieDetailVC = [self.story instantiateViewControllerWithIdentifier: movieDetailIdentifier];
    Movie *movie = [self.favoritesViewModel cellForRowAtIndexPath:indexPath];
    [movieDetailVC loadMovieData:movie];
    
    [self.navigationController pushViewController:movieDetailVC animated:true];
}



@end
