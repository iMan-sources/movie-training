//
//  UIView+Extensions.m
//  Movie
//
//  Created by AnhVT12.REC on 8/1/22.
//

#import "UIView+Extensions.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Images.h"
@implementation UIView (Extensions)
-(NSMutableAttributedString *) makeAttributedStringWithBase: (NSString *)baseString withRedString: (NSString *) attrsString{
    
    NSMutableAttributedString *baseAttrsString = [[NSMutableAttributedString alloc] initWithString:baseString];
    NSDictionary *attrs = @{
        NSForegroundColorAttributeName: [UIColor systemRedColor]
    };
    NSAttributedString *redString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",attrsString] attributes:attrs];
    [baseAttrsString appendAttributedString:redString];
    
    return baseAttrsString;
}

-(void) setPosterImageByURL: (NSString *)stringPosterURL inImageView: (UIImageView *) posterImageView{
    NSURL *posterURL = [[NSURL alloc] initWithString:stringPosterURL];
    UIImage *placeholderImage = [Images getPlaceholderImage];
    [posterImageView sd_setImageWithURL:posterURL placeholderImage:placeholderImage options:SDWebImageContinueInBackground];
}
@end
