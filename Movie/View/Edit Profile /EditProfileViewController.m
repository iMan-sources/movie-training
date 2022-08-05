//
//  EditProfileViewController.m
//  Movie
//
//  Created by AnhLe on 04/08/2022.
//

#import "EditProfileViewController.h"
#import "AvatarView.h"
#import "HeaderProfileTableViewCell.h"
#import "ProfileViewModel.h"
#import "User.h"
#import "EditTableViewCell.h"
#import "UserDefaultsNames.h"
#import "EditProfileHeaderTableViewCell.h"

@interface EditProfileViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) AvatarView *avatarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) ProfileViewModel *profileViewModel;
@property(strong, nonatomic) User *user;
@end

@implementation EditProfileViewController
#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.profileViewModel loadUserFromUserDefaultWithKey:UserInforNameDefaults completionHandler:^{
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
    [self layout];
}

#pragma mark - Helper
-(void) setup{
    [self configViewModel];
    [self configAvatarView];
    [self configTableView];
    

}

-(void) configViewModel{
    self.profileViewModel = [[ProfileViewModel alloc] init];
}

-(void) layout{
    
}

+ (NSString *)getNibName{
    return @"EditProfileViewController";
}

-(void) configAvatarView{
    self.avatarView = [[AvatarView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.avatarView.translatesAutoresizingMaskIntoConstraints = false;
    self.avatarView.backgroundColor = [UIColor clearColor];
    [self.avatarView configTextFiledWithBorderStyle:UITextBorderStyleRoundedRect withInteract:YES];
}

-(void) loadUser: (ProfileViewModel *)viewModel{
    self.profileViewModel = viewModel;
}

-(void)configTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:[EditTableViewCell getNibName] bundle:nil] forCellReuseIdentifier:[EditTableViewCell getReuseIdentifier]];
    
    [self.tableView registerClass:[EditProfileHeaderTableViewCell class] forHeaderFooterViewReuseIdentifier:[EditProfileHeaderTableViewCell getReuseIdentifier]];
    
    if (@available(iOS 15.0, *)) {
          [self.tableView setSectionHeaderTopPadding:0.0f];
    }
}

#pragma mark - Delegate

#pragma mark - Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EditTableViewCell getReuseIdentifier] forIndexPath:indexPath];
    User *user = [self.profileViewModel getUser];
    InforProfileType type = [self.profileViewModel inforProfileTypeForIndexPath:indexPath];
    [cell bindingData:user withInforType:type];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    EditProfileHeaderTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[EditProfileHeaderTableViewCell getReuseIdentifier]];
    //binding avatar view
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = [EditProfileHeaderTableViewCell getHeaderHeight];
    return height;
}

@end
