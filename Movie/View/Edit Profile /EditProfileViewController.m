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

static NSInteger const SectionInTableView = 0;
@interface EditProfileViewController ()<UITableViewDelegate, UITableViewDataSource, EditProfileHeaderTableViewCellDelegate,  AvatarViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
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
    //    [self configAvatarView];
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


- (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:name];
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
        EditProfileHeaderTableViewCell *cell = (EditProfileHeaderTableViewCell *)[self.tableView headerViewForSection:SectionInTableView];
        [cell.avatarView settingImageForAvatarImageView:imagePath];
    }];
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
    cell.avatarView.delegate = self;
    
    [cell bindingData:self.user];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = [EditProfileHeaderTableViewCell getHeaderHeight];
    return height;
}


@end
