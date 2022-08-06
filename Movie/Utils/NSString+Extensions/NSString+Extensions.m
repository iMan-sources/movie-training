//
//  NSString+Extensions.m
//  Movie
//
//  Created by AnhLe on 30/07/2022.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

- (NSDate *)convertStringToDate{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [fomatter dateFromString:self];
    return date;
}

@end
