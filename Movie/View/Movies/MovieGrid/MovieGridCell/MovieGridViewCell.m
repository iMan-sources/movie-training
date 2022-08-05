//
//  MovieGridViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import "MovieGridViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Images.h"
@interface MovieGridViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation MovieGridViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


+ (NSString *)getReuseIdentifier{
    return @"MovieGridViewCell";
}

+ (NSString *)getNibName{
    return @"MovieGridViewCell";
}

- (void)bindingData:(Movie *)movie{
    self.titleLabel.text = [movie getTitle];
    NSString *stringPosterURL = [movie getPosterURL];
    [self setPosterImageByURL:stringPosterURL];
}

-(void) setPosterImageByURL: (NSString *)stringPosterURL{
    NSURL *posterURL = [[NSURL alloc] initWithString:stringPosterURL];
    UIImage *placeholderImage = [Images getPlaceholderImage];
    [self.posterImageView sd_setImageWithURL:posterURL placeholderImage:placeholderImage options:SDWebImageContinueInBackground];
}




@end
