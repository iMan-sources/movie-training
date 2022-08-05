//
//  ProfileViewModel.m
//  Movie
//
//  Created by AnhVT12.REC on 8/4/22.
//

#import "ProfileViewModel.h"
#import <UIKit/UIKit.h>
#import "NSDate+Extensions.h"

const int SectionProfileTypeCount = reminderList - infor_profile + 1;
const int InforProfileTypeCount = (gender - birdthday + 1);

@interface ProfileViewModel()
@property(strong, nonatomic) User *user;
@property(strong, nonatomic) NSArray *reminderList;
@end
@implementation ProfileViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.reminderList = @[];
    }
    return self;
}

#pragma mark - Helper
-(void) saveUserInUserDefault: (User *)user withKey: (NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[user getName] forKey: @"name"];
    [dict setValue:[user getGender] forKey: @"gender"];
    [dict setValue:[user getBirthDay] forKey: @"date"];
    [dict setValue:[user getImagePath] forKey: @"imagePath"];
    [dict setValue:[user getEmail] forKey:@"email"];
    [defaults setObject:dict forKey:key];
}

-(void) loadUserFromUserDefaultWithKey: (NSString *) key completionHandler: (void(^)(void)) completionHandler{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *encodedUser = [defaults objectForKey:key];
    
    self.user = [self generateUserFromDictionary:encodedUser];
    
    completionHandler();
}

-(User *) generateUserFromDictionary: (NSDictionary *)dict{
    NSString *name = [dict objectForKey:@"name"];
    NSString *gender = [dict objectForKey:@"gender"];
    NSString *imagePath = [dict objectForKey:@"imagePath"];
    NSDate *birthday = [dict objectForKey:@"date"];
    NSString *email = [dict objectForKey:@"email"];
    User *user = [[User alloc] initWithName:name withBirthday:birthday withGender:gender withImagePath:imagePath withEmail:email];
    
    return user;
}

-(NSString *) inforWithInforProfileType: (InforProfileType) type{
    switch (type) {
        case imagePath: {
            {
                NSString *imagePath = [self.user getImagePath];
                return imagePath;
            }
        case name:
            {
                NSString *name = [self.user getName];
                return name;
            }
        case birdthday:
            {
                NSDate *date = [self.user getBirthDay];
                NSString *dateString = [date convertDateToString];
                return dateString;
            }
        case email:
            {
                NSString *email = [self.user getEmail];
                return email;
            }
        case gender:
            {
                NSString *gender = [self.user getGender];
                return gender;
            }
        }
    }
}

- (BOOL)checkIfHaveReminderList{
    BOOL haveReminderList = self.reminderList.count > 0;
    return haveReminderList;
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView{
    //size of SectionProfileType enum
    return SectionProfileTypeCount;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return InforProfileTypeCount;
    }
    NSInteger reminderListRows = self.reminderList.count;
    return reminderListRows;
    
}

- (NSString *)inforForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger row = indexPath.row;
    InforProfileType type = [self inforProfileTypeForIndexPath:indexPath];
    NSString *infor = [self inforWithInforProfileType:type];
    return infor;
}

-(InforProfileType) inforProfileTypeForIndexPath: (NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    InforProfileType type = birdthday;
    //iterate InforProfileTypeCount to define type -> infor
    for (int i = birdthday; i <= gender; i++) {
        if (i == row + birdthday) {
            type = i;
            break;
        }
    }
    return type;
}

-(User *)getUser{
    return self.user;
}

@end
