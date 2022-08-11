//
//  Fetcher.h
//  Movie
//
//  Created by AnhLe on 30/07/2022.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FetcherMoviesProtocol <NSObject>

-(void)fetchMoviesWithPage: (NSInteger)page withSucess: (void(^)(NSArray<Movie *> *))successCompletion withError: (void(^)(NSError *)) errorCompletion;

-(void) fetchMovieWithID: (NSInteger) movieID withSuccess: (void(^)(Movie *)) successCompletion withError: (void(^)(NSError *)) errorCompletion;

@end

@protocol FetcherCreditsMovieProtocol <NSObject>

-(void) fetchCreditsMovieWithID: (NSInteger)movieId withSuccess: (void(^)(NSArray<Actor *> *))successCompletion withError: (void(^)(NSError *)) errorCompletion;

@end
@interface Fetcher : NSObject<FetcherMoviesProtocol, FetcherCreditsMovieProtocol>
-(instancetype) initWithParserPopularMovies: (id<ParserMoviesProtocol>) parser;
-(instancetype) initWithParserCreditsMovies: (id<ParserCreditsMovieProtocol>) parser;
@end

NS_ASSUME_NONNULL_END
