//
//  Movie.m
//  Movie
//
//  Created by AnhVT12.REC on 7/29/22.
//

#import "Movie.h"
#import "NSString+Extensions.h"

@interface Movie()
@property(nonatomic) NSInteger ID;
@property(copy, nonatomic) NSString *overview;
@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *release_date;
@property(nonatomic) double vote_average;
@property(copy, nonatomic) NSString *poster_path;
@end
@implementation Movie

- (instancetype)initWithID:(NSInteger)ID withOverview:(NSString *)overview withTitle:(NSString *)title withReleaseDate:(NSString *)release_date withVoteAverage:(double)vote_average withPosterPath:(NSString *)poster_path{
    if (self = [super init]) {
        self.title = title;
        self.ID = ID;
        self.release_date = release_date;
        self.vote_average = vote_average;
        self.overview = overview;
        self.poster_path = poster_path;
    }
    return self;
}

- (instancetype)initWithMovieInCoreData:(MovieCD *)movieInCoreData{
    if (self = [super init]) {
        self.title = movieInCoreData.title;
        self.ID = movieInCoreData.movieID;
        self.release_date = movieInCoreData.release_date;
        self.vote_average = movieInCoreData.vote_average;
        self.overview = movieInCoreData.overview;
        self.poster_path = movieInCoreData.poster_path;
    }
    return self;
}



- (void)printOut{
    NSLog(@"id: %ld", (long)self.ID);
    NSLog(@"title: %@", self.title);
    NSLog(@"release_date: %@", self.release_date);
    NSLog(@"vote_average: %f", self.vote_average);
    NSLog(@"overview: %@", self.overview);
    NSLog(@"poster_path: %@", self.poster_path);
    NSLog(@"----------------------------------------");
}

- (NSString *)getOverview{
    return self.overview;
}

- (NSInteger)getID{
    return self.ID;
}

- (NSString *)getTitle{
    return self.title;
}

- (NSString *)getPosterURL{
    return self.poster_path;
}

- (NSString *)getReleaseDate{
    return self.release_date;
}

- (NSString *)getVoteAverage{
    NSString *vote = [NSString stringWithFormat:@"%.1f", self.vote_average];
    return vote;
}
@end
