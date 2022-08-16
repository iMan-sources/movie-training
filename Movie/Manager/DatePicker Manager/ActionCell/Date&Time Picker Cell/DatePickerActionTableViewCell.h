//
//  ActionTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/9/22.
//

#import <UIKit/UIKit.h>
#import "DatePickerManager.h"
NS_ASSUME_NONNULL_BEGIN
@protocol DatePickerActionTableViewCellDelegate <NSObject>

- (void)didDatePickerSelected:(NSDate *)date;

@end

@interface DatePickerActionTableViewCell : UITableViewCell
+ (NSString *)getReuseIdentifier;
@property(weak, nonatomic) id<DatePickerActionTableViewCellDelegate> delegate;

//- (void)bindingDateType:(PickerType) pickerType;
- (void)bindingData:(NSInteger)picker;
@end

NS_ASSUME_NONNULL_END
