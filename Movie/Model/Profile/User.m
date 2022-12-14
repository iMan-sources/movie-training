//
//  User.m
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import "User.h"
@interface User()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDate  *birthday;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *email;
@end

@implementation User

- (instancetype)initWithName:(NSString *)name withBirthday:(NSDate *)birthday withGender:(NSString *)gender withImagePath:(NSString *)imagePath withEmail: (NSString *) email{
    if (self= [super init]) {
        self.name = name;
        self.birthday = birthday;
        self.gender = gender;
        self.imagePath = imagePath;
        self.email = email;
    }
    return self;
}


- (void)setWithName:(NSString *)name{
    self.name = name;
}

- (void)setWithEmail:(NSString *)email{
    self.email = email;
}

- (void)setWithGender:(NSString *)gender{
    self.gender = gender;
}

- (void)setWithBirthday:(NSDate *)date;{
    self.birthday = date;
}

- (void)setWithImagePath:(NSString *)imagePath{
    self.imagePath = imagePath;
}

- (NSString *)getName{
    return self.name;
}


- (NSDate *)getBirthDay{
    return self.birthday;
}


- (NSString *)getGender{
    return self.gender;
}

- (NSString *)getImagePath{
    return self.imagePath;
}

- (NSString *)getEmail{
    return self.email;
}



- (void)printOut{
    NSLog(@"%@", self.name);
    NSLog(@"%@", self.birthday);
    NSLog(@"%@", self.gender);
    NSLog(@"%@", self.imagePath);
    NSLog(@"%@", self.email);
}

@end
