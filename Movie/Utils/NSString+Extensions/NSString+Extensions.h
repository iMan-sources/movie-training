//
//  NSString+Extensions.h
//  Movie
//
//  Created by AnhLe on 30/07/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extensions)
- (NSDate *)convertStringToDate;
- (NSDate *)convertStringToYear;
- (NSDate *)convertYYYYmmddToYYYY;
@end

NS_ASSUME_NONNULL_END
