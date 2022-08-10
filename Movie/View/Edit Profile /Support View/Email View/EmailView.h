//
//  EmailView.h
//  Movie
//
//  Created by AnhLe on 06/08/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmailView : UIView
-(void) bindingData: (NSString *) email;
-(NSString *) getEmail;
@end

NS_ASSUME_NONNULL_END
