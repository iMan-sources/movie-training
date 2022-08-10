//
//  ProfileFooterTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import "ProfileFooterTableViewCell.h"
@interface ProfileFooterTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *footerButton;

@end
@implementation ProfileFooterTableViewCell
#pragma mark - Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self configFooterButton];
}


#pragma mark - Class Helper
+ (NSString *)getNibName{
    return @"ProfileFooterTableViewCell";
}

+ (NSString *)getReuseIdentifier{
    return @"ProfileFooterTableViewCell";
}

#pragma mark - Action
-(void) didFooterButtonTapped: (UIButton *)sender{
    NSInteger tag = sender.tag;
    NSLog(@"DID BUTTON TAPPED");
    [self.delegate didFooterButtonTapped:tag];
    return;
    
}

#pragma mark - Helper
- (void)bindingLabelButton:(NSString *)label{
    [self.footerButton setTitle:label forState:UIControlStateNormal];
}

-(void) configFooterButton{
    [self.footerButton addTarget:self action:@selector(didFooterButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) setButtonTag: (NSInteger) tag{
    self.footerButton.tag = tag;
}


@end
