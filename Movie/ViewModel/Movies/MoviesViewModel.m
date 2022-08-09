//
//  MoviesViewModel.m
//  Movie
//
//  Created by AnhLe on 29/07/2022.
//

#import "MoviesViewModel.h"
#import "NetworkManager.h"
#import "Fetcher.h"
#import "FavoritesViewModel.h"
#import <UIKit/UIKit.h>
#import "SettingsViewModel.h"
#import "UserDefaultsNames.h"
#import "NSString+Extensions.h"
#import "NSDate+Extensions.h"
static NSInteger const itemsInPage = 20;

@interface MoviesViewModel()
@property(strong, nonatomic) id<FetcherMoviesProtocol> fetcherPopularMovies;
@property(strong, nonatomic) NSMutableArray<Movie *> *movies;
@property(nonatomic) SortType sortType;
@property(nonatomic) BOOL isHasMoreMovies;
@property(nonatomic) double movieRate;
@property(nonatomic, strong) NSDate *year;
@property(strong, nonatomic) NSArray<Movie *> *filteredArray;
@property(nonatomic) BOOL isFiltered;

@end
@implementation MoviesViewModel

- (instancetype)init{
    if (self = [super init]) {
        self.fetcherPopularMovies = [[Fetcher alloc] initWithParserPopularMovies:[[Parser alloc] init]];
        self.isHasMoreMovies = true;
        self.movies = [[NSMutableArray alloc] init];
        self.filteredArray = @[];
        
        [self configSortType];
        [self configMovieRateFromUserDefault];
        [self configReleaseYearFromUserDefault];
    }
    return self;
}

- (void)getMoviesWithPage:(NSInteger)page withSucess:(void (^)(void))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    __weak MoviesViewModel *weakSelf = self;
    //    [self configSortType];
    [weakSelf.fetcherPopularMovies fetchMoviesWithPage:page withSucess:^(NSArray<Movie *> * _Nonnull movies) {
        
        [self.movies addObjectsFromArray:movies];
        
        [self filterMoviesArrayWithSettingDefault:^{
            [self sortMovieWithSuccess:successCompletion];
        }];

    } withError:errorCompletion];
}

-(void) sortMovieWithSuccess: (void(^)(void))completionHandler{
    [self configSortType];
    switch (self.sortType) {
        case releaseDate:
        {
            [self sortMoviesArrayByReleaseDate];
            break;
        }
        case rating:
        {
            [self sortMoviesArrayByRating];
            break;
        }
        default:
            break;
    }
    completionHandler();
}

-(void) sortMoviesArrayByReleaseDate{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"release_date"
                                                 ascending:NO];
    if (self.isFiltered) {
        self.filteredArray = [self.filteredArray sortedArrayUsingDescriptors:@[sortDescriptor]];
        return;
    }
    self.movies = [[NSMutableArray alloc] initWithArray:[self.movies sortedArrayUsingDescriptors:@[sortDescriptor]]];
}

-(void) sortMoviesArrayByRating{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"vote_average"
                                                 ascending:NO];
    if (self.isFiltered) {
        self.filteredArray = [self.filteredArray sortedArrayUsingDescriptors:@[sortDescriptor]];
        return;
    }
    self.movies = [[NSMutableArray alloc] initWithArray:[self.movies sortedArrayUsingDescriptors:@[sortDescriptor]]];
}

#pragma mark - TableView
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = self.isFiltered ? self.filteredArray.count : self.movies.count;
    NSLog(@"%ld rows", rows);
    return rows;
}

- (NSInteger)numberOfSectionsInTableView{
    return 1;
}

- (Movie *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    Movie *movie = self.isFiltered ? self.filteredArray[row] : self.movies[row];
    if (movie != nil) {
        return movie;
    }
    return nil;
}

#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView{
    return 1;
}

-(NSInteger )numberOfItemsInSection:(NSInteger)section{
    NSInteger rows = self.isFiltered ? self.filteredArray.count : self.movies.count;
    return rows;
}

-(Movie *)cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    Movie *movie = self.isFiltered ? self.filteredArray[row] : self.movies[row];
    if ( movie != nil) {
        return movie;
    }
    return nil;
}

-(BOOL) checkHaveMoreMovies{
    NSInteger size = self.movies.count;
    if (size < itemsInPage) {
        self.isHasMoreMovies = false;
    }
    return self.isHasMoreMovies;
}

-(Movie *)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    Movie *movie = self.isFiltered ? self.filteredArray[row] : self.movies[row];
    if (movie != nil) {
        return movie;
    }
    return nil;
}
#pragma mark - Helper
-(void) resetArray{
    [self.movies removeAllObjects];
}

-(void) configSortType{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger type = [[standardUserDefaults objectForKey: SortTypeUserDefaults] intValue];
    switch (type) {
        case releaseDate:
        {
            self.sortType = releaseDate;
            break;
        }
        case rating:
        {
            self.sortType = rating;
            break;
        }
        default:
            break;
    }
}
#pragma mark - User default
-(void) configMovieRateFromUserDefault{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    double rate = [[standardUserDefaults objectForKey: MovieRateUserDefaults] doubleValue];
    self.movieRate = rate;
    self.isFiltered = YES;
}

-(void) configReleaseYearFromUserDefault{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *year = [standardUserDefaults objectForKey: ReleaseYearUserDefaults];
    self.year = [year convertStringToYear];
}

-(void) filterMoviesArrayWithSettingDefault: (void(^)(void)) completionHandler{
    [self configMovieRateFromUserDefault];
    [self configReleaseYearFromUserDefault];
    
    self.filteredArray = [self.movies filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Movie *movie = (Movie *) evaluatedObject;
        double rate = [[movie getVoteAverage] doubleValue];
        NSDate *date = [[movie getReleaseDate] convertYYYYmmddToYYYY];

        return rate >= self.movieRate && [date isLaterThanOrEqualTo:self.year];
        
    }]];
    completionHandler();
}

@end
