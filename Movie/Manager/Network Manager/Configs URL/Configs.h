//
//  Configs.h
//  Movie
//
//  Created by AnhVT12.REC on 7/29/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#pragma mark - URL Configs

static NSString * const BaseDomain = @"https://api.themoviedb.org/3/movie/";
static NSString * const BaseAPI = @"e7631ffcb8e766993e5ec0c1f4245f93";
static NSString * const PopularPath = @"popular";
static NSString * const TopRatedPath = @"top_rated";
static NSString * const UpComingPath = @"upcoming";
static NSString * const NowComingPath = @"now_playing";
static NSString * const ImageBaseDomain = @"https://image.tmdb.org/t/p/w200";
static NSString * const AboutURL = @"https://www.themoviedb.org/about";
@interface Configs : NSObject
@end

NS_ASSUME_NONNULL_END
