//
//  SettingsRateConditionTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import "SettingsRateConditionTableViewCell.h"
#import "SettingsViewModel.h"
@interface SettingsRateConditionTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UISlider *sliderRating;
@property (strong, nonatomic) SettingsViewModel *settingsViewModel;
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
- (void)bindingData:(NSString *)content withRating: (double)rating{
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", rating];
    self.titleLabel.text = content;
    self.sliderRating.value = rating;
}
-(void) setup{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configViewModel];
    [self configSlider];
}
-(void) configSlider{
    self.sliderRating.continuous = NO;
    [self.sliderRating addTarget:self action:@selector(didSliderDragged:) forControlEvents:UIControlEventValueChanged];
}

-(void) configViewModel{
    self.settingsViewModel = [[SettingsViewModel alloc] init];
}

#pragma mark - Action
-(void) didSliderDragged: (UISlider *) sender{
    double rate = sender.value;
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", rate];
    
    [self.settingsViewModel setMovieRatingInUserDefault:rate];
}

@end
