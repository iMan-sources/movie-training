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
@interface ReminderViewModel()
@property(strong, nonatomic) NSArray<Movie *> *movie;
@property(strong, nonatomic) CoreDataManager *coreDataManager;
@property(strong, nonatomic) id<FetcherMoviesProtocol> fetcherPopularMovies;
@end

@implementation ReminderViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.movie = @[];
        [self configCoreDataManager];
        self.fetcherPopularMovies = [[Fetcher alloc] ini]
    }
    
    return self;
}

#pragma mark - CoreData
-(void) configCoreDataManager{
    self.coreDataManager = [[CoreDataManager alloc] init];
}

-(void) fetchRemindersInCoreDataWithSuccess: (void(^)(void)) completion withError: (void(^)(NSError *)) errorCompletion{
    
    [self.coreDataManager fetchReminderWithSuccess:^(NSArray<Reminder *> * _Nonnull reminders) {
        <#code#>
    } withError:errorCompletion];
}

-(void) 
@end
