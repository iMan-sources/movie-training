//
//  ActionTableViewCell.m
//  Movie
//
//  Created by AnhVT12.REC on 8/9/22.
//

#import "DatePickerActionTableViewCell.h"
#import <UIKit/UIKit.h>

@interface DatePickerActionTableViewCell()
@property(strong, nonatomic) UIDatePicker *datePicker;
@property(strong, nonatomic) NSDate *date;
@property(nonatomic) PickerType pickerType;
@end

@implementation DatePickerActionTableViewCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        [self layout];
        
    }
    return self;
    
}

#pragma mark - Class Helper
+ (NSString *)getReuseIdentifier{
    return @"ActionTableViewCell";
}

#pragma mark - Helper
- (void)setup{
    [self configDatePicker];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)layout{
    [self.contentView addSubview:self.datePicker];
    [self.datePicker.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8].active = true;
    [self.datePicker.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8].active = true;
    [self.datePicker.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8].active = true;
    [self.datePicker.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8].active = true;
}

- (void)configDatePicker{
    self.datePicker = [[UIDatePicker alloc] init];
    [self.datePicker setValue:[UIColor blackColor] forKey:@"textColor"];
    self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.datePicker.datePickerMode = UIDatePickerModeDate;

    self.datePicker.translatesAutoresizingMaskIntoConstraints = false;
    
    self.datePicker.layer.cornerRadius = 10;
    self.datePicker.layer.masksToBounds = YES;
    
    [self.datePicker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (@available(iOS 13.4, *)) {
        self.datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    
    self.datePicker.backgroundColor = [UIColor whiteColor];
}
- (void)bindingData:(NSInteger)picker{
    switch(picker){
        case datePicker:
            self.datePicker.datePickerMode = UIDatePickerModeDate;
            self.pickerType = datePicker;
            break;
        case dateTimePicker:
            self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            self.pickerType = dateTimePicker;
            break;
    }
}

- (NSDate *)convertDateInPickerToBirthday:(UIDatePicker *)sender{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    switch (self.pickerType) {
        case datePicker:
        {
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        }
        case dateTimePicker:
        {
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
            break;
        }
        default:
            break;
    }
    
    
    NSString *strDate = [dateFormatter stringFromDate:[sender date]];
    NSDate *date = [dateFormatter dateFromString:strDate];
    return date;
}

#pragma mark - Action
- (void)dueDateChanged:(UIDatePicker *)sender{

    NSDate *date = [self convertDateInPickerToBirthday:sender];
    [self.delegate didDatePickerSelected:date];
}




@end
