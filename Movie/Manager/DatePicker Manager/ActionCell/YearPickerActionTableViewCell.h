//
//  YearPickerActionTableViewCell.h
//  Movie
//
//  Created by AnhLe on 09/08/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol YearPickerActionTableViewCellDelegate <NSObject>

-(void) didYearPickerSelectedWithYear: (NSString *) year;

@end
@interface YearPickerActionTableViewCell : UITableViewCell
+(NSString *) getReuseIdentifier;
@property(weak, nonatomic) id<YearPickerActionTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
