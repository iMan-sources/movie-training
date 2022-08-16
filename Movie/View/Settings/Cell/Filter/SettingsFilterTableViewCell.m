//
//  SettingsTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import "SettingsFilterTableViewCell.h"
@interface SettingsFilterTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@end
@implementation SettingsFilterTableViewCell
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

+ (NSString *)getReuseIdentifer{
    return @"SettingsFilterTableViewCell";
}

+ (NSString *)getNibName{
    return @"SettingsFilterTableViewCell";
}

+ (CGFloat)getRowHeight{
    return 40.0;
}

#pragma mark - Helper

- (void)setup{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configSelectedImage];
}

- (void)configSelectedImage{
    [self.selectedImage setHidden:YES];
}

- (void)bindingData:(NSString *)content{
    self.titleLabel.text = content;
}

- (void)setCheckImageDisplayHidden:(BOOL)isHidden{
    [self.selectedImage setHidden:isHidden];
}

@end
