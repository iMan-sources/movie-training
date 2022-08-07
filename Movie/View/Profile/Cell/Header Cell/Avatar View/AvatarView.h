//
//  AvatarView.h
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import <UIKit/UIKit.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AvatarViewDelegate <NSObject>

-(void) didAvatarViewTapped;

@end
@interface AvatarView : UIView
-(void) configTextFieldWithBorderStyle: (UITextBorderStyle) borderStyle withInteract: (BOOL) isInteract;
-(void) settingImageForAvatarImageView: (NSString *)urlImagePath;
-(void) bindingData: (User *)user;
-(NSString *) getName;
-(NSString *) getImagePath;
-(void) setAvatarImageViewUseInteraction: (BOOL) isInteract;
@property(weak, nonatomic) id<AvatarViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
