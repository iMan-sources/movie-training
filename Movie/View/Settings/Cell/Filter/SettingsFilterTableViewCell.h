//
//  SettingsTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsFilterTableViewCell : UITableViewCell

-(void) bindingData: (NSString *) content;
+(NSString *) getReuseIdentifer;
+(NSString *) getNibName;
+(CGFloat) getRowHeight;
-(void) setCheckImageDisplayHidden: (BOOL) isHidden;
@end

NS_ASSUME_NONNULL_END
