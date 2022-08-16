//
//  GenderView.m
//  Movie
//
//  Created by AnhLe on 06/08/2022.
//

#import "GenderView.h"
#import "Images.h"
@interface GenderView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidthConstraint;

@end
@implementation GenderView
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

- (void)customInit{
    [[NSBundle mainBundle] loadNibNamed:@"GenderView" owner:self options:nil];
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    [self configGenderView];
}
#pragma mark - Instance Helper
- (NSString *)getGender{
    if ([self.maleButton.imageView.image isEqual:[Images getFilledBlackRound]]) {
        return @"Male";
    }
    return @"Female";
}


#pragma mark - Helper
- (void)configGenderView{
    [self makeCornerButton:self.maleButton];
    [self makeCornerButton:self.femaleButton];
    
    [self.maleButton addTarget:self action:@selector(didMaleButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.femaleButton addTarget:self action:@selector(didFemaleButtonTapepd:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)makeCornerButton:(UIButton *)button{
    button.layer.cornerRadius = self.buttonWidthConstraint.constant / 2;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 2;
//    [button setImage:[UIImage alloc] forState:UIControlStateNormal];
    [button setImage:[Images getFilledBlackRound] forState:UIControlStateSelected];
    
}

- (void)bindingData:(NSString *)gender{
    if ([gender isEqual:@"Male"]) {
        [self.maleButton setImage:[Images getFilledBlackRound] forState:UIControlStateNormal];
        return;
    }
    [self.femaleButton setImage:[Images getFilledBlackRound] forState:UIControlStateNormal];
}
#pragma mark - Action
- (void)didMaleButtonTapped:(UIButton *)sender{
    if (![sender.imageView.image isEqual:[Images getFilledBlackRound]]) {
        [sender setImage:[Images getFilledBlackRound] forState:UIControlStateNormal];
        [self.femaleButton setImage:[Images getFilledWhiteRound] forState:UIControlStateNormal];
    }
}

- (void)didFemaleButtonTapepd:(UIButton *)sender{
    if (![sender.imageView.image isEqual:[Images getFilledBlackRound]]) {
        [sender setImage:[Images getFilledBlackRound] forState:UIControlStateNormal];
        [self.maleButton setImage:[Images getFilledWhiteRound] forState:UIControlStateNormal];
    }
}

@end
