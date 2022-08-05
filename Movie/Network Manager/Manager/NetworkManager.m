//
//  NetworkManager.m
//  Movie
//
//  Created by AnhVT12.REC on 7/29/22.
//

#import "NetworkManager.h"
#import "AFNetworking.h"
#import "Configs.h"
@interface NetworkManager()
@property(strong, nonatomic) AFHTTPSessionManager *networkManager;
@property(strong, nonatomic) AFJSONRequestSerializer *jsonSerializer;
@end
@implementation NetworkManager

#pragma mark - init
- (instancetype)init{
    if (self = [super init]) {
        self.networkManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.jsonSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

#pragma mark - [GET]


- (void)fetchPopularMoviesWithSuccess:(NSInteger)page withSuccess:(void (^)(NSDictionary * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion{
    NSString *popularStringURL = [NSString stringWithFormat:@"%@%@?api_key=%@&page=%ld",BaseDomain,PopularPath,BaseAPI,(long)page];
    
        self.networkManager.requestSerializer = self.jsonSerializer;
        [self.networkManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [self.networkManager GET:popularStringURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successCompletion(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorCompletion(error);
        }];
    
}

- (void)fetchCreditsMovieWithSuccess:(NSInteger)movieId withSuccess:(void (^)(NSDictionary * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion{
    NSString *creditsMovieStringURL = [NSString stringWithFormat:@"%@%ld/credits?api_key=%@", BaseDomain, (long)movieId, BaseAPI];
    self.networkManager.requestSerializer = self.jsonSerializer;
    [self.networkManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self.networkManager GET:creditsMovieStringURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successCompletion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorCompletion(error);
    }];
}
#pragma mark - [POST]


#pragma mark - [PUT]


#pragma mark - [DELETE]
@end
