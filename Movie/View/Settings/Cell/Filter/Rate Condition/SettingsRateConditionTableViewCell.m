//
//  SettingsRateConditionTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import "SettingsRateConditionTableViewCell.h"
@interface SettingsRateConditionTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UISlider *sliderRating;
@end
@implementation SettingsRateConditionTableViewCell

#pragma mark - Init
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

+(NSString *) getReuseIdentifer{
    return @"SettingsRateConditionTableViewCell";
}
+(NSString *) getNibName{
    return @"SettingsRateConditionTableViewCell";
}
+(CGFloat) getRowHeight{
    return 60.0;
}

#pragma mark - Helper
- (void)bindingData:(NSString *)content{
    self.titleLabel.text = content;
}
-(void) setup{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}



@end
