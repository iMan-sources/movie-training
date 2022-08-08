//
//  DatePickerManager.m
//  Movie
//
//  Created by AnhLe on 07/08/2022.
//

#import "DatePickerManager.h"
static NSInteger const DatePickerHeight = 300;
@interface DatePickerManager()
@property(strong, nonatomic) UIToolbar *toolbar;
@property(strong, nonatomic) UIDatePicker *datePicker;
@property(strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UIView *maskView;
//@property (strong, nonatomic) UIWindow *window;
@end

@implementation DatePickerManager
-(void) configMaskView{
    self.maskView = [[UIView alloc] init];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.maskView.alpha = 0;
}

//-(void) configWindow{
//    UIScene *scene = [[[[UIApplication sharedApplication] connectedScenes] allObjects] firstObject];
//
//    if([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]){
//        self.window = [(id <UIWindowSceneDelegate>)scene.delegate window];
//    }
//    [self.window makeKeyAndVisible];
//
//}

-(void) configDatePicker{
    self.datePicker = [[UIDatePicker alloc] init];
    	
    [self.datePicker setValue:[UIColor blackColor] forKey:@"textColor"];
    self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.translatesAutoresizingMaskIntoConstraints = false;
    [self.datePicker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
        if (@available(iOS 13.4, *)) {
            self.datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
}

-(void) layoutWithVC: (EditProfileViewController *)vc{
    [self.datePicker.leadingAnchor constraintEqualToAnchor:vc.view.leadingAnchor].active = true;
    [self.datePicker.trailingAnchor constraintEqualToAnchor:vc.view.trailingAnchor].active = true;
    [self.datePicker.bottomAnchor constraintEqualToAnchor:vc.view.safeAreaLayoutGuide.bottomAnchor constant:999].active = true;
    [self.datePicker.heightAnchor constraintEqualToConstant:300].active = true;
    
}

//-(void) showDatePicker: (BOOL) isShow{
//
//    CGRect datePickerFrame = self.datePicker.frame;
//    datePickerFrame.origin.y = isShow ? self.window.frame.size.height - DatePickerHeight : self.window.frame.size.height;
//
//    self.datePicker.frame = datePickerFrame;
//
//}ß
-(void) showWithVC: (EditProfileViewController *)vc{
    [self configMaskView];
    [vc.view addSubview:self.maskView];
    [self.maskView setFrame:vc.view.frame];
    
    [self configDatePicker];
    [self layoutWithVC:vc];


}
    

- (void)showDatePickerViewWithViewController:(EditProfileViewController *)vc withCompletion:(void (^)(NSDate * _Nonnull))completionHandler{
    
//    [self showWithVC:vc];
    [self configMaskView];
    [vc.view addSubview:self.maskView];
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1;
        
    }];

    completionHandler(self.date);

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
