//
//  ActionFooterTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/9/22.
//

#import "ActionFooterTableViewCell.h"
@interface ActionFooterTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation ActionFooterTableViewCell

#pragma mark - Init

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setup];
    [self layout];
}

#pragma mark - Class Helper

+ (NSString *)getNibName{
    return @"ActionFooterTableViewCell";
}

+ (NSString *)getReuseIdentifier{
    return @"ActionFooterTableViewCell";
}

#pragma mark - Helper
- (void)setup{
    [self configButtons];
}

- (void)layout{
    
}

- (void)configButtons{

    self.cancelButton.layer.cornerRadius = 10;
    self.cancelButton.clipsToBounds = YES;
    self.cancelButton.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMinXMaxYCorner;
    [self.cancelButton addTarget:self action:@selector(didCancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.selectButton.layer.cornerRadius = 10;
    self.selectButton.clipsToBounds = YES;
    self.selectButton.layer.maskedCorners = kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
    [self.selectButton addTarget:self action:@selector(didSelectButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - Action
- (void)didCancelButtonTapped:(UIButton *)sender{
    [self.delegate didCancelButtonTapped];
}
- (void)didSelectButtonTapped:(UIButton *)sender{
    [self.delegate didSelectButtonTapped];
}


@end
