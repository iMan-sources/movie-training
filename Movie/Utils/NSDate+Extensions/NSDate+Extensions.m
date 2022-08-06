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
@end
