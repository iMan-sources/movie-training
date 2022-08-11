//
//  ReminderMovie.h
//  Movie
//
//  Created by AnhVT12.REC on 8/11/22.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReminderMovie : NSObject
@property(nonatomic, strong) NSDate *time;
@property(nonatomic, strong) Movie *movie;

-(instancetype) initWithTime: (NSDate *)time withMovie: (Movie *) movie;
@end

NS_ASSUME_NONNULL_END
