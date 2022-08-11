//
//  ReminderViewModel.m
//  Movie
//
//  Created by AnhLe on 11/08/2022.
//

#import "ReminderViewModel.h"
#import "Movie.h"
#import "CoreDataManager.h"
#import "Fetcher.h"
#import "ReminderMovie.h"

@interface ReminderViewModel()
@property(strong, nonatomic) NSMutableArray<ReminderMovie *> *reminderMovies;
@property(strong, nonatomic) CoreDataManager *coreDataManager;
@property(strong, nonatomic) id<FetcherMoviesProtocol> fetcherPopularMovies;
@end

@implementation ReminderViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.reminderMovies = [[NSMutableArray alloc] init];
        [self configCoreDataManager];
        self.fetcherPopularMovies = [[Fetcher alloc] initWithParserPopularMovies:[[Parser alloc] init]];
    }
    
    return self;
}

#pragma mark - CoreData
-(void) configCoreDataManager{
    self.coreDataManager = [[CoreDataManager alloc] init];
}

-(void) fetchRemindersInCoreDataWithSuccess: (void(^)(void)) completion withError: (void(^)(NSError *)) errorCompletion{
    dispatch_group_t group = dispatch_group_create();
    
    
    [self.coreDataManager fetchReminderWithSuccess:^(NSArray<Reminder *> * _Nonnull reminders) {
        [reminders enumerateObjectsUsingBlock:^(Reminder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_group_enter(group);
            NSInteger movieID = obj.movieID;
            NSDate *time = obj.time;
            //iterate reminders id
            
            //fetch movie by id
            [self searchMovieWithId:movieID withSuccess:^(Movie *movie)  {
                ReminderMovie *reminderMovie = [[ReminderMovie alloc] initWithTime:time withMovie:movie];
                [self.reminderMovies addObject:reminderMovie];
                dispatch_group_leave(group);
            } withError:^(NSError * error) {
                errorCompletion(error);
            }];
        }];
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            completion();
        });
        
    } withError:errorCompletion];
}

-(void) searchMovieWithId: (NSInteger) movieID withSuccess: (void(^)(Movie *)) successCompletion withError: (void(^)(NSError *)) errorCompletion{
    [self.fetcherPopularMovies fetchMovieWithID:movieID withSuccess:^(Movie * _Nonnull movie) {
        successCompletion(movie);
    } withError:^(NSError * _Nonnull error) {
        //handle error
        errorCompletion(error);
    }];
}

- (BOOL)checkIfHaveReminderList{
    BOOL haveReminderList = self.reminderMovies.count > 0;
    return haveReminderList;
}

#pragma mark - Delegate

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = self.reminderMovies.count;
    return rows;
}


- (NSInteger)numberOfSectionsInTableView{
    return 1;
}

#pragma mark - Datasource
- (ReminderMovie *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    ReminderMovie *reminderMovie = self.reminderMovies[row];

    return reminderMovie;
}
@end
