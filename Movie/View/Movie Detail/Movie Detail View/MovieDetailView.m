//
//  MovieDetailView.m
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import "MovieDetailView.h"
#import "UIView+Extensions.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Extensions.h"
#import "NSDate+Extensions.h"
#import "Images.h"
@interface MovieDetailView()
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *reminderButton;
@property (weak, nonatomic) IBOutlet UILabel *reminderLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (weak, nonatomic) IBOutlet UILabel *contentOverviewLabel;
@property (strong, nonatomic) Movie *movie;
@end
@implementation MovieDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)bindingData:(Movie *)movie{
    NSString *releaseDate = [movie getReleaseDate];
    self.releaseLabel.attributedText = [self makeAttributedStringWithBase:@"Release: " withRedString:releaseDate];
    
    NSString *vote = [NSString stringWithFormat:@"%@ / 10", [movie getVoteAverage]];
    self.ratingLabel.attributedText = [self makeAttributedStringWithBase:@"Rating: " withRedString:vote];
    
    NSString *overview = [movie getOverview];
    self.contentOverviewLabel.text = [self generatingSpaceWhenOverviewEmptyWithOverview:overview];
    
    
    NSString *stringPosterURL = [movie getPosterURL];
    [self setPosterImageByURL:stringPosterURL inImageView:self.posterImageView];
    
}

-(void) addRemindLabel: (NSDate *) date{
    [self.reminderLabel setHidden:NO];
    //set text
    NSString *time = [date convertyyyyMMddHHMMToString];
    self.reminderLabel.text = time;
    
}

- (void)changeImageButtonByFavorite:(BOOL)isFavorited{
    if (isFavorited) {
        [self.likeButton setImage:[Images getFilledStar] forState:UIControlStateNormal];
        return;
    }
    [self.likeButton setImage:[Images getStarImage] forState:UIControlStateNormal];
}


-(void) customInit{
    [[NSBundle mainBundle] loadNibNamed:@"MovieDetailView" owner:self options:nil];
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    [self.reminderButton addTarget:self action:@selector(didReminderTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.reminderLabel setHidden:YES];
}

-(NSString *) generatingSpaceWhenOverviewEmptyWithOverview: (NSString *) overview{
    NSMutableString *spacing = [[NSMutableString alloc] initWithString:overview];
    for (int i = 0; i < 100; i++) {
        [spacing appendString:@" "];
    }
    NSString *res = [NSString stringWithString:spacing];
    return res;
    
}

-(void)didReminderTapped:(UIButton *)sender{
    [self.delegate didReminderTapped];
}

@end
