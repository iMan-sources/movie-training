//
//  Actor.m
//  Movie
//
//  Created by AnhVT12.REC on 8/1/22.
//

#import "Actor.h"
@interface Actor()
@property(copy, nonatomic) NSString *name;
@property(copy, nonatomic, nullable) NSString *profile_path;
@end
@implementation Actor

- (instancetype)initWithName:(NSString *)name withProfilePath:(NSString *)profilePath{
    if (self = [super init]) {
        self.name = name;
        self.profile_path = profilePath;
    }
    return self;
}

- (NSString *)getProfilePath{
    return _profile_path;
}

- (NSString *)getName{
    return self.name;
}

- (void)printOut{
    NSLog(@"%@", self.name);
    NSLog(@"%@", self.profile_path);
}

@end
