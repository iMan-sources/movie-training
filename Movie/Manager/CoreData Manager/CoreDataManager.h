//
//  CoreDataManager.h
//  Movie
//
//  Created by AnhVT12.REC on 8/2/22.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

//search movies in coredata
-(void) filterMovieWithName: (NSString *)movieName withSuccess: (void(^)(NSArray<MovieCD *> *)) successCompletion withError: (void(^)(NSError *)) errorCompletion;

//fetch all fav movies in core data
- (void)fetchFavoriteMoviesWithSuccess:(void (^)(NSArray<MovieCD *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion;

//insert new movie to core data
-(void) insertToCoreDataWithMovie: (Movie *)movie withSuccess: (void(^)(void)) successCompletion withError: (void(^)(NSError *)) errorCompletion;

//delete all fav movies data
- (void)deleteAllMoviesInCoreDataWithSuccess:(void (^)(void))successCompletion withError:(void (^)(NSError *))errorCompletion;

//delete specific movie obj
-(void) deleteFromCoreDataWithMovie: (Movie *)movie withSuccess: (void (^)(void))successCompletion withError: (void (^)(NSError *))errorCompletion;

//check if movie is fav
-(void)checkIfMovieIsFavorite: (Movie *) movie withSuccess: (void(^)(BOOL))successCompletion withError: (void (^)(NSError * _Nonnull))errorCompletion;
@end

NS_ASSUME_NONNULL_END
