//
//  Movie.h
//  Movie
//
//  Created by AnhVT12.REC on 7/29/22.
//

#import <Foundation/Foundation.h>
#import "MovieCD+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject
- (instancetype)initWithID:(NSInteger )ID withOverview:(NSString *)overview withTitle:(NSString *)title withReleaseDate:(NSString *)release_date withVoteAverage:(double)vote_average withPosterPath:(NSString *)poster_path;

- (instancetype)initWithMovieInCoreData:(MovieCD *)movieInCoreData;

- (void)printOut;

- (NSInteger)getID;
- (NSString *)getOverview;
- (NSString *)getTitle;
- (NSString *)getPosterURL;
- (NSString *)getVoteAverage;
- (NSString *)getReleaseDate;
@end


NS_ASSUME_NONNULL_END
