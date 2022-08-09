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
-(void)getMoviesWithPage: (NSInteger)page withSucess: (void(^)(void))successCompletion withError: (void(^)(NSError *)) errorCompletion;
-(void) sortMovieWithSuccess: (void(^)(void))completionHandler;
-(void) resetArray;
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

-(void) filterMoviesArrayWithSettingDefault: (void(^)(void)) completionHandler;

@end

NS_ASSUME_NONNULL_END
