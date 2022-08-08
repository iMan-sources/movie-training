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

@interface SettingsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) SettingsViewModel *settingsViewModel;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Settings";
    [self setup];
    
}
#pragma mark - Helper
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
    
    [self.settingsViewModel loadSettingsFilterTypeFromUserDefault];
    [self.settingsViewModel loadSettingsSortTypeFromUserDefault];
}

-(void) setup{
    [self configViewModel];
    [self configTableView];
}

-(void) configViewModel{
    self.settingsViewModel = [[SettingsViewModel alloc] init];
}

#pragma mark - Delegate	
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     //no selected with two type
    if ([self.settingsViewModel isMovieWithRateFromType:indexPath] || [self.settingsViewModel isFromYearReleaseType:indexPath]) {
        return;
    }
    [self.settingsViewModel tableView:tableView didSelectRowAtIndexPath:indexPath];
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
        
        [yearConditionCell bindingData:title];
        return yearConditionCell;
    }
    
    if ([self.settingsViewModel isMovieWithRateFromType:indexPath]) {
        
        SettingsRateConditionTableViewCell *rateConditionCell = [tableView dequeueReusableCellWithIdentifier:[SettingsRateConditionTableViewCell getReuseIdentifer] forIndexPath:indexPath];
        [rateConditionCell bindingData:title];
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
