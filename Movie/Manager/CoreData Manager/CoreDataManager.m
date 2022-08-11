//
//  CoreDataManager.m
//  Movie
//
//  Created by AnhVT12.REC on 8/2/22.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"

#import <UIKit/UIKit.h>
@interface CoreDataManager()
@property(strong, nonatomic) NSArray<MovieCD *> *movies;
@property(strong, nonatomic) NSArray<Reminder *> *reminders;
@property(strong, nonatomic) NSManagedObjectContext *context;
@property(weak, nonatomic) AppDelegate *delegate;
@end
@implementation CoreDataManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.movies = @[];
        self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.context = self.delegate.persistentContainer.viewContext;
    }
    return self;
}
#pragma mark - FILTER request
-(void) filterFavoriteMovieWithIDWithSuccess: (NSInteger)movieID withSuccess: (void(^)(MovieCD *))successCompletion withError: (void(^)(NSError *)) errorCompletion{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"MovieCD"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"movieID == %d",movieID];
    req.predicate = predicate;
    
    NSError *error = nil;
    NSArray<MovieCD *> *movies = [self.context executeFetchRequest:req error:&error];
    if (error != nil) {
        errorCompletion(error);
        return;
    }
    if (movies.count > 0 ) {
        successCompletion(movies[0]);
        return;
    }
    successCompletion(nil);
}

-(void) filterReminderWithMovieIDWithSuccess: (NSInteger)movieID withSuccess: (void(^)(Reminder *))successCompletion withError: (void(^)(NSError *)) errorCompletion{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Reminder"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"movieID == %d", movieID];
    req.predicate = predicate;
    
    NSError *error = nil;
    NSArray<Reminder *> *reminders = [self.context executeFetchRequest:req error: &error];
    if (error != nil) {
        errorCompletion(error);
        return;
    }
//    [reminders enumerateObjectsUsingBlock:^(Reminder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@", obj.time);
//    }];
    
    if (reminders.count > 0) {
        successCompletion(reminders[0]);
        return;
    }
    
    successCompletion(nil);
    
}
-(void) filterMovieWithName: (NSString *)movieName withSuccess: (void(^)(NSArray<MovieCD *> *)) successCompletion withError: (void(^)(NSError *)) errorCompletion{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"MovieCD"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN title", movieName];
    req.predicate = predicate;
    
    NSError *error = nil;
    NSArray<MovieCD *> *result = [self.context executeFetchRequest:req error:&error];
    if (error != nil) {
        errorCompletion(error);
        return;
    }
    successCompletion(result);
}

-(void)checkIfMovieIsFavorite: (Movie *) movie withSuccess: (void(^)(BOOL))successCompletion withError: (void (^)(NSError * _Nonnull))errorCompletion{
    NSInteger movieID = [movie getID];
    [self filterFavoriteMovieWithIDWithSuccess:movieID withSuccess:^(MovieCD * movie) {
        if (movie == nil) {
            successCompletion(NO);
        }else{
            successCompletion(YES);
        }
    } withError:^(NSError * error) {
        errorCompletion(error);
    }];
}
- (void)checkIfMovieHaveReminder:(Movie *)movie withSuccess:(void (^)(NSDate * _Nullable))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    NSInteger movieID = [movie getID];
   
    [self filterReminderWithMovieIDWithSuccess:movieID withSuccess:^(Reminder * reminder) {
        if (reminder != nil) {
            NSDate *time = reminder.time;
            NSLog(@"%@ time", time);
            successCompletion(time);
        }else{
            successCompletion(nil);
        }
    } withError:errorCompletion];
}

#pragma mark - GET request

- (void)fetchFavoriteMoviesWithSuccess:(void (^)(NSArray<MovieCD *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:@"MovieCD"];
    NSError *error = nil;
    NSArray<MovieCD *> *movies = [self.context executeFetchRequest:fetchReq error: &error];
    if (error != nil) {
        errorCompletion(error);
    }
    
    self.movies = movies;
    
    successCompletion(movies);
}

- (void)fetchReminderWithSuccess:(void (^)(NSArray<Reminder *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:@"Reminder"];
    NSError *error = nil;
    NSArray<Reminder *> *reminders = [self.context executeFetchRequest:fetchReq error: &error];
    if (error != nil) {
        errorCompletion(error);
    }
    
    self.reminders = reminders;
    successCompletion(reminders);
}

#pragma mark - CREATE request
- (void)insertToCoreDataWithMovie:(Movie *)movie withSuccess:(void (^)(void))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    MovieCD *newMovie = [[MovieCD alloc] initWithContext:self.context];
    newMovie.title = [movie getTitle];
    newMovie.movieID = (int)[movie getID];
    newMovie.overview = [movie getOverview];
    newMovie.poster_path = [movie getPosterURL];
    newMovie.release_date = [movie getReleaseDate];
    newMovie.vote_average = [[movie getVoteAverage] doubleValue];
    NSError *error = nil;
    
    [self.context save: &error];
    if (error != nil) {
        errorCompletion(error);
        return;
    }
    successCompletion();
}

-(void) insertToCoreDataWithReminder: (Movie *)movie withTime: (NSDate *)time withSuccess: (void(^)(void)) successCompletion withError: (void(^)(NSError *)) errorCompletion{
    Reminder *reminder = [[Reminder alloc] initWithContext:self.context];
    reminder.time = time;
    reminder.movieID = (int)[movie getID];
    
    NSError *error = nil;
    
    [self.context save: &error];
    if (error != nil) {
        errorCompletion(error);
        return;
    }
    
    successCompletion();
}



#pragma mark - DELETE request
- (void)deleteAllMoviesInCoreDataWithSuccess:(void (^)(void))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"MovieCD"];
    
    NSError *error = nil;
    NSArray<MovieCD *> *movies = [self.context executeFetchRequest:request error: &error];
    if (error != nil) {
        errorCompletion(error);
        return;
    }
    for(MovieCD *movieCD in movies){
        [self.context deleteObject:movieCD];
        [self.context save: &error];
    }
    if (error != nil) {
        errorCompletion(error);
        return;
    }
    
    successCompletion();
}

//[DELETE OBJECT]
- (void)deleteFromCoreDataWithMovie:(Movie *)movie withSuccess:(void (^)(void))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    NSInteger movieID = [movie getID];
    [self filterFavoriteMovieWithIDWithSuccess:movieID withSuccess:^(MovieCD *movieCD){
        [self.context deleteObject:movieCD];
        NSError *error = nil;
        [self.context save:&error];
        if (error != nil) {
            errorCompletion(error);
            return;
        }
        
        successCompletion();
    } withError:^(NSError * error) {
        errorCompletion(error);
    }];
}



@end
