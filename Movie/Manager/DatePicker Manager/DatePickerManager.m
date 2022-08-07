//
//  DatePickerManager.m
//  Movie
//
//  Created by AnhLe on 07/08/2022.
//

#import "DatePickerManager.h"
@interface DatePickerManager()
@property(strong, nonatomic) UIToolbar *toolbar;
@property(strong, nonatomic) UIDatePicker *datePicker;
@property(strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UIView *maskView;
@end

@implementation DatePickerManager
-(void) configMaskView{
    self.maskView = [[UIView alloc] init];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    
}

-(void) configDatePicker{
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self.datePicker setValue:[UIColor blackColor] forKey:@"textColor"];
    self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.translatesAutoresizingMaskIntoConstraints = false;
    [self.datePicker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];

}

-(void) layoutWithVC: (EditProfileViewController *)vc{
    [self.datePicker.leadingAnchor constraintEqualToAnchor:vc.view.leadingAnchor].active = true;
    [self.datePicker.trailingAnchor constraintEqualToAnchor:vc.view.trailingAnchor].active = true;
    [self.datePicker.bottomAnchor constraintEqualToAnchor:vc.view.safeAreaLayoutGuide.bottomAnchor].active = true;
    [self.datePicker.heightAnchor constraintEqualToConstant:300].active = true;
    
}
- (void)showDatePickerViewWithViewController:(EditProfileViewController *)vc withCompletion:(void (^)(NSDate * _Nonnull))completionHandler{
    
    [self configMaskView];
    
    [self configDatePicker];
    [vc.view addSubview:self.maskView];
    
    
    
    [self.maskView setFrame:vc.view.bounds];
//    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//        [
//    } completion:nil];
    [vc.view addSubview:self.datePicker];
    [self layoutWithVC:vc];
    
    
//    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 50)];
//    self.toolbar.barStyle = UIBarStyleDefault;
//    self.toolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneButtonClick)]];
//    [self.toolbar sizeToFit];

//    [vc.view addSubview:self.toolbar];
    NSLog(@"hi");
    if (@available(iOS 13.4, *)) {
        self.datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    completionHandler(self.date);
    
//    self.toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width , 300)];
//    self.toolbar.barStyle = UIBarStyleDefault;
    
    
}
#pragma mark - Action
-(void) dueDateChanged: (UIDatePicker *) sender{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
    self.date = [sender date];

}

-(void)onDoneButtonClick {
    [self.toolbar removeFromSuperview];
    [self.datePicker removeFromSuperview];
}

@end
