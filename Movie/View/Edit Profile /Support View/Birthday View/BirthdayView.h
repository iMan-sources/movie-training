//
//  BirthdayView.h
//  Movie
//
//  Created by AnhLe on 06/08/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BirthdayViewDelegate <NSObject>

- (void)didBirthdayLabelTapped;

@end
@interface BirthdayView : UIView
- (void)bindingData:(NSDate *)birthday;
- (NSDate *)getDate;
@property(weak, nonatomic) id<BirthdayViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
