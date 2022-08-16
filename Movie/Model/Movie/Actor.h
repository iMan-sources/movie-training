//
//  Actor.h
//  Movie
//
//  Created by AnhVT12.REC on 8/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Actor : NSObject
- (instancetype)initWithName:(NSString *)name withProfilePath:(NSString *)profilePath;

- (NSString *)getName;

- (NSString *)getProfilePath;

- (void)printOut;
@end

NS_ASSUME_NONNULL_END
