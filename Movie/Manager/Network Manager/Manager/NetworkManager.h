//
//  NetworkManager.h
//  Movie
//
//  Created by AnhVT12.REC on 7/29/22.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject
- (void)fetchMoviesWithSuccess:(NSInteger) page withSuccess:(void(^)(NSDictionary *))successCompletion error:(void(^)(NSError *error))errorCompletion;

- (void)fetchCreditsMovieWithSuccess:(NSInteger)movieId withSuccess:(void(^)(NSDictionary *))successCompletion error:(void(^)(NSError * error))errorCompletion;
- (void)searchMovieById:(NSInteger)movieID withSuccess:(void(^)(NSDictionary *))successCompletion error:(void(^)(NSError *))errorCompletion;
@end

NS_ASSUME_NONNULL_END
