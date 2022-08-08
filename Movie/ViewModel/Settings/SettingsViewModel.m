//
//  SettingsViewModel.m
//  Movie
//
//  Created by AnhVT12.REC on 8/8/22.
//

#import "SettingsViewModel.h"
#import "SettingsFilterTableViewCell.h"
#import "UserDefaultsNames.h"

@interface SettingsViewModel()
@property(strong, nonatomic) NSMutableArray<NSIndexPath *> *indexPathSelected;

@end
@implementation SettingsViewModel


#pragma mark - Populate table view
- (instancetype)init{
    if (self = [super init]) {
        self.indexPathSelected = [[NSMutableArray alloc] init];
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

        }else{
            [self.indexPathSelected addObject:indexPath];
            [cell setCheckImageDisplayHidden:NO];
     
        }
    }
    //array have no section
    if (self.indexPathSelected.count == 0) {
        [self.indexPathSelected addObject:indexPath];
        [cell setCheckImageDisplayHidden:NO];
    }
    
    //save settings filter type in userDefault
    if ([self settingType:indexPath.section] == filter) {
        [self setSettingsFilterTypeInUserdefault:indexPath];
    }
    
    //save settings sort type in userdefault
    if ([self settingType:indexPath.section] == sort) {
        [self setSettingsSortTypeInUserDefault:indexPath];
    }
}

#pragma mark - Helper

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
-(void) setSettingsFilterTypeInUserdefault: (NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *type = [NSString stringWithFormat:@"%li", row];
    [standardUserDefaults setObject:type forKey:FilterTypeUserDefaults];
    NSLog(@"%@", [standardUserDefaults objectForKey:FilterTypeUserDefaults]);
}

-(void) setSettingsSortTypeInUserDefault: (NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *type = [NSString stringWithFormat:@"%li", row];
    [standardUserDefaults setObject:type forKey:SortTypeUserDefaults];
}


-(void) loadSettingsFilterTypeFromUserDefault{

    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger type = [[standardUserDefaults objectForKey: FilterTypeUserDefaults] intValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:type inSection:filter];
    if (![self.indexPathSelected containsObject:indexPath]) {
        [self.indexPathSelected addObject:indexPath];
    }
}

-(void) loadSettingsSortTypeFromUserDefault{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger type = [[standardUserDefaults objectForKey: SortTypeUserDefaults] intValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:type inSection:sort];
    if (![self.indexPathSelected containsObject:indexPath]) {
        [self.indexPathSelected addObject:indexPath];
    }

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

@end
