//
//  SettingsViewModel.m
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import "SettingsViewModel.h"
#import "SettingsFilterTableViewCell.h"
#import "UserDefaultsNames.h"
#import "NotificationNames.h"
@interface SettingsViewModel()
@property(strong, nonatomic) NSMutableArray<NSIndexPath *> *indexPathSelected;
@property(nonatomic) BOOL isSelectionExistInTableView;
@property(strong, nonatomic) NSUserDefaults *standardUserDefaults;
@end
@implementation SettingsViewModel


#pragma mark - Populate table view
- (instancetype)init{
    if (self = [super init]) {
        self.indexPathSelected = [[NSMutableArray alloc] init];
        self.isSelectionExistInTableView = false;
        self.standardUserDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView{
    return SettingSections;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return SettingRowsInFilterSection;
    }
    return SetttingRowsInSortSection;
}

- (NSString *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    SettingsType settingsType = [self settingType:section];
    switch (settingsType){
        case filter:
        {
            FilterType type = [self filterTypeAtIndexPath:row];
            NSString *title = [self filterTitleForCell:type];
            return title;
        }
        case sort:
        {
            SortType type = [self sortTypeAtIndexPath:row];
            NSString *title = [self sortTitleForCell:type];
            return title;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingsFilterTableViewCell *cell = (SettingsFilterTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    //just store 2 indexPath with different sections in an array, if exists an indexPath with the same section, it will replace,
    //and display check image by the index path in that array
    for (int i = 0; i < self.indexPathSelected.count; i++) {
        if (indexPath.section == self.indexPathSelected[i].section) {
            SettingsFilterTableViewCell *beingSelectedCell = (SettingsFilterTableViewCell *)[tableView cellForRowAtIndexPath:self.indexPathSelected[i]];
            [beingSelectedCell setCheckImageDisplayHidden:YES];
            [cell setCheckImageDisplayHidden:NO];
            self.indexPathSelected[i] = indexPath;
            
            self.isSelectionExistInTableView = YES;
            break;
        }
    }

    if (!self.isSelectionExistInTableView) {
        [self.indexPathSelected addObject:indexPath];
        
        [cell setCheckImageDisplayHidden:NO];
    }
    //save settings filter type in userDefault
    NSLog(@"%ld", (long)indexPath.section);
    switch ([self settingType:indexPath.section]) {
        case filter:
        {
            [self setSettingsFilterTypeInUserdefault:indexPath];
            [self postDidFilterTypeChangedNotification];
            break;
        }
        case sort:
        {
            [self setSettingsSortTypeInUserDefault:indexPath];
            [self postDidSortTypeChangedNotification];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Action
-(void) postDidFilterTypeChangedNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:DidFilterTypeChangedNotification object:nil];
}
-(void) postDidSortTypeChangedNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:DidSortTypeChangedNotification object:nil];
}
#pragma mark - Helper

#pragma mark - Filter & Sort Populate
-(NSString *) filterTitleForCell: (FilterType)type{
    switch (type) {
        case popular:
        {
            return @"Popular Movies";
        };
        case topRated:
        {
            return @"Top Rated Movies";
        };
        case upcoming:
        {
            return @"Upcoming Movies";
        };
        case nowPlaying:
        {
            return @"NowPlaying Movies";
        };
        case movieWithRateFrom:
        {
            return @"Movie with rate from";
        };
        case fromReleaseYear:
        {
            return @"From release year";
        };
    }
}

-(NSString *) sortTitleForCell: (SortType)type{
    switch (type) {
        case releaseDate:
        {
            return @"Release Date";
        }
        case rating:
        {
            return @"Rating";
        }
    }
}

-(SettingsType) settingType: (NSInteger) section{
    if (section == 0) {
        return filter;
    }
    return sort;
}

-(FilterType) filterTypeAtIndexPath: (NSInteger) row{
    for (int i = popular; i <= fromReleaseYear; i++) {
        if (i == row) {
            return i;
        }
    }
    return popular;
}

-(SortType) sortTypeAtIndexPath: (NSInteger) row{
    for (int i = releaseDate; i <= rating; i++) {
        if (i == row) {
            return i;
        }
    }
    return releaseDate;
}


- (NSString *)titleForHeader:(NSInteger)section{
    SettingsType settingType = [self settingType:section];
    switch (settingType) {
        case filter:
            return @"Filter";
        case sort:
            return @"Sort";
    }
}

- (BOOL)isFromYearReleaseType:(NSIndexPath *)indexPath{
    SettingsType settingType = [self settingType:indexPath.section];
    FilterType filterType = [self filterTypeAtIndexPath:indexPath.row];
    
    if (settingType == filter && filterType == fromReleaseYear) {
        return YES;
    }
    return NO;
}

- (BOOL) isMovieWithRateFromType:(NSIndexPath *)indexPath{
    SettingsType settingType = [self settingType:indexPath.section];
    FilterType filterType = [self filterTypeAtIndexPath:indexPath.row];
    
    if (settingType == filter && filterType == movieWithRateFrom) {
        return YES;
    }
    return NO;
}

-(BOOL) checkIfRowIsFilterTypeDefault: (NSIndexPath *) indexPath{
    if ([self.indexPathSelected containsObject:indexPath]) {
        return YES;
    }
    return NO;
}

-(BOOL) checkIfRowIsSortTypeDefault: (NSIndexPath *) indexPath{
    if ([self.indexPathSelected containsObject:indexPath]) {
        return YES;
    }
    return NO;
}

#pragma mark - User defaults

#pragma mark - Filter & Sort User default
-(void) setSettingsFilterTypeInUserdefault: (NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSString *type = [NSString stringWithFormat:@"%ld", (long)row];
    [self.standardUserDefaults setObject:type forKey:FilterTypeUserDefaults];
//    NSLog(@"%@", [standardUserDefaults objectForKey:FilterTypeUserDefaults]);
}

-(void) setSettingsSortTypeInUserDefault: (NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSString *type = [NSString stringWithFormat:@"%ld", (long)row];
    [self.standardUserDefaults setObject:type forKey:SortTypeUserDefaults];
}

-(NSIndexPath *) loadSettingsFilterTypeFromUserDefault{
    
    NSInteger type = [[self.standardUserDefaults objectForKey: FilterTypeUserDefaults] intValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:type inSection:filter];
    return indexPath;
    
}

-(NSIndexPath *) loadSettingsSortTypeFromUserDefault{
    NSInteger type = [[self.standardUserDefaults objectForKey: SortTypeUserDefaults] intValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:type inSection:sort];
    return indexPath;
}


-(void) loadSettingsDefault{
    [self.indexPathSelected removeAllObjects];
    
    [self.indexPathSelected addObject:[self loadSettingsSortTypeFromUserDefault]];
    [self.indexPathSelected addObject:[self loadSettingsFilterTypeFromUserDefault]];
    
}

#pragma mark - Movie Rate & Release Year User default
-(double) loadMovieRateSettingFromUserDefault{
    double rate = [[self.standardUserDefaults objectForKey:MovieRateUserDefaults] doubleValue];
    return rate;
}

-(int) loadReleaseYearSettingFromUserDefault{
    int releaseYear = [[self.standardUserDefaults objectForKey:ReleaseYearUserDefaults]intValue];
    return releaseYear;
}

-(void) setMovieRatingInUserDefault: (double) rating{
    NSString *ratingString = [NSString stringWithFormat:@"%.1f", rating];
    [self.standardUserDefaults setObject:ratingString forKey:MovieRateUserDefaults];
    
    //postNotification
    [[NSNotificationCenter defaultCenter] postNotificationName:DidMovieRateChangedNotification object:nil];
}

-(void) setFromReleaseyearInUserDefault: (NSString *)year{
    [self.standardUserDefaults setObject:year forKey:ReleaseYearUserDefaults];
    [[NSNotificationCenter defaultCenter] postNotificationName:DidReleaseYearChangedNotification object:nil];
}

-(NSInteger) loadYearSettingsInUserDefault: (NSMutableArray<NSString *> *) years{
    NSInteger index = 0;
    NSString *defaultYear = [self.standardUserDefaults objectForKey:ReleaseYearUserDefaults];
    for (int i = 0; i < years.count; i++) {
        if ([defaultYear isEqual:years[i]]) {
            index = i;
            break;
        }
    }
    return index;
}


@end
