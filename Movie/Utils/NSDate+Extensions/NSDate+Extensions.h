//
//  NSDate+Extensions.h
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extensions)
- (NSString *)convertDateToString;
- (NSString *)convertYearToString;
- (NSString *)convertyyyyMMddHHMMToString;
- (BOOL)isLaterThanOrEqualTo:(NSDate*)date;

- (BOOL)isEarlierThanOrEqualTo:(NSDate*)date;
- (BOOL)isLaterThan:(NSDate*)date;
- (BOOL)isEarlierThan:(NSDate*)date;

@end

NS_ASSUME_NONNULL_END
