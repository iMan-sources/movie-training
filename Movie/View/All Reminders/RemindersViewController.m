//
//  RemindersViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 8/11/22.
//

#import "RemindersViewController.h"
#import "RemindTableViewCell.h"
#import "ReminderViewModel.h"
@interface RemindersViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *remindersTableView;
@property(strong, nonatomic) ReminderViewModel *reminderViewModel;
@end

@implementation RemindersViewController
#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configNavigationBar];
    [self setup];
    [self layout];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Class Helper
+ (NSString *)getNibName{
    return @"RemindersViewController";
}

#pragma mark - Helper
-(void) setup{
    [self configReminderViewModel];
    [self configTableView];
    [self loadReminderMovies];
}

-(void) configNavigationBar{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"All Reminders";
}

-(void) layout{
    
}
-(void) configTableView{
    self.remindersTableView.delegate = self;
    self.remindersTableView.dataSource = self;
    [self.remindersTableView registerNib:[UINib nibWithNibName:[RemindTableViewCell getNibName] bundle:nil] forCellReuseIdentifier:[RemindTableViewCell getReuseIdentifier]];
}

-(void) configReminderViewModel{
    self.reminderViewModel = [[ReminderViewModel alloc] init];
    
}

-(void) loadReminderMovies{
    [self.reminderViewModel fetchRemindersInCoreDataWithSuccess:^{
        [self.remindersTableView reloadData];
    } withError:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Delegate


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
