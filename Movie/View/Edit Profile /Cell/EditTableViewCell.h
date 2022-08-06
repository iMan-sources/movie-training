//
//  EditTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/5/22.
//

#import <UIKit/UIKit.h>
#import "ProfileViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditTableViewCell : UITableViewCell
+(NSString *) getReuseIdentifier;
+(NSString *) getNibName;
-(void) bindingData: (User *)user withInforType: (InforProfileType)type;
-(void) gettingDataWithInforType: (InforProfileType)type withUser: (User *)user;
@end

NS_ASSUME_NONNULL_END
