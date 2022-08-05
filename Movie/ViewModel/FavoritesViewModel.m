//
//  FavoritesViewModel.m
//  Movie
//
//  Created by AnhVT12.REC on 8/1/22.
//

#import "FavoritesViewModel.h"
#import "AppDelegate.h"
#import "Movie.h"
#import "MovieCD+CoreDataClass.h"
#import <UIKit/UIKit.h>
#import "CoreDataManager.h"
@interface FavoritesViewModel()
@property(strong, nonatomic) NSArray<Movie *> *movies;
@property(strong, nonatomic) CoreDataManager *coreDataManager;
@end

@implementation FavoritesViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.coreDataManager = [[CoreDataManager alloc] init];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView{
    NSInteger sections = 1;
    return sections;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = self.movies.count;
    return rows;
}

-(Movie *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    Movie *movie = self.movies[row];
    return movie;
}


-(NSArray<Movie *> *)convertMovieFromMovieCD: (NSArray<MovieCD *> *)movies{
    NSMutableArray *moviesArray = [[NSMutableArray alloc] init];
    [movies enumerateObjectsUsingBlock:^(MovieCD * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Movie *movie = [[Movie alloc] initWithMovieInCoreData:obj];
        [moviesArray addObject:movie];
    }];
    NSArray<Movie *> *res = [[NSArray alloc] initWithArray:moviesArray];
    return res;
}

#pragma mark - CoreData
//[SEARCH]
-(void) searchMoviesInCoreDataWithName: (NSString *)name withSuccess: (void(^)(void)) successCompletion withError: (void(^)(NSError *)) errorCompletion{
    [self.coreDataManager filterMovieWithName:name withSuccess:^(NSArray<MovieCD *> * _Nonnull movies) {
        NSArray<Movie *> *result =  [self convertMovieFromMovieCD:movies];
//        [result enumerateObjectsUsingBlock:^(Movie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj printOut];
//        }];
        self.movies = result;
        
        successCompletion();
    } withError:^(NSError * _Nonnull error) {
        errorCompletion(error);
    }];
}
//[FETCH]

- (void)getMovieFromCoreDataWithSuccess:(void (^)(NSArray<Movie *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    [self.coreDataManager fetchFavoriteMoviesWithSuccess:^(NSArray<MovieCD *> * _Nonnull movies) {
        self.movies = [self convertMovieFromMovieCD:movies];
        successCompletion(self.movies);
    } withError:errorCompletion];
}

//[CREATE]
- (void)insertMovieToCoreDataWithMovie:(Movie *)movie withSuccess:(void (^)(void))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    [self.coreDataManager insertToCoreDataWithMovie:movie withSuccess:^{
        successCompletion();
    } withError:errorCompletion];
}

//[DELETE]
- (void)deleteMovieFromCoreDataWithMovie:(Movie *)movie withSuccess:(void (^)(void))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    [self.coreDataManager deleteFromCoreDataWithMovie:movie withSuccess:successCompletion withError:errorCompletion];
}

//[DELETE ALL]
- (void)deleteAllMoviesFromCoreDataWithSuccess:(void (^)(void))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    [self.coreDataManager deleteAllMoviesInCoreDataWithSuccess:successCompletion withError:errorCompletion];
}

//check if movie is fav to choose image is suitable
- (void)checkIfMovieIsFavorite:(Movie *)movie withSuccess:(void (^)(BOOL))successCompetion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    [self.coreDataManager checkIfMovieIsFavorite:movie withSuccess:^(BOOL isFavorite) {
        successCompetion(isFavorite);
    } withError:^(NSError * _Nonnull error) {
        errorCompletion(error);
    }];
}

@end
