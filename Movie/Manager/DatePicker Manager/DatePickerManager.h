//
//  DatePickerManager.h
//  Movie
//
//  Created by AnhLe on 07/08/2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EditProfileViewController.h"
NS_ASSUME_NONNULL_BEGIN
@protocol DatePickerManagerDelegate <NSObject>

-(void) showDatePickerViewWithViewController: (EditProfileViewController *)vc withCompletion: (void (^)(NSDate *)) completionHandler;

@end
@interface DatePickerManager : NSObject<DatePickerManagerDelegate>

@end

NS_ASSUME_NONNULL_END
