//
//  RemindersViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 8/11/22.
//

#import "RemindersViewController.h"
#import "RemindTableViewCell.h"
#import "ReminderViewModel.h"
#import "AlertManager.h"
#import "ViewControllerIdentifiers.h"
#import "MovieDetailViewController.h"
#import "Storyboard.h"
@interface RemindersViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *remindersTableView;
@property(strong, nonatomic) ReminderViewModel *reminderViewModel;
@property (strong, nonatomic) id<AlertManagerDelegate> alertManager;
@property (nonatomic, strong) UIStoryboard *story;

@end

@implementation RemindersViewController
#pragma mark - Lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configNavigationBar];
    [self setup];
    [self layout];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - Class Helper
+ (NSString *)getNibName{
    return @"RemindersViewController";
}

#pragma mark - Helper
- (void)setup{
    [self configStoryboard];
    [self configReminderViewModel];
    [self configTableView];
    [self loadReminderMovies];
    [self configAlertManager];
    
}
- (void)configAlertManager{
    self.alertManager = [[AlertManager alloc] init];
}

- (void)configNavigationBar{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"All Reminders";
}

- (void)layout{
    
}

- (void)configStoryboard{
    self.story = [UIStoryboard storyboardWithName:[Storyboard getStoryboardName] bundle:nil];
}
- (void)configTableView{
    self.remindersTableView.delegate = self;
    self.remindersTableView.dataSource = self;
    [self.remindersTableView registerNib:[UINib nibWithNibName:[RemindTableViewCell getNibName] bundle:nil] forCellReuseIdentifier:[RemindTableViewCell getReuseIdentifier]];
    self.remindersTableView.rowHeight = UITableViewAutomaticDimension;
    self.remindersTableView.estimatedRowHeight = 40.0;
}

- (void)configReminderViewModel{
    self.reminderViewModel = [[ReminderViewModel alloc] init];
    
}

- (void)loadReminderMovies{
    __weak RemindersViewController *weakSelf = self;
    [weakSelf.reminderViewModel fetchRemindersInCoreDataWithSuccess:^{
        [weakSelf.remindersTableView reloadData];
    } withError:^(NSError * _Nonnull error) {
        [self.alertManager showErrorMessageWithDescription:[error localizedDescription] inVC:self withSelection:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *movieDetailIdentifier = [ViewControllerIdentifiers getMovieDetailVCIdentifier];
    MovieDetailViewController *movieDetailVC = [self.story instantiateViewControllerWithIdentifier: movieDetailIdentifier];
    Movie *movie = [self.reminderViewModel cellForRowAtIndexPath:indexPath].movie;
    
    if (movie != nil) {
        [movieDetailVC loadMovieData:movie];
    }
    [self.navigationController pushViewController:movieDetailVC animated:true];
}
#pragma mark - Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger section = [self.reminderViewModel numberOfSectionsInTableView];
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = [self.reminderViewModel numberOfRowsInSection:section];
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RemindTableViewCell getReuseIdentifier] forIndexPath:indexPath];
    ReminderMovie *reminderMovie = [self.reminderViewModel cellForRowAtIndexPath:indexPath];
    [cell bindingData:reminderMovie];
    return cell;
}


@end
