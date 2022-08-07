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

@interface EditProfileViewController ()<UITableViewDelegate, UITableViewDataSource, EditProfileHeaderTableViewCellDelegate>
@property(strong, nonatomic) AvatarView *avatarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) ProfileViewModel *profileViewModel;
@property(strong, nonatomic) User *user;
@end

@implementation EditProfileViewController
#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.profileViewModel loadUserFromUserDefaultWithKey:UserInforNameDefaults completionHandler:^{
    //        [self.tableView reloadData];
    //    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
    [self layout];
}

#pragma mark - Class Helper
+ (NSString *)getNibName{
    return @"EditProfileViewController";
}
#pragma mark - Instance Helper

#pragma mark - Helper
-(void) setup{
    [self configViewModel];
    [self configAvatarView];
    [self configTableView];
    
    
}

-(void) configViewModel{
    self.profileViewModel = [[ProfileViewModel alloc] init];
    [self.profileViewModel loadUserFromUserDefaultWithKey:UserInforNameDefaults completionHandler:^{
        [self.tableView reloadData];
        self.user = [self.profileViewModel getUser];
    }];
}

-(void) layout{
    
}

-(void) configAvatarView{
    self.avatarView = [[AvatarView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.avatarView.translatesAutoresizingMaskIntoConstraints = false;
    self.avatarView.backgroundColor = [UIColor clearColor];
    [self.avatarView configTextFiledWithBorderStyle:UITextBorderStyleRoundedRect withInteract:YES];
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
//getting data from cell
-(void) gettingDataFromCells: (User *)user{
    NSInteger sections = [self.profileViewModel numberOfSectionsIntTableViewForEditVC];
    NSInteger rows = [self.profileViewModel numberOfRowsInSectionForEditVC:sections - 1];
    for(int i = 0; i < rows; i++){
        NSIndexPath *idx = [NSIndexPath indexPathForRow:i inSection:0];
        EditTableViewCell *cell = [self.tableView cellForRowAtIndexPath:idx];
        InforProfileType type = [self.profileViewModel inforProfileTypeForIndexPath:idx];
        [cell gettingDataWithInforType:type withUser:user];
    }
}

#pragma mark - Delegate
- (void)didDoneButtonTapped:(User *)user{
    //add infor to user
    [self gettingDataFromCells:user];
    [self.profileViewModel saveUserInUserDefault:user withKey:UserInforNameDefaults];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didCancelButtonTapped{
    NSLog(@"didCancelButtonTapped from edit profile vc");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = [self.profileViewModel numberOfSectionsIntTableViewForEditVC];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = [self.profileViewModel numberOfRowsInSectionForEditVC:section];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EditTableViewCell getReuseIdentifier] forIndexPath:indexPath];
    InforProfileType type = [self.profileViewModel inforProfileTypeForIndexPath:indexPath];
    UIImage *image = [self.profileViewModel imageForRowAtIndexPath:indexPath];
    [cell bindingData:self.user withInforType:type withImage:image];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    EditProfileHeaderTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[EditProfileHeaderTableViewCell getReuseIdentifier]];
    cell.delegate = self;
    //binding avatar view
    [cell bindingData:self.user];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = [EditProfileHeaderTableViewCell getHeaderHeight];
    return height;
}

@end
