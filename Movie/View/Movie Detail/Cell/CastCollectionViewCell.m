//
//  CastCollectionViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 7/29/22.
//

#import "CastCollectionViewCell.h"
#import "Images.h"
#import "UIView+Extensions.h"
@interface CastCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *castImageView;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;

@end
@implementation CastCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (NSString *)getReuseIdentifier{
    return @"CastCollectionViewCell";
}

+ (NSString *)getNibName{

    return @"CastCollectionViewCell";
}

+ (CGFloat)getRowHeight{

    return 135;
}
- (void)bindingData:(Actor *)actor{
    NSString *name = [actor getName];
    self.castLabel.text = name;
    
    NSString *profileStringURL = [actor getProfilePath];
    
    [self setPosterImageByURL:profileStringURL inImageView:self.castImageView];
}
@end
