//
//  BirthdayView.m
//  Movie
//
//  Created by AnhLe on 06/08/2022.
//

#import "BirthdayView.h"
#import "NSDate+Extensions.h"
#import "NSString+Extensions.h"
@interface BirthdayView()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation BirthdayView
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

#pragma mark - Action
- (void)didDateLabelTapped:(UITapGestureRecognizer *)sender{
    [self.delegate didBirthdayLabelTapped];
}
#pragma mark - Instance Helper

- (void)bindingData:(NSDate *)birthday{
    NSString *birthdayString = [birthday convertDateToString];
    
    [self.dateLabel layoutIfNeeded];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dateLabel setText:birthdayString];
        
    });
}


- (NSDate *)getDate{
    NSString *dateString = self.dateLabel.text;
    NSDate *date = [dateString convertStringToDate];
    return date;
}

#pragma mark - Helper

- (void)customInit{
    [[NSBundle mainBundle] loadNibNamed:@"BirthdayView" owner:self options:nil];
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    [self addGestureToDateLabel];
}

- (void)addGestureToDateLabel{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDateLabelTapped:)];
    [self.dateLabel addGestureRecognizer:tapGesture];
    [self.dateLabel setUserInteractionEnabled:YES];
    
}

@end
