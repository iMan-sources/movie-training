//
//  ReminderMovie.m
//  Movie
//
//  Created by AnhVT12.REC on 8/11/22.
//

#import "ReminderMovie.h"
@implementation ReminderMovie

- (instancetype)initWithTime:(NSDate *)time withMovie:(Movie *)movie{
    if (self = [super init]) {
        self.time = time;
        self.movie = movie;
    }
    return self;
}
@end
