//
//  ProfileFooterTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ProfileFooterTableViewCellDelegate

-(void) didFooterButtonTapped: (NSInteger) tag;

@end
@interface ProfileFooterTableViewCell : UITableViewHeaderFooterView
+(NSString *) getReuseIdentifier;
+(NSString *) getNibName;
-(void) bindingLabelButton: (NSString *)label;
@property(weak, nonatomic) id<ProfileFooterTableViewCellDelegate> delegate;

-(void) setButtonTag: (NSInteger) tag;

@end

NS_ASSUME_NONNULL_END
