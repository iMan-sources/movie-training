//
//  MoviesViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import "MoviesViewController.h"
#import "Images.h"
#import "ViewControllerIdentifiers.h"
#import "MovieGrid/MovieGridViewController.h"
#import "MovieGrid/MovieListViewController.h"
#import "Storyboard.h"
#import "UIViewController+Extensions.h"
#import "MoviesViewModel.h"
#import "MovieDetailViewController.h"
#import "ViewControllerIdentifiers.h"
#import "UIViewController+Extensions.h"
#import "NotificationNames.h"
#import "UserDefaultsNames.h"

typedef NS_ENUM(NSInteger, ContentDisplayState){
    tableView_state,
    collectionView_state
};

@interface MoviesViewController ()<MovieVCChildViewDelegate>
@property(strong, nonatomic) UIView *movieListView;
@property(strong, nonatomic) UIView *movieGridView;
@property(strong, nonatomic) MoviesViewModel *moviesViewModel;
//declare global movieListVC, movieGridVC to reloadData when call API
@property(strong, nonatomic) MovieListViewController *movieListVC;
@property(strong, nonatomic) MovieGridViewController *movieGridVC;
@property(nonatomic) ContentDisplayState displayState;
@property(nonatomic) NSInteger page;
@property (nonatomic) UIStoryboard *story;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigationBar];
    
    [self setup];
    
    [self fetchMovies];
    
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
   

}

#pragma mark - Action

-(void) didFilterTypeChanged: (NSNotification *)sender{
    //reload view, call api again
    [self.moviesViewModel resetArray];
    [self resetPage];
    [self fetchMovies];
}

-(void) didSortTypeChanged: (NSNotification *) sender{
    [self sortMovies];
}

-(void) didMovieRateSlided: (NSNotification *) sender{
//    NSLog(@"slide noti");
    [self filterMovies];

}

-(void) resetPage{
    self.page = 1;
    
}

-(void) didGridButtonTapped: (UIButton *) sender{
    NSLog(@"🛑 didGridButtonTapped");
    if (self.displayState == tableView_state) {
        self.displayState = collectionView_state;
        [self transitionFromViewToView:self.movieListView to:self.movieGridView];
        [self.navigationItem.rightBarButtonItem.customView setSelected:YES];
    }else{
        self.displayState = tableView_state;
        [self.navigationItem.rightBarButtonItem.customView setSelected:NO];
        [self transitionFromViewToView:self.movieGridView to:self.movieListView];
    }
}

#pragma mark - Navigation
-(void) configNavigationBar{
    self.tabBarItem.title = @"Movies";
    self.navigationItem.title = @"Popular Movies";
    
    [self configLeftBarItemButtons];
    [self configRightBarItemButtons];
}

-(void) configRightBarItemButtons{
    UIButton *gridButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [gridButton setImage:[Images getGridMenuImage] forState:UIControlStateNormal];
    [gridButton setImage:[Images getListMenuImage] forState:UIControlStateSelected];

    [gridButton addTarget:self action:@selector(didGridButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [gridButton setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:gridButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}




#pragma mark - API
-(void) fetchMovies{
    __weak MoviesViewController *weakSelf = self;
    
    [self.moviesViewModel getMoviesWithPage:self.page withSucess:^{
        [weakSelf.movieListVC reloadData];
        [weakSelf.movieListVC endRefreshing];
        
        [weakSelf.movieGridVC reloadData];
        [weakSelf.movieGridVC endRefreshing];
    } withError:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

-(void) sortMovies{
    __weak MoviesViewController *weakSelf = self;
    [self.moviesViewModel sortMovieWithSuccess:^{
        [weakSelf.movieListVC reloadData];
        [weakSelf.movieGridVC reloadData];
    }];
}

-(void) filterMovies{
    __weak MoviesViewController *weakSelf = self;
    [self.moviesViewModel filterMoviesArrayWithSettingDefault:^{
        [weakSelf.movieListVC reloadData];
        [weakSelf.movieGridVC reloadData];
    }];
}
#pragma mark - Helpers

-(void) setup{
    [self configViewModel];
    self.page = 1;
    self.story = [UIStoryboard storyboardWithName:[Storyboard getStoryboardName] bundle:nil];
    self.displayState = tableView_state;
    [self configDefaultDisplayView];
    
    [self regsiterDidFilterTypeChangedNotification];
    [self registerDidSortTypeChangedNotification];
    [self registerDidMovieRateChangedNotification];
}

-(void) configViewModel{
    self.moviesViewModel = [[MoviesViewModel alloc] init];
}


-(void) configDefaultDisplayView{
    [self configMovieGridView];
    [self configMovieListView];
    
    [self.movieListView setFrame:self.view.bounds];
    [self.view addSubview:self.movieListView];
}

-(void) configMovieListView{
    self.movieListView = [[UIView alloc]init];
    self.movieListVC = (MovieListViewController *)[[MovieListViewController alloc]initWithNibName:@"MovieListViewController" bundle:nil];
    self.movieListVC.delegate = self;
    [self.movieListVC loadViewModel:self.moviesViewModel];
    
    [self bringVCToView:self.movieListVC withView:self.movieListView];
    
}

-(void) configMovieGridView{
    self.movieGridView = [[UIView alloc]init];
    self.movieGridVC = (MovieGridViewController *)[[MovieGridViewController alloc] initWithNibName:@"MovieGridViewController" bundle:nil];
    [self.movieGridVC loadViewModel:self.moviesViewModel];
    self.movieGridVC.delegate = self;
    [self bringVCToView:self.movieGridVC withView:self.movieGridView];
}

-(void) transitionFromViewToView: (UIView *)fromView to: (UIView *)toView{
    [fromView removeFromSuperview];
    [toView setFrame:self.view.bounds];
    [self.view addSubview:toView];
}

-(void) regsiterDidFilterTypeChangedNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFilterTypeChanged:) name:DidFilterTypeChangedNotification object:nil];
}

-(void) registerDidSortTypeChangedNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSortTypeChanged:) name:DidSortTypeChangedNotification object:nil];
}

-(void) registerDidMovieRateChangedNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMovieRateSlided:) name:DidMovieRateChangedNotification object:nil];
}



#pragma mark - MovieVCChildViewDelegate
- (void)scrollViewDidEndDragging{
    if ([self.moviesViewModel checkHaveMoreMovies]) {
        self.page += 1;
        [self fetchMovies];
    }
}

- (void)didRefreshControlCalled{
    if ([self.moviesViewModel checkHaveMoreMovies]) {
        self.page += 1;
        [self fetchMovies];
    }
}

- (void)didCellSelected:(Movie *)movie{
    NSString *movieDetailIdentifier = [ViewControllerIdentifiers getMovieDetailVCIdentifier];
    MovieDetailViewController *movieDetailVC = [self.story instantiateViewControllerWithIdentifier: movieDetailIdentifier];
    [movieDetailVC loadMovieData:movie];
    
    [self.navigationController pushViewController:movieDetailVC animated:true];
}

@end
