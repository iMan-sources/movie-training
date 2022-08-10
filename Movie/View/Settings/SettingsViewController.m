//
//  SettingsViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "SettingsViewController.h"
#import "SettingsViewModel.h"
#import "SettingsFilterTableViewCell.h"
#import "SettingsYearsConditionTableViewCell.h"
#import "SettingsRateConditionTableViewCell.h"
#import "DatePickerManager.h"
#import "NSDate+Extensions.h"
#import "UIViewController+Extensions.h"
@interface SettingsViewController ()<UITableViewDelegate, UITableViewDataSource, SettingsYearsConditionTableViewCellDelegate, DidDateSelectedDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) SettingsViewModel *settingsViewModel;
@property(strong, nonatomic) id<DatePickerManagerDelegate> datePickerManager;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigationBar];
    
    [self setup];
    
}
#pragma mark - Helper

-(void) configNavigationBar{
    self.navigationItem.title = @"Settings";
    [self configLeftBarItemButtons];
}

-(void) configTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:[SettingsFilterTableViewCell getNibName] bundle:nil] forCellReuseIdentifier:[SettingsFilterTableViewCell getReuseIdentifer]];
    
    [self.tableView registerNib:[UINib nibWithNibName:[SettingsYearsConditionTableViewCell getNibName] bundle:nil] forCellReuseIdentifier:[SettingsYearsConditionTableViewCell getReuseIdentifer]];
    
    [self.tableView registerNib:[UINib nibWithNibName:[SettingsRateConditionTableViewCell getNibName] bundle:nil] forCellReuseIdentifier:[SettingsRateConditionTableViewCell getReuseIdentifer]];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;

    
    if (@available(iOS 15.0, *)) {
        [self.tableView setSectionHeaderTopPadding:0.0f];
    }
    [self.settingsViewModel loadSettingsDefault];

    
}

-(void) setup{
    [self configViewModel];
    [self configTableView];
    [self configDatePickerManager];
}

-(void) configViewModel{
    self.settingsViewModel = [[SettingsViewModel alloc] init];
}

-(void) configDatePickerManager{
    self.datePickerManager = [[DatePickerManager alloc] init];
    self.datePickerManager.delegate = self;
}

#pragma mark - Delegate	
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     //no selected with two type
    if ([self.settingsViewModel isMovieWithRateFromType:indexPath] || [self.settingsViewModel isFromYearReleaseType:indexPath]) {
        return;
    }
    [self.settingsViewModel tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)didYearLabelSelected{
    [self.datePickerManager showPickerViewWithPickerType: yearPicker];

}

- (void)didDateSelected:(NSDate *)date{
    NSString *year = [date convertYearToString];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:fromReleaseYear inSection:filter];
    SettingsYearsConditionTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (indexPath == nil) {
        return;
    }
    //change year label
    [cell setReleaseYearWhenPickerSelected:year];
    
    //save to userDefault
    [self.settingsViewModel setFromReleaseyearInUserDefault:year];
   
}


#pragma mark - Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = [self.settingsViewModel numberOfSectionsInTableView];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = [self.settingsViewModel numberOfRowsInSection:section];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingsFilterTableViewCell *settingsCell = [tableView dequeueReusableCellWithIdentifier:[SettingsFilterTableViewCell getReuseIdentifer] forIndexPath:indexPath];
    
    NSString *title = [self.settingsViewModel cellForRowAtIndexPath:indexPath];
    
    if ([self.settingsViewModel isFromYearReleaseType:indexPath]) {
        SettingsYearsConditionTableViewCell *yearConditionCell = [tableView dequeueReusableCellWithIdentifier:[SettingsYearsConditionTableViewCell getReuseIdentifer] forIndexPath:indexPath];
        
        int year = [self.settingsViewModel loadReleaseYearSettingFromUserDefault];
        [yearConditionCell bindingData:title withReleaseYear:year];
        
        yearConditionCell.delegate = self;
        
        return yearConditionCell;
    }
    
    if ([self.settingsViewModel isMovieWithRateFromType:indexPath]) {
        
        SettingsRateConditionTableViewCell *rateConditionCell = [tableView dequeueReusableCellWithIdentifier:[SettingsRateConditionTableViewCell getReuseIdentifer] forIndexPath:indexPath];
        
        double rating = [self.settingsViewModel loadMovieRateSettingFromUserDefault];
        [rateConditionCell bindingData:title withRating:rating];
        
        return rateConditionCell;
    }
    
    [settingsCell bindingData:title];
    
    if ([self.settingsViewModel checkIfRowIsFilterTypeDefault:indexPath]) {
        [settingsCell setCheckImageDisplayHidden:NO];
    }
    
    if([self.settingsViewModel checkIfRowIsSortTypeDefault:indexPath]){
        [settingsCell setCheckImageDisplayHidden:NO];	
    }
    
    [self.tableView setNeedsLayout];
    [self.tableView layoutIfNeeded];
    
    return settingsCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView  *headerView = [[UITableViewHeaderFooterView  alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    headerView.tintColor = [UIColor systemGrayColor];
    [headerView.textLabel setTextColor:[UIColor blackColor]];
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = [self.settingsViewModel titleForHeader:section];
    return title;
}


@end
