//
//  AvatarView.m
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import "AvatarView.h"

@interface AvatarView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarHeightContraint;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (copy, nonatomic) NSString *imagePath;
@end
@implementation AvatarView
#pragma mark - Init
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

-(void) customInit{
    [[NSBundle mainBundle] loadNibNamed:@"AvatarView" owner:self options:nil];
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    [self configAvatarView];
}
#pragma mark - Action
-(void) didAvatarImageViewTapped: (UITapGestureRecognizer *) sender{
    [self.delegate didAvatarViewTapped];
}
#pragma mark - Instance Helper
- (NSString *)getName{
    NSString *name = self.nameTextfield.text;
    return name;;
}

- (NSString *)getImagePath{
    return self.imagePath;
}

- (void)setAvatarImageViewUseInteraction:(BOOL)isInteract{
    [self.avatarImageView setUserInteractionEnabled:isInteract];
}

- (void)settingImageForAvatarImageView:(NSString *)urlImagePath{
    if (urlImagePath) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:urlImagePath]];
        if (image != nil) {
            self.imagePath = urlImagePath;
            self.avatarImageView.image = image;
        }
    }
}

#pragma mark - Helper
-(void) configAvatarView{
    self.avatarImageView.layer.cornerRadius = self.avatarHeightContraint.constant / 2;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didAvatarImageViewTapped:)];
    [self.avatarImageView addGestureRecognizer:tapGesture];
    self.nameTextfield.autocorrectionType = UITextAutocorrectionTypeNo;
    
}


-(void) configTextFieldWithBorderStyle: (UITextBorderStyle ) borderStyle withInteract: (BOOL) isInteract{
    [self.nameTextfield setBorderStyle:borderStyle];
    [self.nameTextfield setUserInteractionEnabled:isInteract];
}

- (void)bindingData:(User *)user{
    self.nameTextfield.text = [user getName];
    //get image
    
    NSString *urlImagePath = [user getImagePath];
    if (urlImagePath) {
        self.imagePath = urlImagePath;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:urlImagePath]];
        if (image != nil) {
            self.avatarImageView.image = image;
        }
    }
}

#pragma mark -Delegate

@end
