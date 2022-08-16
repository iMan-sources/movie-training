//
//  FavoritesViewModel.h
//  Movie
//
//  Created by AnhVT12.REC on 8/1/22.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface FavoritesViewModel : NSObject
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSectionsInTableView;

- (Movie *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//fetch all fav movies in core data
- (void) getMovieFromCoreDataWithSuccess:(void(^)(NSArray<Movie *> *))successCompletion withError:(void(^)(NSError *))errorCompletion;

//insert new movie to core data
- (void)insertMovieToCoreDataWithMovie:(Movie *)movie withSuccess:(void(^)(void))successCompletion withError:(void(^)(NSError *))errorCompletion;

//delete all fav movies data
- (void)deleteMovieFromCoreDataWithMovie:(Movie *)movie withSuccess:(void(^)(void))successCompletion withError:(void(^)(NSError *))errorCompletion;

- (void)deleteAllMoviesFromCoreDataWithSuccess: (void(^)(void)) successCompletion withError: (void(^)(NSError *))errorCompletion;

//check If Movie Is Favorite
- (void)checkIfMovieIsFavorite:(Movie *)movie withSuccess:(void(^)(BOOL))successCompetion withError:(void(^)(NSError *))errorCompletion;

//search movies in coredata with name
- (void)searchMoviesInCoreDataWithName:(NSString *)name withSuccess:(void(^)(void))successCompletion withError:(void(^)(NSError *))errorCompletion;
@end

NS_ASSUME_NONNULL_END
