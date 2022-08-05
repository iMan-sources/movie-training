//
//  HeaderProfileTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import <UIKit/UIKit.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface HeaderProfileTableViewCell : UITableViewHeaderFooterView

+(NSString *) getReuseIdentifier;
+(CGFloat) getHeaderViewHeight;
-(void)bindingData: (User *)user;
@end

NS_ASSUME_NONNULL_END
