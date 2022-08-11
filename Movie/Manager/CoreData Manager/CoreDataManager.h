//
//  CoreDataManager.h
//  Movie
//
//  Created by AnhVT12.REC on 8/2/22.
//

#import <Foundation/Foundation.h>
#import "MovieCD+CoreDataClass.h"
#import "Reminder+CoreDataClass.h"
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

#pragma mark - Favorite Movies
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

#pragma mark - Reminder

//insert new movie to core data
-(void) insertToCoreDataWithReminder: (Movie *)movie withTime: (NSDate *)time withSuccess: (void(^)(void)) successCompletion withError: (void(^)(NSError *)) errorCompletion;

//fetch all fav movies in core data
- (void)fetchReminderWithSuccess:(void (^)(NSArray<Reminder *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion;

//check if movie have reminder
-(void)checkIfMovieHaveReminder: (Movie *) movie withSuccess: (void(^)(NSDate * _Nullable))successCompletion withError: (void (^)(NSError * _Nonnull))errorCompletion;


@end

NS_ASSUME_NONNULL_END
