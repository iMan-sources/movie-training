//
//  UIView+Extensions.h
//  Movie
//
//  Created by AnhVT12.REC on 8/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extensions)
-(NSMutableAttributedString *) makeAttributedStringWithBase: (NSString *)baseString withRedString: (NSString *) attrsString;
-(void) setPosterImageByURL: (NSString *)stringPosterURL inImageView: (UIImageView *) posterImageView;
@end


NS_ASSUME_NONNULL_END
