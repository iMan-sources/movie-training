//
//  UIViewController+Extensions.h
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import <UIKit/UIKit.h>
#import "AlertManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extensions)
-(void) bringVCToView: (UIViewController *)viewController withView: (UIView *) view;
-(void) configLeftBarItemButtons;
-(void) registerTapGestureToEndEditing;

#pragma mark - Notification Center
-(void) postNotificationWhenLikeButtonTapped;

-(void) postNotificationWhenUnlikeButtonTapped;
@end

NS_ASSUME_NONNULL_END
