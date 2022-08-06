//
//  EmailView.m
//  Movie
//
//  Created by AnhLe on 06/08/2022.
//

#import "EmailView.h"
@interface EmailView()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@end
@implementation EmailView
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

#pragma mark - Instance Helper

- (NSString *)getEmail{
    NSString *email = self.emailTextField.text;
    if (![email  isEqual: @""]) {
        return email;
    }
    return @"";
}

#pragma mark - Helper

-(void) customInit{
    [[NSBundle mainBundle] loadNibNamed:@"EmailView" owner:self options:nil];
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
}
#pragma mark - Instance Helper
-(void) bindingData:(NSString *) email{
    self.emailTextField.text = email;
}

@end
