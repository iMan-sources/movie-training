//
//  MovieGridViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import "MovieGridViewController.h"
#import "MovieGridCell/MovieGridViewCell.h"
@interface MovieGridViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property(strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) MoviesViewModel *moviesViewModel;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL isRefreshing;


@end

@implementation MovieGridViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Action
-(void) didRefreshed: (UIRefreshControl *) sender{
    self.isRefreshing = true;
    [self.delegate didRefreshControlCalled];
}


#pragma mark - Instance Helpers
- (void)reloadData{
    [self.collectionView reloadData];
}

- (void)loadViewModel:(MoviesViewModel *)viewModel{
    self.moviesViewModel = viewModel;
}

- (void)endRefreshing{
    if (self.isRefreshing) {
        [self.refreshControl endRefreshing];
    }

}

#pragma mark - Helper
-(void) setup{
    [self configRereshControl];
    self.isRefreshing = false;
    
    [self configCollectionView];

}

-(void) configRereshControl{
    self.refreshControl = [[UIRefreshControl alloc] init];
    NSAttributedString *attrs = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [self.refreshControl setAttributedTitle:attrs];
    [self.refreshControl addTarget:self action:@selector(didRefreshed:) forControlEvents:UIControlEventValueChanged];
}

-(void) configCollectionView{
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[self createTwoColumnInCollectionView]];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:[MovieGridViewCell getNibName] bundle:nil] forCellWithReuseIdentifier:[MovieGridViewCell getReuseIdentifier]];
    
    [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;

    [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
    
    [self.collectionView addSubview:self.refreshControl];

}
-(UICollectionViewFlowLayout *) createTwoColumnInCollectionView{
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGFloat padding = 12;
    CGFloat minimumItemSpacing = 10;
    CGFloat availableWidth = width - (padding * 2) - (minimumItemSpacing);
    CGFloat itemWidth = availableWidth / 2;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setSectionInset:UIEdgeInsetsMake(padding, padding, padding, padding)];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(itemWidth, itemWidth + 40)];
    
    return layout;
}

#pragma mark - Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSInteger sections = [self.moviesViewModel numberOfSectionsInCollectionView];
    return sections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger items = [self.moviesViewModel numberOfItemsInSection:section];
    return items;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat height = scrollView.frame.size.height;
    //load to the end
    if (offsetY > contentHeight - height) {
        NSLog(@"%f", offsetY);
        [self.delegate scrollViewDidEndDragging];
    }
}
#pragma mark - Datasource

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak MovieGridViewController *weakSelf = self;
    MovieGridViewCell *cell = (MovieGridViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[MovieGridViewCell getReuseIdentifier] forIndexPath:indexPath];
    Movie *movie = [weakSelf.moviesViewModel cellForItemAtIndexPath:indexPath];
    if (movie != nil) {
        [cell bindingData:movie];
    }
    return cell;
}



@end
