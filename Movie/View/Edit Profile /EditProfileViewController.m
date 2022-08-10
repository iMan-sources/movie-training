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
#import "UserDefaultsNames.h"
#import "EditProfileHeaderView.h"
#import "BirthdayView.h"
#import "DatePickerManager.h"
#import "GenderView.h"
#import "EmailView.h"
#import "BirthdayView.h"
@interface EditProfileViewController ()<EditProfileHeaderViewDelegate, AvatarViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BirthdayViewDelegate, DidDateSelectedDelegate>
@property(strong, nonatomic) ProfileViewModel *profileViewModel;
@property(strong, nonatomic) User *user;
@property(strong, nonatomic) EditProfileHeaderView *headerView;
@property(strong, nonatomic) id<DatePickerManagerDelegate> datePickeManager;
@property(strong, nonatomic) UIStackView *mainStackView;
@property(strong, nonatomic) GenderView *genderView;
@property(strong, nonatomic) BirthdayView *birthdayView;
@property(strong, nonatomic) EmailView *emailView;
@end

@implementation EditProfileViewController
#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

    [self configHeaderView];
    [self configStackView];
    
    [self configDatePickerManager];
}

-(void) configHeaderView{
    self.headerView = [[EditProfileHeaderView alloc] init];
    self.headerView.translatesAutoresizingMaskIntoConstraints = false;
    self.headerView.delegate = self;
}
-(void) configDatePickerManager{
    self.datePickeManager = [[DatePickerManager alloc] init];
}

-(void) configViewModel{
    self.profileViewModel = [[ProfileViewModel alloc] init];
    [self.profileViewModel loadUserFromUserDefaultWithKey:UserInforNameDefaults completionHandler:^{
        self.user = [self.profileViewModel getUser];
    }];
}

-(void) configStackView{
    self.genderView = [[GenderView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.birthdayView = [[BirthdayView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.emailView = [[EmailView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.mainStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.birthdayView, self.emailView, self.genderView]];
    self.mainStackView.axis = UILayoutConstraintAxisVertical;
    self.mainStackView.translatesAutoresizingMaskIntoConstraints = false;
    self.mainStackView.spacing = 12;
    
    [self.genderView bindingData:[self.user getGender]];
    [self.birthdayView bindingData:[self.user getBirthDay]];
    [self.emailView bindingData:[self.user getEmail]];

    self.birthdayView.delegate = self;
    self.headerView.avatarView.delegate = self;
    
}

-(void) layout{
    [self.view addSubview:self.headerView];
    [self.headerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = true;
    [self.headerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:12].active = true;
    [self.headerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-12].active = true;
    [self.headerView.heightAnchor constraintEqualToConstant:150].active = true;
    
    [self.view addSubview:self.mainStackView];
    [self.mainStackView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:12].active = true;
    [self.mainStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:12].active = true;
    [self.mainStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-12].active = true;
    
}

-(void) getData{
    [self.user setWithGender:[self.genderView getGender]];
    [self.user setWithBirthday:[self.birthdayView getDate]];
    [self.user setWithEmail:[self.emailView getEmail]];
    [self.user setWithName: [self.headerView.avatarView getName]];
    [self.user setWithImagePath:[self.headerView.avatarView getImagePath]];
    
}


- (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:name];
}

#pragma mark - Delegate
- (void)didDoneButtonTapped{
    //add infor to user
    
    [self getData];
    [self.profileViewModel saveUserInUserDefault:self.user withKey:UserInforNameDefaults];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didCancelButtonTapped{
    NSLog(@"didCancelButtonTapped from edit profile vc");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didAvatarViewTapped{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    // Get image data. Here you can use UIImagePNGRepresentation if you need transparency
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1);
    
    // Get image path in user's folder and store file with name image_CurrentTimestamp.jpg (see documentsPathForFileName below)
    NSString *imagePath = [self documentsPathForFileName:[NSString stringWithFormat:@"image_%f.jpg", [NSDate timeIntervalSinceReferenceDate]]];
    
    // Write image data to user's folder
    [imageData writeToFile:imagePath atomically:YES];
    
    [picker dismissViewControllerAnimated:YES completion:^{
//        EditProfileHeaderView *cell = (EditProfileHeaderView *)[self.tableView headerViewForSection:SectionInTableView];
        [self.headerView.avatarView settingImageForAvatarImageView:imagePath];
    }];
}

- (void)didDateSelected:(NSDate *)date{

    [self.birthdayView bindingData:date];
    [self.user setWithBirthday:date];
    
}

#pragma mark - Datasource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSInteger sections = [self.profileViewModel numberOfSectionsIntTableViewForEditVC];
//    return sections;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSInteger rows = [self.profileViewModel numberOfRowsInSectionForEditVC:section];
//    return rows;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    EditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EditTableViewCell getReuseIdentifier] forIndexPath:indexPath];
//    InforProfileType type = [self.profileViewModel inforProfileTypeForIndexPath:indexPath];
//
//    if (type == birthday) {
//        cell.delegate = self;
//    }
//
//    UIImage *image = [self.profileViewModel imageForRowAtIndexPath:indexPath];
//    [cell bindingData:self.user withInforType:type withImage:image];
//    return cell;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    EditProfileHeaderTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[EditProfileHeaderTableViewCell getReuseIdentifier]];
//    cell.delegate = self;
//    //binding avatar view
//    cell.avatarView.delegate = self;
//
//    [cell bindingData:self.user];
//
//    return cell;
//}
//


- (void)didBirthdayLabelTapped{
    [self.datePickeManager showPickerViewWithViewController:self withPickerType:datePicker];
    self.datePickeManager.delegate = self;
}

@end
