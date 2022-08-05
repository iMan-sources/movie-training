//
//  MovieDetailViewModel.m
//  Movie
//
//  Created by AnhVT12.REC on 8/1/22.
//

#import "MovieDetailViewModel.h"
#import "NetworkManager.h"
#import "Fetcher.h"
#import <UIKit/UIKit.h>

@interface MovieDetailViewModel()
@property(strong, nonatomic) NSArray<Actor *> *actors;
@property(strong, nonatomic) id<FetcherCreditsMovieProtocol> fetcher;
@end
@implementation MovieDetailViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.actors = [[NSArray alloc] init];
        self.fetcher = [[Fetcher alloc] initWithParserCreditsMovies:[[Parser alloc] init]];
    }
    return self;
}

- (void)getCreditsMovieWithMovieId:(NSInteger)movieId withSuccess:(void (^)(NSArray<Actor *> * _Nonnull))succesCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    __weak MovieDetailViewModel *weakSelf = self;
    
    [weakSelf.fetcher fetchCreditsMovieWithID:movieId withSuccess:^(NSArray<Actor *> * _Nonnull actors) {
        self.actors = actors;
        succesCompletion(actors);
    } withError:errorCompletion];
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section{
    NSInteger items  = self.actors.count;
    return items;
}

- (NSInteger)numberOfSectionsInCollectionView{
    return 1;
}

- (Actor *)cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    Actor *actor = self.actors[row];
    return actor;
}

@end
