//
//  MovieDetailViewModel.h
//  Movie
//
//  Created by AnhVT12.REC on 8/1/22.
//

#import <Foundation/Foundation.h>
#import "Actor.h"
NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailViewModel : NSObject
-(void) getCreditsMovieWithMovieId: (NSInteger)movieId withSuccess: (void(^)(NSArray<Actor *> *))succesCompletion withError: (void(^)(NSError *)) errorCompletion;

- (NSInteger)numberOfSectionsInCollectionView;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

-(Actor *) cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
