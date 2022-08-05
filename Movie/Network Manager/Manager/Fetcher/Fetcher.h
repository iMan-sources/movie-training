//
//  Fetcher.h
//  Movie
//
//  Created by AnhLe on 30/07/2022.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FetcherPopularMoviesProtocol <NSObject>

-(void)fetchPopularMoviesWithPage: (NSInteger)page withSucess: (void(^)(NSArray<Movie *> *))successCompletion withError: (void(^)(NSError *)) errorCompletion;

@end

@protocol FetcherCreditsMovieProtocol <NSObject>

-(void) fetchCreditsMovieWithID: (NSInteger)movieId withSuccess: (void(^)(NSArray<Actor *> *))successCompletion withError: (void(^)(NSError *)) errorCompletion;

@end
@interface Fetcher : NSObject<FetcherPopularMoviesProtocol, FetcherCreditsMovieProtocol>
-(instancetype) initWithParserPopularMovies: (id<ParserPopularMoviesProtocol>) parser;
-(instancetype) initWithParserCreditsMovies: (id<ParserCreditsMovieProtocol>) parser;
@end

NS_ASSUME_NONNULL_END
