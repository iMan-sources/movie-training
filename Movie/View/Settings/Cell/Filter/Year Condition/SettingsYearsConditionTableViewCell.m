//
//  SettingsYearsConditionTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import "SettingsYearsConditionTableViewCell.h"
@interface SettingsYearsConditionTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end
@implementation SettingsYearsConditionTableViewCell

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
    return @"SettingsYearsConditionTableViewCell";
}
+(NSString *) getNibName{
    return @"SettingsYearsConditionTableViewCell";
}

+(CGFloat) getRowHeight{
    return 40.0;
}

#pragma mark - Helper
- (void)bindingData:(NSString *)content withReleaseYear:(int)year{
    self.titleLabel.text = content;
    NSString *yearTitle = [NSString stringWithFormat:@"%d", year];
    self.yearLabel.text = yearTitle;
}

-(void) setReleaseYearWhenPickerSelected: (NSString *) year{
    self.yearLabel.text = year;
}

-(void) setup{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configYearLabel];
}

-(void) configYearLabel{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didYearLabelTapped:)];
    [self.yearLabel setUserInteractionEnabled:YES];
    [self.yearLabel addGestureRecognizer:tapGesture];
    
}
#pragma mark - Action

-(void)didYearLabelTapped: (UITapGestureRecognizer *) sender{
    [self.delegate didYearLabelSelected];
}

@end
