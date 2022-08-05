//
//  EditProfileHeaderTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/5/22.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol EditProfileHeaderTableViewCellDelegate <NSObject>

-(void) didCancelButtonTapped;
-(void) didDoneButtonTapped;
@end
@interface EditProfileHeaderTableViewCell : UITableViewHeaderFooterView
+(NSString *) getReuseIdentifier;

+(CGFloat) getHeaderHeight;
@property(weak, nonatomic) id<EditProfileHeaderTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
