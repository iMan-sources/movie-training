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

static NSInteger const itemsInPage = 20;

@interface MoviesViewModel()
@property(strong, nonatomic) id<FetcherPopularMoviesProtocol> fetcherPopularMovies;
@property(strong, nonatomic) NSMutableArray<Movie *> *movies;
@property(strong, nonatomic) NSArray<Movie *> *favoriteMovieArray;
@property(nonatomic) BOOL isHasMoreMovies;
@end
@implementation MoviesViewModel

- (instancetype)init{
    if (self = [super init]) {
        self.fetcherPopularMovies = [[Fetcher alloc] initWithParserPopularMovies:[[Parser alloc] init]];
        self.isHasMoreMovies = true;
        self.movies = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getPopularMoviesWithPage:(NSInteger)page withSucess:(void (^)(NSArray<Movie *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    __weak MoviesViewModel *weakSelf = self;
    
    [weakSelf.fetcherPopularMovies fetchPopularMoviesWithPage:page withSucess:^(NSArray<Movie *> * _Nonnull movies) {
        
        [self.movies addObjectsFromArray:movies];
        
        successCompletion(movies);
    } withError:errorCompletion];
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

@end
