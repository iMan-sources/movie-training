//
//  EditTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/5/22.
//

#import "EditTableViewCell.h"
#import "EmailView.h"
#import "GenderView.h"
@interface EditTableViewCell()<BirthdayViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *contentEditableView;
@property(strong, nonatomic) EmailView *emailView;
@property (strong, nonatomic) GenderView *genderView;
@property (strong, nonatomic) BirthdayView *birthdayView;
//@property(strong, nonatomic) UIToolbar *toolbar;
//@property(strong, nonatomic) UIDatePicker *datePicker;
@end
@implementation EditTableViewCell

#pragma mark - Init
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Class Helper


+ (NSString *)getReuseIdentifier{
    return @"EditTableViewCell";
}

+(NSString *) getNibName{
    return @"EditTableViewCell";
}
#pragma mark - Instance Helper

-(void) gettingDataWithInforType: (InforProfileType)type withUser: (User *)user{
    switch (type) {
        case birthday:
        {
            NSDate *date = [self.birthdayView getDate];
            [user setWithBirthday:date];
        }
        case email:
        {
            NSString *email = [self.emailView getEmail];
            [user setWithEmail:email];
            
        }
        case gender:
        {
            NSString *gender = [self.genderView getGender];
            [user setWithGender:gender];
        }
        default:
            break;
    }
}

-(void) bindingData: (User *)user withInforType: (InforProfileType)type withImage: (UIImage *)image{
    switch (type) {
        case birthday:
        {
            self.iconImageView.image = image;
            self.contentEditableView.backgroundColor = [UIColor clearColor];
            [self configBirthdayView];
            [self layoutChildView:self.birthdayView];
            [self.birthdayView bindingData:[user getBirthDay]];
            //config date picker
            
            break;
        }
        case email:
        {
            self.iconImageView.image = image;
            self.contentEditableView.backgroundColor = [UIColor clearColor];
            [self configEmailView];
            [self layoutChildView:self.emailView];
            [self.emailView bindingData:[user getEmail]];
            break;
            
        }
        case gender:
        {
            self.iconImageView.image = image;
            self.contentEditableView.backgroundColor = [UIColor systemGreenColor];
            [self configGenderView];
            [self layoutChildView:self.genderView];
            [self.genderView bindingData:[user getGender]];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Helper
-(void) configBirthdayView{
    self.birthdayView = [[BirthdayView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.birthdayView.translatesAutoresizingMaskIntoConstraints = false;
    
    self.birthdayView.delegate = self.delegate;
}

-(void) configEmailView{
    self.emailView = [[EmailView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.emailView.translatesAutoresizingMaskIntoConstraints = false;
}

-(void) configGenderView{
    self.genderView = [[GenderView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.genderView.translatesAutoresizingMaskIntoConstraints = false;
}

-(void) layoutChildView: (UIView *) childView{
    [self.contentEditableView addSubview:childView];
    [childView.topAnchor constraintEqualToAnchor:self.contentEditableView.topAnchor].active = true;
    [childView.leadingAnchor constraintEqualToAnchor:self.contentEditableView.leadingAnchor].active = true;
    [childView.trailingAnchor constraintEqualToAnchor:self.contentEditableView.trailingAnchor].active = true;
    [childView.bottomAnchor constraintEqualToAnchor:self.contentEditableView.bottomAnchor].active = true;
}

//-(void) configPickerView{
//    self.datePicker = [[UIDatePicker alloc] init];
//    self.datePicker.backgroundColor = [UIColor whiteColor];
//    [self.datePicker setValue:[UIColor blackColor] forKey:@"textColor"];
//    self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.datePicker.datePickerMode = UIDatePickerModeDate;
//    self.datePicker.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width , 300);
//}

#pragma mark - Delegate
- (void)didBirthdayLabelTapped{
    NSLog(@"helo");
}

@end
