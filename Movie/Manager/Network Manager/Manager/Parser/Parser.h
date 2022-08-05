//
//  Parser.h
//  Movie
//
//  Created by AnhLe on 29/07/2022.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "Actor.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ParserPopularMoviesProtocol <NSObject>

-(void) parserPopularMovies: (NSDictionary *)dict withSuccess: (void(^)(NSArray<Movie *> *)) successCompletion withError: (void(^)(NSError *)) errorCompletion;
@end

@protocol ParserCreditsMovieProtocol <NSObject>

-(void) parserCreditsMovies: (NSDictionary *)dict withSuccess: (void (^)(NSArray<Actor *> *)) successCompletion withError: (void(^)(NSError *)) errorCompletion;
@end

@interface Parser : NSObject<ParserPopularMoviesProtocol, ParserCreditsMovieProtocol>

@end

NS_ASSUME_NONNULL_END
