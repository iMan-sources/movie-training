//
//  SettingsYearsConditionTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsYearsConditionTableViewCell : UITableViewCell
+(NSString *) getReuseIdentifer;
+(NSString *) getNibName;
+(CGFloat) getRowHeight;
- (void)bindingData:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
