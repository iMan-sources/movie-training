//
//  ProfileTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileTableViewCell : UITableViewCell

- (void)bindingData:(NSString *)infor withImage: (UIImage *)image;

+(NSString *) getReuseIdentifier;
+(NSString *) getNibName;
@end

NS_ASSUME_NONNULL_END
