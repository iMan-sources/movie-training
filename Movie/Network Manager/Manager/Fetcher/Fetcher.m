//
//  Fetcher.m
//  Movie
//
//  Created by AnhLe on 30/07/2022.
//

#import "Fetcher.h"
#import "NetworkManager.h"
@interface Fetcher()
@property(strong, nonatomic) NetworkManager *networkManager;
@property(strong, nonatomic) id<ParserPopularMoviesProtocol> popularMoviesParser;
@property(strong, nonatomic) id<ParserCreditsMovieProtocol> creditsMovieParser;
@end
@implementation Fetcher

- (instancetype)initWithParserPopularMovies:(id<ParserPopularMoviesProtocol>)parser{
    if (self = [super init]) {
        self.popularMoviesParser = parser;
        self.networkManager = [[NetworkManager alloc] init];
    }
    return self;
}

- (instancetype)initWithParserCreditsMovies:(id<ParserCreditsMovieProtocol>)parser{
    if (self = [super init]) {
        self.creditsMovieParser = parser;
        self.networkManager = [[NetworkManager alloc] init];
    }
    return self;
}
#pragma mark - ParserPopularMoviesProtocol
- (void)fetchPopularMoviesWithPage:(NSInteger)page withSucess:(void (^)(NSArray<Movie *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    __weak Fetcher *weakSelf = self;
    
    void(^networkResponse)(NSDictionary *) = ^(NSDictionary *dict){
        [weakSelf.popularMoviesParser parserPopularMovies:dict withSuccess:successCompletion withError:errorCompletion];
    };
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        [weakSelf.networkManager fetchPopularMoviesWithSuccess:page withSuccess:networkResponse error:errorCompletion];
    });
    
}

#pragma mark - ParserCreditsMovieProtocol
- (void)fetchCreditsMovieWithID:(NSInteger)movieId withSuccess:(void (^)(NSArray<Actor *> * _Nonnull))successCompletion withError:(void (^)(NSError * _Nonnull))errorCompletion{
    __weak Fetcher *weakSelf = self;
    
    void(^networkReponse)(NSDictionary *) = ^(NSDictionary *dict){
        [weakSelf.creditsMovieParser parserCreditsMovies:dict withSuccess:successCompletion withError:errorCompletion];
    };
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [weakSelf.networkManager fetchCreditsMovieWithSuccess:movieId withSuccess:networkReponse error:errorCompletion];
    });
}
@end
