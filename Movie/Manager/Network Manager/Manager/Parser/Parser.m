//
//  Parser.m
//  Movie
//
//  Created by AnhLe on 29/07/2022.
//

#import "Parser.h"
#import "Configs.h"
@implementation Parser

-(Movie *) initializeMovieObj: (NSDictionary *)item{
    NSInteger ID = [[item objectForKey:@"id"] intValue];
    NSString *title = [item objectForKey:@"title"];
    double vote_average = [[item objectForKey:@"vote_average"] doubleValue];
    NSString *release_date = [item objectForKey:@"release_date"];
    NSString *overview = [item objectForKey:@"overview"];
    
    
    NSString *poster_path = [self concatePosterPath:[item objectForKey:@"poster_path"]];
    Movie *movie = [[Movie alloc] initWithID:ID withOverview:overview withTitle:title withReleaseDate:release_date withVoteAverage:vote_average withPosterPath:poster_path];
    
    return movie;
}

-(Actor *) initializeActorMovieObj: (NSDictionary *) item{
    NSString *name = [item objectForKey:@"name"];
    NSString *profile_path = [self concatePosterPath:[item objectForKey:@"profile_path"]];
    
    Actor *actor = [[Actor alloc] initWithName:name withProfilePath:profile_path];
    return actor;
}

#pragma mark - ParserPopularMoviesProtocol
- (void)parserPopularMovies:(NSDictionary *)dict withSuccess:(void (^)(NSArray<Movie *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    if (!dict) {
    }
    NSArray *results = [dict objectForKey:@"results"];
    NSMutableArray<Movie *> *movies = [[NSMutableArray alloc] init];
    for(NSDictionary *item in results){
        Movie *movie = [self initializeMovieObj:item];
        [movies addObject:movie];
    }
    NSArray *arrayMovies = [[NSArray alloc] initWithArray:movies];
    successCompletion(arrayMovies);
}


#pragma mark - ParserCreditsMovieProtocol

-(NSString *) concatePosterPath: (NSString *)poster_path{
    NSString *posterURL = [NSString stringWithFormat:@"%@%@", ImageBaseDomain, poster_path];
    return posterURL;
}
- (void)parserCreditsMovies:(nonnull NSDictionary *)dict withSuccess:(nonnull void (^)(NSArray<Actor *> * _Nonnull))successCompletion withError:(nonnull void (^)(NSError * _Nonnull))errorCompletion {
    NSArray *casts = [dict objectForKey:@"cast"];
    NSMutableArray<Actor *> *actors = [[NSMutableArray alloc] init];
    for(NSDictionary *item in casts){
        Actor *actor = [self initializeActorMovieObj:item];
        [actors addObject:actor];
    }
    
    NSArray *arrayActors = [[NSArray alloc] initWithArray:actors];
    
    successCompletion(arrayActors);
}

@end
