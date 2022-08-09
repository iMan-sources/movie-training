//
//  SettingsViewModel.h
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SettingsType) {
    filter,
    sort
};
typedef NS_ENUM(NSInteger, SortType){
    releaseDate = 0,
    rating
};
typedef NS_ENUM(NSInteger, FilterType){
    popular = 0,
    topRated,
    upcoming,
    nowPlaying,
    movieWithRateFrom,
    fromReleaseYear
};

static NSInteger const SettingRowsInFilterSection = fromReleaseYear - popular + 1;
static NSInteger const SetttingRowsInSortSection = (rating - releaseDate + 1);
static NSInteger const SettingSections = sort - filter + 1;
NS_ASSUME_NONNULL_BEGIN
	
@interface SettingsViewModel : NSObject
- (NSInteger)numberOfSectionsInTableView;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSString *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(NSString *) titleForHeader: (NSInteger)section;

-(BOOL) isFromYearReleaseType: (NSIndexPath *) indexPath;

-(BOOL) isMovieWithRateFromType: (NSIndexPath *) indexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;



-(BOOL) checkIfRowIsFilterTypeDefault: (NSIndexPath *) indexPath;
-(BOOL) checkIfRowIsSortTypeDefault: (NSIndexPath *) indexPath;
#pragma mark - User default

-(double) loadMovieRateSettingFromUserDefault;
-(int) loadReleaseYearSettingFromUserDefault;

-(void) loadSettingsDefault;

-(void) setMovieRatingInUserDefault: (double) rating;
-(void) setFromReleaseyearInUserDefault: (NSString *)year;
@end

NS_ASSUME_NONNULL_END
