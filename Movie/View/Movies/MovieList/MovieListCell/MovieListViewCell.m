//
//  MovieTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "MovieListViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Extensions.h"
#import "Images.h"
#import "FavoritesViewModel.h"
@interface MovieListViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (strong, nonatomic) FavoritesViewModel *favoriteViewModel;
@property (nonatomic) BOOL isFavorited;

@property(strong, nonatomic) Movie *movie;
@end
@implementation MovieListViewCell

#pragma mark - Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.isFavorited = NO;
    [self setup];
    
}
#pragma mark - Class Helper

+(NSString *) getReuseIdentifier{
    return @"MovieListViewCell";
}

+(NSString *) getNibName{
    return @"MovieListViewCell";
}

#pragma mark - Instance Helper
- (void)bindingData:(Movie *)movie;{
    self.movie = movie;
    self.overviewLabel.text = [self.movie getOverview];
    self.titleLabel.text = [self.movie getTitle];
    NSString *stringPosterURL = [self.movie getPosterURL];
    [self setPosterImageByURL:stringPosterURL inImageView:self.posterImageView];
    
    NSString *releaseDate = [self.movie getReleaseDate];
    self.releaseDateLabel.attributedText = [self makeAttributedStringWithBase:@"Release" withRedString:releaseDate];
    
    NSString *vote = [NSString stringWithFormat:@"%@ / 10", [self.movie getVoteAverage]];
    self.ratingLabel.attributedText = [self makeAttributedStringWithBase:@"Rating" withRedString:vote];

}


- (Movie *)getMovie{
    return self.movie;
}

#pragma mark - Helper

-(void)setup{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configLikeButton];
    self.favoriteViewModel = [[FavoritesViewModel alloc] init];
}

-(void) configLikeButton{
    [self.likeButton addTarget:self action:@selector(didLikeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.likeButton setImage:[Images getStarImage] forState:UIControlStateNormal];

    
}

- (void)changeImageButtonByFavorite:(BOOL)isFavorited{
    if (isFavorited) {
        [self.likeButton setImage:[Images getFilledStar] forState:UIControlStateNormal];
        return;
    }
    [self.likeButton setImage:[Images getStarImage] forState:UIControlStateNormal];
}

#pragma mark - Action

-(void) didLikeButtonTapped: (UIButton *) sender{
    [self.delegate didLikeButtonTapped:(MovieListViewCell *) self];
    if ([self.likeButton.imageView.image isEqual:[Images getStarImage]]) {
        [self.likeButton setImage:[Images getFilledStar] forState:UIControlStateNormal];
    }else{
        [self.likeButton setImage:[Images getStarImage] forState:UIControlStateNormal];
    }
}

@end
