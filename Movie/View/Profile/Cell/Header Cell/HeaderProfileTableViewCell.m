//
//  HeaderProfileTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import "HeaderProfileTableViewCell.h"
#import "Avatar View/AvatarView.h"
@interface HeaderProfileTableViewCell()
@property(strong, nonatomic) AvatarView *avatarView;
@end

@implementation HeaderProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        [self layout];
    }
    return self;
}

#pragma mark - Class Helper
+ (NSString *)getReuseIdentifier{
    return @"HeaderProfileTableViewCell";
}

#pragma mark - Instance Helper


#pragma mark - Helper

- (void)setup{
    [self configAvatarView];

}

- (void)layout{
    
    [self.contentView addSubview:self.avatarView];
    [self.avatarView.topAnchor constraintEqualToAnchor:self.topAnchor].active= true;
    [self.avatarView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active= true;

    [self.avatarView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active= true;
    [self.avatarView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active= true;

}

- (void)configAvatarView{
    self.avatarView = [[AvatarView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.avatarView.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)bindingData:(User *)user{
    [self.avatarView bindingData:user];
    [self.avatarView configTextFieldWithBorderStyle:UITextBorderStyleNone withInteract:NO];
}

+ (CGFloat)getHeaderViewHeight{
    return 130.0;
}

@end
