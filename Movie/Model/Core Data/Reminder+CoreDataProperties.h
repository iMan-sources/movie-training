//
//  Reminder+CoreDataProperties.h
//  Movie
//
//  Created by AnhVT12.REC on 8/10/22.
//
//

#import "Reminder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Reminder (CoreDataProperties)

+ (NSFetchRequest<Reminder *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSDate *time;
@property (nonatomic) int32_t movieID;

@end

NS_ASSUME_NONNULL_END
