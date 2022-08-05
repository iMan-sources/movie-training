//
//  MovieCD+CoreDataProperties.m
//  Movie
//
//  Created by AnhVT12.REC on 8/2/22.
//
//

#import "MovieCD+CoreDataProperties.h"

@implementation MovieCD (CoreDataProperties)

+ (NSFetchRequest<MovieCD *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MovieCD"];
}

@dynamic movieID;
@dynamic overview;
@dynamic poster_path;
@dynamic release_date;
@dynamic title;
@dynamic vote_average;

@end
