//
//  MovieCD+CoreDataProperties.h
//  Movie
//
//  Created by AnhVT12.REC on 8/2/22.
//
//

#import "MovieCD+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MovieCD (CoreDataProperties)

+ (NSFetchRequest<MovieCD *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) int32_t movieID;
@property (nullable, nonatomic, copy) NSString *overview;
@property (nullable, nonatomic, copy) NSString *poster_path;
@property (nullable, nonatomic, copy) NSString *release_date;
@property (nullable, nonatomic, copy) NSString *title;
@property (nonatomic) double vote_average;

@end

NS_ASSUME_NONNULL_END
