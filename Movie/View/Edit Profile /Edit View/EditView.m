//
//  EditView.m
//  Movie
//
//  Created by AnhVT12.REC on 8/5/22.
//

#import "EditView.h"
@interface EditView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *contentEditableView;

@end
@implementation EditView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}


-(void) customInit{
    [[NSBundle mainBundle] loadNibNamed:@"EditView" owner:self options:nil];
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
}

-(void) bindingData{
    
}

@end
