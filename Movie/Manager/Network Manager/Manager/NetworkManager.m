//
//  NetworkManager.m
//  Movie
//
//  Created by AnhVT12.REC on 7/29/22.
//

#import "NetworkManager.h"
#import "AFNetworking.h"
#import "Configs.h"
#import "SettingsViewModel.h"
#import "UserDefaultsNames.h"
@interface NetworkManager()
@property(strong, nonatomic) AFHTTPSessionManager *networkManager;
@property(strong, nonatomic) AFJSONRequestSerializer *jsonSerializer;
@property (nonatomic) FilterType filterDefault;
@property(strong, nonatomic) NSString *mainURL;
@end
@implementation NetworkManager

#pragma mark - init
- (instancetype)init{
    if (self = [super init]) {
        self.networkManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.jsonSerializer = [AFJSONRequestSerializer serializer];
        self.filterDefault = popular;
        self.mainURL = [[NSString alloc] init];
    }
    
    return self;
}
-(void) routeURL{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger type = [[standardUserDefaults objectForKey: FilterTypeUserDefaults] intValue];
    switch (type) {
        case popular:
        {
            self.mainURL = [NSString stringWithFormat:@"%@%@?api_key=%@",BaseDomain,PopularPath,BaseAPI];
            break;
        }
        case topRated:
        {
            self.mainURL = [NSString stringWithFormat:@"%@%@?api_key=%@",BaseDomain,TopRatedPath,BaseAPI];
            break;
        }
        case upcoming:
        {
            self.mainURL = [NSString stringWithFormat:@"%@%@?api_key=%@",BaseDomain,UpComingPath,BaseAPI];
            break;
        }
        case nowPlaying:
        {
            self.mainURL = [NSString stringWithFormat:@"%@%@?api_key=%@",BaseDomain,NowComingPath,BaseAPI];
            break;
        }
    }
}
#pragma mark - [GET]


- (void)fetchMoviesWithSuccess:(NSInteger)page withSuccess:(void (^)(NSDictionary * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion{
    [self routeURL];
    NSString *fullURL = [NSString stringWithFormat:@"%@&page=%ld",self.mainURL,(long)page];
    
        self.networkManager.requestSerializer = self.jsonSerializer;
        [self.networkManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [self.networkManager GET:fullURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
