//
//  ProfileViewModel.h
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, SectionProfileType){
    infor_profile = 0,
    reminderList
};

typedef NS_ENUM(NSInteger, InforProfileType){
    imagePath = 0,
    name,
    birthday,
    email,
    gender
};

@interface ProfileViewModel : NSObject
- (void)saveUserInUserDefault:(User *)user withKey:(NSString *)key;

- (void)loadUserFromUserDefaultWithKey:(NSString *)key completionHandler:(void(^)(void))completionHandler;


#pragma mark - Profile VC
- (NSInteger)numberOfSectionsInTableView;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSString *)inforForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Edit Profile VC
- (NSInteger)numberOfSectionsIntTableViewForEditVC;

- (NSInteger)numberOfRowsInSectionForEditVC:(NSInteger)section;

- (InforProfileType)inforProfileTypeForIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)imageForRowAtIndexPath:(NSIndexPath *)indexPath;

- (User *)getUser;

@end

NS_ASSUME_NONNULL_END
