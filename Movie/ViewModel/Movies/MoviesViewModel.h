//
//  MoviesViewModel.h
//  Movie
//
//  Created by AnhLe on 29/07/2022.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface MoviesViewModel : NSObject
-(void)getPopularMoviesWithPage: (NSInteger)page withSucess: (void(^)(NSArray<Movie *> *))successCompletion withError: (void(^)(NSError *)) errorCompletion;
#pragma mark -TableView
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSectionsInTableView;

- (Movie *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark -collectionView
- (NSInteger)numberOfSectionsInCollectionView;

-(NSInteger )numberOfItemsInSection:(NSInteger)section;

-(Movie *)cellForItemAtIndexPath:(NSIndexPath *)indexPath;

-(BOOL) checkHaveMoreMovies;

-(Movie *)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
