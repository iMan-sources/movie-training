//
//  RemindTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/10/22.
//

#import "RemindTableViewCell.h"
#import "NSString+Extensions.h"
#import "NSDate+Extensions.h"
#import "Images.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RemindTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *inforMovieLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end
@implementation RemindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setup];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Class Helper
+ (NSString *)getReuseIdentifier{
    return @"RemindTableViewCell";
}

+ (NSString *)getNibName{
    return @"RemindTableViewCell";
}

- (void)bindingData:(ReminderMovie *)reminderMovie{
    Movie *movie = reminderMovie.movie;
    NSString *fullInfor = [self concateAllInfor:movie];
    
    NSDate *date = reminderMovie.time;
    NSString *time = [date convertyyyyMMddHHMMToString];
    self.timeLabel.text = time;
    self.inforMovieLabel.text = fullInfor;
    [self setPosterImageByURL:[movie getPosterURL]];
    
}

- (NSString *)concateAllInfor:(Movie *)movie{
    NSString *title = [movie getTitle];
    NSString *voteString = [NSString stringWithFormat:@"%@/10", [movie getVoteAverage]];
    
    NSDate *date = [[movie getReleaseDate] convertStringToDate];
    
    NSString *year = [date convertYearToString];

    NSString *fullInfor = [NSString stringWithFormat:@"%@ - %@ - %@", title, year, voteString];
    
    return fullInfor;
}

- (void)setPosterImageByURL:(NSString *)stringPosterURL{
    NSURL *posterURL = [[NSURL alloc] initWithString:stringPosterURL];
    UIImage *placeholderImage = [Images getPlaceholderImage];
    [self.iconImageView sd_setImageWithURL:posterURL placeholderImage:placeholderImage options:SDWebImageContinueInBackground];
}

- (void)setup{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
