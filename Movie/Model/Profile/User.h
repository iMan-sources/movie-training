//
//  User.h
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
-(instancetype) initWithName: (NSString *)name withBirthday: (NSDate *)birthday withGender: (NSString *)gender withImagePath: (NSString *)imagePath withEmail: (NSString *) email;
-(void) printOut;

-(NSString *)getName;

-(NSDate *)getBirthDay;

-(NSString *)getGender;

-(NSString *)getImagePath;

-(NSString *)getEmail;
@end

NS_ASSUME_NONNULL_END
