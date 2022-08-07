//
//  EditTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/5/22.
//

#import <UIKit/UIKit.h>
#import "ProfileViewModel.h"
#import "BirthdayView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTableViewCell : UITableViewCell
+(NSString *) getReuseIdentifier;
+(NSString *) getNibName;
-(void) bindingData: (User *)user withInforType: (InforProfileType)type withImage: (UIImage *)image;
-(void) gettingDataWithInforType: (InforProfileType)type withUser: (User *)user;
@property(weak, nonatomic) id<BirthdayViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
