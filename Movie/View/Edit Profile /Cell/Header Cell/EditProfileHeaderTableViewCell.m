//
//  EditProfileHeaderTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/5/22.
//

#import "EditProfileHeaderTableViewCell.h"
@interface EditProfileHeaderTableViewCell()
@property(strong, nonatomic) AvatarView *avatarView;
@property(strong, nonatomic) UIButton *cancelButton;
@property(strong, nonatomic) UIButton *doneButton;
@end
@implementation EditProfileHeaderTableViewCell

#pragma mark - Init

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        [self layout];
    }
    return self;
}

#pragma mark - Action
-(void) didCancelButtonTapped: (UIButton *)sender{
    [self.delegate didCancelButtonTapped];
}

-(void) didDoneButtonTapped: (UIButton *)sender{
    NSString *name = [self.avatarView getName];
    User *user = [[User alloc] initWithName:name withBirthday:[[NSDate alloc]init] withGender:@"" withImagePath:@"" withEmail:@""];
    [self.delegate didDoneButtonTapped:user];
}
#pragma mark - Instance Helper
- (void)bindingData:(User *)user{
    [self.avatarView bindingData:user];
}


#pragma mark - Helper
-(void) setup{
    [self configAvatarView];
    [self configButtons];
}

-(void) configButtons{
    self.cancelButton = [self makeButtonWithText:@"CANCEL" withBackgroundColor:[UIColor systemCyanColor]];
    [self.cancelButton addTarget:self action:@selector(didCancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.doneButton = [self makeButtonWithText:@"DONE" withBackgroundColor:[UIColor systemBlueColor]];
    [self.doneButton addTarget:self action:@selector(didDoneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) layout{
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView addSubview:self.doneButton];
    //avatar view
    [self.avatarView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = true;
    [self.avatarView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = true;
    [self.avatarView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = true;
    [self.avatarView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = true;
    
    //cancel button
    [self.cancelButton.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = true;
    [self.cancelButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = true;
    
    //done button
    [self.doneButton.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = true;
    [self.doneButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = true;
}
-(void) configAvatarView{
    self.avatarView = [[AvatarView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.avatarView.translatesAutoresizingMaskIntoConstraints = false;
    [self.avatarView configTextFiledWithBorderStyle:UITextBorderStyleRoundedRect withInteract:YES];
    
}
+ (NSString *)getReuseIdentifier{
    return @"EditProfileHeaderTableViewCell";
}

+ (CGFloat)getHeaderHeight{
    return 150.0;
}


-(UIButton *) makeButtonWithText: (NSString *)text withBackgroundColor: (UIColor *)color{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:text forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    button.translatesAutoresizingMaskIntoConstraints = false;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    button.layer.cornerRadius = 5;
    [button.heightAnchor constraintEqualToConstant:30].active = true;
    [button.widthAnchor constraintEqualToConstant:70].active = true;
    
    return button;
}


@end
