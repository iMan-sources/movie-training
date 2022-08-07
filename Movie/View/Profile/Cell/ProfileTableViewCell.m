//
//  ProfileTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import "ProfileTableViewCell.h"
@interface ProfileTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *inforImageView;
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;

@end

@implementation ProfileTableViewCell
#pragma mark - Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setup];
    [self layout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - Class Helper
+ (NSString *)getReuseIdentifier{
    return @"ProfileTableViewCell";
}

+ (NSString *)getNibName{
    return @"ProfileTableViewCell";
}

#pragma mark - Helper
-(void) setup{
    
}


-(void) layout{
    
}

- (void)bindingData:(NSString *)infor withImage: (UIImage *)image{
    self.inforLabel.text = infor;
    self.inforImageView.image = image;
}

@end
