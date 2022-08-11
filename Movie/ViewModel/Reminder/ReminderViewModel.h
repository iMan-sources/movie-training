//
//  ReminderViewModel.h
//  Movie
//
//  Created by AnhLe on 11/08/2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReminderMovie.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReminderViewModel : NSObject
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
-(void) fetchRemindersInCoreDataWithSuccess: (void(^)(void)) completion withError: (void(^)(NSError *)) errorCompletion;
-(ReminderMovie *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView;
-(BOOL) checkIfHaveReminderList;
@end

NS_ASSUME_NONNULL_END
