//
//  RemindTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/10/22.
//

#import "RemindTableViewCell.h"
@interface RemindTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *inforMovieLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end
@implementation RemindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

- (void)bindingData:(Movie *)movie{
    self.inforMovieLabel.text = [movie getTitle];
    
}

@end
