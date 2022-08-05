//
//  NSString+Extensions.m
//  Movie
//
//  Created by AnhLe on 30/07/2022.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)
- (NSString *)convertDateFormatToString:(NSDate *)date{
    NSDate *dat = date;
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [fomatter stringFromDate:dat];
    NSLog(@"from ff%@", dateString);
    return dateString;
}
@end
