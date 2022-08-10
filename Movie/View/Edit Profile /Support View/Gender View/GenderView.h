//
//  GenderView.h
//  Movie
//
//  Created by AnhLe on 06/08/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GenderView : UIView
-(void) bindingData: (NSString *) gender;
-(NSString *) getGender;
@end

NS_ASSUME_NONNULL_END
