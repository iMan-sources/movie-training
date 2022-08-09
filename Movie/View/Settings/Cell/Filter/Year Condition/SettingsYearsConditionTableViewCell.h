//
//  SettingsYearsConditionTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SettingsYearsConditionTableViewCellDelegate <NSObject>

-(void) didYearLabelSelected;

@end
@interface SettingsYearsConditionTableViewCell : UITableViewCell
+(NSString *) getReuseIdentifer;
+(NSString *) getNibName;
+(CGFloat) getRowHeight;
- (void)bindingData:(NSString *)content withReleaseYear: (int) year;
-(void) setReleaseYearWhenPickerSelected: (NSString *) year;
@property(weak, nonatomic) id<SettingsYearsConditionTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
