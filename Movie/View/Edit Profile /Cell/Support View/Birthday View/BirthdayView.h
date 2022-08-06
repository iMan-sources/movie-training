//
//  BirthdayView.h
//  Movie
//
//  Created by AnhLe on 06/08/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BirthdayView : UIView
-(void) bindingData: (NSDate *) birthday;
-(NSDate *) getDate;
@end

NS_ASSUME_NONNULL_END
