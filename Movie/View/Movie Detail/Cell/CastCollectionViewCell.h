//
//  CastCollectionViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 7/29/22.
//

#import <UIKit/UIKit.h>
#import "Actor.h"
NS_ASSUME_NONNULL_BEGIN

@interface CastCollectionViewCell : UICollectionViewCell
+(NSString *) getReuseIdentifier;
+(NSString *) getNibName;
+(CGFloat) getRowHeight;
-(void) bindingData: (Actor *) actor;
@end

NS_ASSUME_NONNULL_END
