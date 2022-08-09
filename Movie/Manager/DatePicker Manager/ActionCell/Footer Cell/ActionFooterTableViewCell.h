//
//  ActionFooterTableViewCell.h
//  Movie
//
//  Created by AnhVT12.REC on 8/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ActionFooterTableViewCellDelegate <NSObject>

-(void) didSelectButtonTapped;

-(void) didCancelButtonTapped;

@end
@interface ActionFooterTableViewCell : UITableViewHeaderFooterView
+(NSString *) getNibName;
+(NSString *) getReuseIdentifier;

@property(weak, nonatomic) id<ActionFooterTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
