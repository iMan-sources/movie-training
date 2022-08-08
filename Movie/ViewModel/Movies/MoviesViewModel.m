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
static NSInteger const itemsInPage = 20;

@interface MoviesViewModel()
@property(strong, nonatomic) id<FetcherMoviesProtocol> fetcherPopularMovies;
@property(strong, nonatomic) NSMutableArray<Movie *> *movies;
@property(nonatomic) SortType sortType;
@property(nonatomic) BOOL isHasMoreMovies;
@end
@implementation MoviesViewModel

- (instancetype)init{
    if (self = [super init]) {
        self.fetcherPopularMovies = [[Fetcher alloc] initWithParserPopularMovies:[[Parser alloc] init]];
        self.isHasMoreMovies = true;
        self.movies = [[NSMutableArray alloc] init];
        [self configSortType];
    }
    return self;
}

- (void)getMoviesWithPage:(NSInteger)page withSucess:(void (^)(NSArray<Movie *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    __weak MoviesViewModel *weakSelf = self;
    [self configSortType];
    [weakSelf.fetcherPopularMovies fetchMoviesWithPage:page withSucess:^(NSArray<Movie *> * _Nonnull movies) {
        
        [self.movies addObjectsFromArray:movies];
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
        
        successCompletion(movies);
    } withError:errorCompletion];
}
-(void) sortMoviesArrayByReleaseDate{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"release_date"
                                               ascending:YES];
    self.movies = [[NSMutableArray alloc] initWithArray:[[[self.movies sortedArrayUsingDescriptors:@[sortDescriptor]] reverseObjectEnumerator] allObjects]];
}

-(void) sortMoviesArrayByRating{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"vote_average"
                                               ascending:YES];
    self.movies = [[NSMutableArray alloc] initWithArray:[self.movies sortedArrayUsingDescriptors:@[sortDescriptor]]];
    //reversed array
    self.movies = [[NSMutableArray alloc] initWithArray:[[[self.movies sortedArrayUsingDescriptors:@[sortDescriptor]] reverseObjectEnumerator] allObjects]];
    
}

#pragma mark - TableView
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = self.movies.count;
    return rows;
}

- (NSInteger)numberOfSectionsInTableView{
    return 1;
}

- (Movie *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    Movie *movie = self.movies[row];
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
    NSInteger rows = self.movies.count;
    
    return rows;
}

-(Movie *)cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    Movie *movie = self.movies[row];
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
    Movie *movie = self.movies[row];
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
@end
