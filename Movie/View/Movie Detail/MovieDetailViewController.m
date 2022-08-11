//
//  MovieDetailViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/28/22.
//

#import "MovieDetailViewController.h"
#import "Cell/CastCollectionViewCell.h"
#import "MovieDetailView.h"
#import "MovieDetailViewModel.h"
#import "DatePickerManager.h"
#import "CoreDataManager.h"
#import "UserNotifications/UserNotifications.h"
#import "NotificationNames.h"
#import "NSDate+Extensions.h"
@interface MovieDetailViewController ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, MovieDetailViewDelegate, DidDateSelectedDelegate, UNUserNotificationCenterDelegate>
@property(strong, nonatomic) MovieDetailView *movieDetailContentView;
@property(strong, nonatomic) UICollectionView *castCollectionView;
@property(strong, nonatomic) NSLayoutConstraint *castCollectionViewHeightConstraint;
@property(strong, nonatomic) MovieDetailViewModel *movieDetailViewModel;
@property(strong, nonatomic) UIStackView *contentStackView;
@property(strong, nonatomic) UIScrollView *scrollView;
@property(assign, nonatomic) CGFloat cellHeight;
@property(assign, nonatomic) CGFloat cellPadding;
@property(strong, nonatomic) Movie *movie;
@property(strong, nonatomic) UIView *castCrewView;
@property(strong, nonatomic) UILabel *castCrewLabel;
@property(strong, nonatomic) UIView *footerView;
@property(strong, nonatomic) CoreDataManager *coreDataManager;
@property(strong, nonatomic) id<DatePickerManagerDelegate> datePickerManager;
@property(strong, nonatomic) UNUserNotificationCenter *center;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigationBar];
    [self setup];
    [self layout];
    
    //fetch CreditsMovie
    [self fetchCreditsMovie];
    
}
#pragma mark - Navigation
-(void) configNavigationBar{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = [self.movie getTitle];

}

#pragma mark - API
-(void) fetchCreditsMovie{
    if (self.movieDetailViewModel == nil) {
        return;
    }
    __weak MovieDetailViewController *weakSelf = self;
    NSInteger movieId = [self.movie getID];
    [self.movieDetailViewModel getCreditsMovieWithMovieId:movieId withSuccess:^(NSArray<Actor *> * _Nonnull actors) {
        [weakSelf.castCollectionView reloadData];
        [self viewDidLayoutSubviews];
        
    } withError:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark - Instance Helpers

- (void)loadMovieData:(Movie *)movie{
    self.movie = movie;
    
}

#pragma mark - Helpers
-(void) setup{
    [self configViewModel];
    
    [self configCoreDataManager];
    
    [self configContentView];
    
    [self configCollectionView];
    
    [self configScrollView];
    
    [self configCastCrewView];
    
    [self configFooterView];
    
    [self configContentStackView];
    
    [self configDatePickerManager];
    
    [self configUNUserNotificationCenter];
    
    [self fillStarFavoriteOrNot];
    
    [self displayTimeOrNot];
}

-(void) displayTimeOrNot{
    [self.coreDataManager checkIfMovieHaveReminder:self.movie withSuccess:^(NSDate * _Nullable time) {
        if (time != nil) {
            [self.movieDetailContentView addRemindLabel:time];
        }
    } withError:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

-(void) fillStarFavoriteOrNot{
    [self.coreDataManager checkIfMovieIsFavorite:self.movie withSuccess:^(BOOL isFavorite) {
        if (isFavorite) {
            [self.movieDetailContentView changeImageButtonByFavorite:isFavorite];
        }
    } withError:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

-(void) configUNUserNotificationCenter{
    self.center = [UNUserNotificationCenter currentNotificationCenter];
    self.center.delegate = self;
    [self registerLocal];
}
-(void) configCoreDataManager{
    self.coreDataManager = [[CoreDataManager alloc] init];
}
-(void) configDatePickerManager{
    self.datePickerManager = [[DatePickerManager alloc] init];
}

-(void) configFooterView{
    self.footerView = [[UIView alloc] init];
    self.footerView.translatesAutoresizingMaskIntoConstraints = false;
    [self.footerView.heightAnchor constraintEqualToConstant:10].active = true;
    self.footerView.backgroundColor = [UIColor clearColor];
}

-(void) configCastCrewView{
    self.castCrewView = [[UIView alloc] init];
    self.castCrewView.translatesAutoresizingMaskIntoConstraints = false;
    self.castCrewLabel = [[UILabel alloc] init];
    self.castCrewLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    self.castCrewLabel.text = @"Cast & Crew";
    self.castCrewLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.castCrewView addSubview:self.castCrewLabel];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self configHeightCostraintCastCollectionView];
    
}

-(void) configScrollView{
    self.scrollView = [[UIScrollView alloc] init];
    [self.scrollView setFrame:self.view.bounds];
}

-(void) configContentStackView{
    self.contentStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.movieDetailContentView,self.castCrewView, self.castCollectionView, self.footerView]];
    self.contentStackView.axis = UILayoutConstraintAxisVertical;
    self.contentStackView.translatesAutoresizingMaskIntoConstraints = false;
    self.contentStackView.spacing = 0;
}

-(void) configContentView{
    self.movieDetailContentView = [[MovieDetailView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (self.movie != nil) {
        [self.movieDetailContentView bindingData:self.movie];
    }
    self.movieDetailContentView.translatesAutoresizingMaskIntoConstraints = false;
    self.movieDetailContentView.delegate = self;
}

-(void) configViewModel{
    self.movieDetailViewModel = [[MovieDetailViewModel alloc] init];
}

-(void) layout{
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentStackView];
   
    [self.castCollectionView.heightAnchor constraintEqualToConstant:self.cellHeight].active = true;
    
    [self.contentStackView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = true;
    [self.contentStackView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor].active = true;
    [self.contentStackView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor].active = true;
    [self.contentStackView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = true;
    [self.contentStackView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor].active = true;
    
    [self.castCrewLabel.topAnchor constraintEqualToAnchor:self.castCrewView.topAnchor].active = true;
    [self.castCrewLabel.leadingAnchor constraintEqualToAnchor:self.castCrewView.leadingAnchor constant:12].active = true;
    [self.castCrewLabel.bottomAnchor constraintEqualToAnchor:self.castCrewView.bottomAnchor].active = true;
    [self.castCrewLabel.trailingAnchor constraintEqualToAnchor:self.castCrewView.trailingAnchor].active = true;

}

-(void) configHeightCostraintCastCollectionView{
    self.castCollectionViewHeightConstraint = [self.castCollectionView.heightAnchor constraintEqualToConstant:50];
    [self.castCollectionViewHeightConstraint setPriority:999];
    CGFloat height = self.castCollectionView.collectionViewLayout.collectionViewContentSize.height;
    self.castCollectionViewHeightConstraint.constant = height;
    self.castCollectionViewHeightConstraint.active = true;
    [self.view layoutIfNeeded];

}
-(void) configCollectionView{
    self.cellPadding = 12;
    //self.cellPadding * 2 = top inset + bottom inset
    self.cellHeight = [CastCollectionViewCell getRowHeight] + (self.cellPadding * 2) + 12;
    UICollectionViewFlowLayout *layout = [self createCollectionViewFlowLayout];
    self.castCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.castCollectionView.delegate = self;
    self.castCollectionView.dataSource = self;
    self.castCollectionView.translatesAutoresizingMaskIntoConstraints = false;
    [self.castCollectionView registerNib:[UINib nibWithNibName:[CastCollectionViewCell getNibName] bundle:nil] forCellWithReuseIdentifier:[CastCollectionViewCell getReuseIdentifier]];
}

-(UICollectionViewFlowLayout *) createCollectionViewFlowLayout{
    CGFloat itemWidth = [CastCollectionViewCell getRowHeight];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setSectionInset:UIEdgeInsetsMake(self.cellPadding, self.cellPadding, self.cellPadding, self.cellPadding)];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setItemSize:CGSizeMake(itemWidth - 30, itemWidth + 12)];
    return layout;
}


#pragma mark - Delegate

- (void)didReminderTapped{
    [self.datePickerManager showPickerViewWithPickerType: dateTimePicker];
    self.datePickerManager.delegate = self;
}

- (void)didDateSelected:(NSDate *)date{
    [self.coreDataManager insertToCoreDataWithReminder:self.movie withTime:date withSuccess:^{
        [self.movieDetailContentView addRemindLabel:date];
        [self scheduleLocal:date withMovie:self.movie];
        [[NSNotificationCenter defaultCenter] postNotificationName:DidAddReminderNotification object:nil];
    } withError:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    
}

#pragma mark - Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    __weak MovieDetailViewController *weakSelf = self;
    NSInteger sections = [weakSelf.movieDetailViewModel numberOfSectionsInCollectionView];
    return sections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    __weak MovieDetailViewController *weakSelf = self;
    NSInteger items = [weakSelf.movieDetailViewModel numberOfItemsInSection:section];
    return items;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak MovieDetailViewController *weakSelf = self;
    CastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CastCollectionViewCell getReuseIdentifier] forIndexPath:indexPath];
    
    Actor *actor = [weakSelf.movieDetailViewModel cellForItemAtIndexPath:indexPath];
    [cell bindingData:actor];
    return cell;
}

#pragma mark - Notification Helper
-(void) registerLocal {

    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge;
    [self.center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"granted");
        }else{
            NSLog(@"no granted");
        }
    }];
}

-(void) scheduleLocal: (NSDate *) date withMovie: (Movie *)movie{
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Movie";
    NSString *body = [NSString stringWithFormat:@"Time to go get the ticket for %@", [movie getTitle]];
    content.body = body;
    content.sound = [UNNotificationSound defaultSound];
    
    NSString *movieNotificationID = [NSString stringWithFormat:@"%ld-%@", (long)[movie getID], [self generateUUID]];
    
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                  components:NSCalendarUnitYear +
                  NSCalendarUnitMonth + NSCalendarUnitDay +
                  NSCalendarUnitHour + NSCalendarUnitMinute +
                  NSCalendarUnitSecond fromDate:date];
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate
                                             repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:movieNotificationID content:content trigger:trigger];
    
    [self.center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"local push noti: %@", error);
        }
    }];

}
-(NSString *) generateUUID{
    NSUUID *uuid = [NSUUID UUID];
    NSString *str = [uuid UUIDString];
    
    return str;
}


@end
