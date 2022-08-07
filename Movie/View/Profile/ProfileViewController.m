//
//  ProfileViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "ProfileViewController.h"
#import "MainViewController.h"
#import "AvatarView.h"
#import "Cell/Header Cell/HeaderProfileTableViewCell.h"
#import "Cell/ProfileTableViewCell.h"
#import "Cell/Footer Cell/ProfileFooterTableViewCell.h"
#import "ProfileViewModel.h"
#import "User.h"
#import "UserDefaultsNames.h"
@interface ProfileViewController()<UITableViewDelegate, UITableViewDataSource, ProfileFooterTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileTrailingConstraint;
@property (strong, nonatomic) ProfileViewModel *profileViewModel;
@end
@implementation ProfileViewController

#pragma mark - Lifecycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.profileViewModel != nil) {
        [self loadInforUser];
    }
}

-(User *)createUserForTest{
    NSDateFormatter *mmddccyy = [[NSDateFormatter alloc] init];
    mmddccyy.timeStyle = NSDateFormatterNoStyle;
    mmddccyy.dateFormat = @"MM/dd/yyyy";
    NSDate *d = [mmddccyy dateFromString:@"12/11/2005"];
    
    User *user = [[User alloc] initWithName:@"Anh le" withBirthday:d withGender:@"Male" withImagePath:@"" withEmail:@"anhbeo.jacky@gmail.com"];
    return user;
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setup];
    [self layout];
}


#pragma mark - Action

#pragma mark - Helper

-(void) setup{
    [self configProfileViewModel];
    [self configProfileTableView];
//    [self.profileViewModel saveUserInUserDefault:[self createUserForTest] withKey:UserInforNameDefaults];
}

-(void) loadInforUser{
    [self.profileViewModel loadUserFromUserDefaultWithKey:UserInforNameDefaults completionHandler:^{
        
        [self.profileTableView reloadData];
    }];
}

-(void) layout{
    CGFloat trailingPadding = UIScreen.mainScreen.bounds.size.width * (1 - CoefficientWidthInSreen);
    self.profileTrailingConstraint.constant = trailingPadding;
}
    

-(void) configProfileViewModel{
    self.profileViewModel = [[ProfileViewModel alloc] init];
}

-(void) configProfileTableView{
    self.profileTableView.delegate = self;
    self.profileTableView.dataSource = self;
    self.profileTableView.rowHeight = 40.0;
    [self.profileTableView registerClass:[HeaderProfileTableViewCell class] forHeaderFooterViewReuseIdentifier:[HeaderProfileTableViewCell getReuseIdentifier]];
    [self.profileTableView registerNib:[UINib nibWithNibName:[ProfileTableViewCell getNibName] bundle:nil] forCellReuseIdentifier:[ProfileTableViewCell getReuseIdentifier]];
    
    [self.profileTableView registerNib:[UINib nibWithNibName:[ProfileFooterTableViewCell getReuseIdentifier] bundle:nil] forHeaderFooterViewReuseIdentifier:[ProfileFooterTableViewCell getReuseIdentifier]];
    
    if (@available(iOS 15.0, *)) {
          [self.profileTableView setSectionHeaderTopPadding:0.0f];
    }
}


#pragma mark - Delegate

- (void)didFooterButtonTapped:(NSInteger)tag{
    [self.delegate didButtonInProfileVCTapped:tag];
}


#pragma mark - Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = [self.profileViewModel numberOfSectionsInTableView];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = [self.profileViewModel numberOfRowsInSection:section];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProfileTableViewCell getReuseIdentifier] forIndexPath:indexPath];
    NSString *infor = [self.profileViewModel inforForRowAtIndexPath:indexPath];
    UIImage *image = [self.profileViewModel imageForRowAtIndexPath:indexPath];
    [cell bindingData: infor withImage:image];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    User *user = [self.profileViewModel getUser];
    if (section == 0) {
        HeaderProfileTableViewCell *headerCell  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[HeaderProfileTableViewCell getReuseIdentifier]];
        [headerCell bindingData:user];
        return headerCell;
    }
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    return tmpView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ProfileFooterTableViewCell *footerCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[ProfileFooterTableViewCell getReuseIdentifier]];
    footerCell.delegate = self;
    if (section == 0) {
        [footerCell bindingLabelButton:@"Edit"];
        return footerCell;
    }
    if ([self.profileViewModel checkIfHaveReminderList]) {
        [footerCell bindingLabelButton:@"Show All"];
        return footerCell;
    }
    [footerCell setButtonTag:section];
    //return empty view
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    return tmpView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [HeaderProfileTableViewCell getHeaderViewHeight];
    }
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40.0;
}


@end
