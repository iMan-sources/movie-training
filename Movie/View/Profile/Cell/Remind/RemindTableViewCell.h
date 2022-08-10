//
//  RemindTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/10/22.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface RemindTableViewCell : UITableViewCell
+(NSString *) getReuseIdentifier;
+(NSString *) getNibName;

-(void) bindingData: (Movie *) movie;
@end

NS_ASSUME_NONNULL_END
