//
//  Reminder+CoreDataProperties.m
//  Movie
//
//  Created by AnhVT12.REC on 8/10/22.
//
//

#import "Reminder+CoreDataProperties.h"

@implementation Reminder (CoreDataProperties)

+ (NSFetchRequest<Reminder *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Reminder"];
}

@dynamic time;
@dynamic movieID;

@end
