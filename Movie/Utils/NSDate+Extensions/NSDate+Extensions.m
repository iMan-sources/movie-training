//
//  NSDate+Extensions.m
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)
- (NSString *)convertDateToString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:self];
    return date;
}

- (NSString *)convertYearToString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *date = [formatter stringFromDate:self];
    return date;
}

- (NSString *)convertyyyyMMddHHMMToString{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *date = [fomatter stringFromDate:self];
    return date;
}
- (BOOL)isLaterThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedAscending);
}

- (BOOL)isEarlierThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedDescending);
}
- (BOOL)isLaterThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedDescending);

}
- (BOOL)isEarlierThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedAscending);
}
@end
