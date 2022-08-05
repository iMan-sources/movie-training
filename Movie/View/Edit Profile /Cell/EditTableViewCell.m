//
//  EditTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/5/22.
//

#import "EditTableViewCell.h"
@interface EditTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *contentEditableView;

@end
@implementation EditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (NSString *)getReuseIdentifier{
    return @"EditTableViewCell";
}

+(NSString *) getNibName{
    return @"EditTableViewCell";
}

-(void) bindingData: (User *)user withInforType: (InforProfileType)type{
    switch (type) {
        case birdthday:
        {
            self.contentEditableView.backgroundColor = [UIColor brownColor];
            break;
        }
        case email:
        {
            self.contentEditableView.backgroundColor = [UIColor cyanColor];
            break;
            
        }
        case gender:
        {
            self.contentEditableView.backgroundColor = [UIColor systemGreenColor];
            break;
            
        }
        default:
            break;
    }
}

@end
