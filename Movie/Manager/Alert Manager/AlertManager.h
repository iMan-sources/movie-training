//
//  AlertManager.h
//  Movie
//
//  Created by AnhVT12.REC on 8/2/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AlertManagerDelegate <NSObject>

-(void) showRemoveMovieAlertWithName: (NSString *)name inVC: (UIViewController *)vc withYesSelection: (void(^)(void)) yesCompletion withNoSelection: (void(^)(void)) noCompletion;
-(void) showErrorMessageWithDescription: (NSString *) msg inVC: (UIViewController *)vc withSelection: (void (^)(void)) completionHandler;
@end

@interface AlertManager : NSObject<AlertManagerDelegate>

@end

NS_ASSUME_NONNULL_END
