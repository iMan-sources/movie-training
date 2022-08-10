//
//  DatePickerManager.h
//  Movie
//
//  Created by AnhLe on 07/08/2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EditProfileViewController.h"
#import "ActionCell/DatePickerActionTableViewCell.h"
#import "ActionCell/YearPickerActionTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, PickerType){
    datePicker = 0,
    yearPicker
};
@protocol DidDateSelectedDelegate <NSObject>

-(void) didDateSelected: (NSDate *)date;

@end

@protocol DatePickerManagerDelegate <NSObject>

-(void) showPickerViewWithViewController: (UIViewController *)vc withPickerType: (PickerType)pickerType;
-(void) showYearPickerViewWithViewController:(UIViewController *)vc withCompletion: (void (^)(NSDate *)) completionHandler;
@property(weak, nonatomic) id<DidDateSelectedDelegate> delegate;
@end


@interface DatePickerManager : NSObject<DatePickerManagerDelegate>

@end

NS_ASSUME_NONNULL_END
