//
//  SettingsRateConditionTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsRateConditionTableViewCell : UITableViewCell
+(NSString *) getReuseIdentifer;
+(NSString *) getNibName;
+(CGFloat) getRowHeight;

- (void)bindingData:(NSString *)content withRating: (double)rating;
@end

NS_ASSUME_NONNULL_END
