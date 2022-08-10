//
//  EditProfileHeaderTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/5/22.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol EditProfileHeaderViewDelegate <NSObject>

-(void) didCancelButtonTapped;
-(void) didDoneButtonTapped;
@end
@interface EditProfileHeaderView : UIView
+(NSString *) getReuseIdentifier;

+(CGFloat) getHeaderHeight;
@property(weak, nonatomic) id<EditProfileHeaderViewDelegate> delegate;
@property(strong, nonatomic) AvatarView *avatarView;
-(void) bindingData: (User *)user;
@end

NS_ASSUME_NONNULL_END
