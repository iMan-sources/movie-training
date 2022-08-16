//
//  DatePickerManager.m
//  Movie
//
//  Created by AnhLe on 07/08/2022.
//

#import "DatePickerManager.h"
#import "NSString+Extensions.h"
#import "ActionFooterTableViewCell.h"
static NSInteger const DatePickerHeight = 300;
@interface DatePickerManager()<UITableViewDelegate, UITableViewDataSource, ActionFooterTableViewCellDelegate, YearPickerActionTableViewCellDelegate, DatePickerActionTableViewCellDelegate>

@property(strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) UITableView *actionSheetTableView;
@property(nonatomic) PickerType pickerType;

@end

@implementation DatePickerManager
#pragma mark - Helper

#pragma mark - Config Views
- (void)configMaskView{
    self.maskView = [[UIView alloc] init];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.maskView.alpha = 0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismissal:)];
    [self.maskView setUserInteractionEnabled:YES];
    [self.maskView addGestureRecognizer:tapGesture];
}

- (void)configWindow{
    UIScene *scene = [[[[UIApplication sharedApplication] connectedScenes] allObjects] firstObject];
    
    if([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]){
        self.window = [(id <UIWindowSceneDelegate>)scene.delegate window];
    }
    
}

- (void)configActionSheetTableView{
    self.actionSheetTableView = [[UITableView alloc] init];
    [self.actionSheetTableView registerClass:[DatePickerActionTableViewCell class] forCellReuseIdentifier:[DatePickerActionTableViewCell getReuseIdentifier]];
    
    [self.actionSheetTableView registerClass:[YearPickerActionTableViewCell class] forCellReuseIdentifier:[YearPickerActionTableViewCell getReuseIdentifier]];
    
    [self.actionSheetTableView registerNib:[UINib nibWithNibName:[ActionFooterTableViewCell getNibName] bundle:nil] forHeaderFooterViewReuseIdentifier:[ActionFooterTableViewCell getReuseIdentifier]];
    
    self.actionSheetTableView.backgroundColor = [UIColor clearColor];
    self.actionSheetTableView.rowHeight = UITableViewAutomaticDimension;
    self.actionSheetTableView.delegate = self;
    self.actionSheetTableView.dataSource = self;
    self.actionSheetTableView.estimatedRowHeight = 200.0;
    self.actionSheetTableView.scrollEnabled = NO;
    
    if (@available(iOS 15.0, *)) {
        [self.actionSheetTableView setSectionHeaderTopPadding:0.0f];
    }
    
}

- (void)setup{
    [self configWindow];
    [self configMaskView];
    [self.maskView setFrame:self.window.frame];
    [self.window addSubview:self.maskView];
    
    [self configActionSheetTableView];
    
    [self.window addSubview:self.actionSheetTableView];
    [self.actionSheetTableView setFrame:CGRectMake(0, self.window.bounds.size.height, self.window.bounds.size.width, DatePickerHeight)];
    
}

#pragma mark - Show & Dimiss Actionsheet
- (void)showActionSheet:(BOOL)shouldShow{
    CGRect rect = self.actionSheetTableView.frame;
    rect.origin.y = shouldShow ? self.window.bounds.size.height - DatePickerHeight : self.window.bounds.size.height;
    self.actionSheetTableView.frame = rect;
}

- (void)dismissActionSheet{
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.maskView.alpha = 0;
        [self showActionSheet:NO];
    } completion:nil];
}

#pragma mark - Blocks

- (void)showPickerViewWithPickerType:(PickerType)pickerType{
    [self setup];
    self.pickerType = pickerType;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.maskView.alpha = 1;
        [self showActionSheet:YES];
    } completion:nil];
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (void)didCancelButtonTapped{
    [self dismissActionSheet];
   
}

- (void)didSelectButtonTapped{
    
    [self.delegate didDateSelected: self.date];
    [self dismissActionSheet];
    
}

//selected Year delegate
- (void)didYearPickerSelectedWithYear:(NSString *)year{
    //convert year to date
    self.date = [year convertStringToYear];
}

//selected date picker delegate
- (void)didDatePickerSelected:(NSDate *)date{
    self.date = date;
}

#pragma mark - Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch(self.pickerType){
        case yearPicker:
        {
            YearPickerActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YearPickerActionTableViewCell getReuseIdentifier] forIndexPath:indexPath];
            [self.actionSheetTableView setNeedsLayout];
            [self.actionSheetTableView layoutIfNeeded];
            cell.delegate = self;
   
            return cell;
        }
        default:
        {
            DatePickerActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DatePickerActionTableViewCell getReuseIdentifier] forIndexPath:indexPath];
            [self.actionSheetTableView setNeedsLayout];
            [self.actionSheetTableView layoutIfNeeded];
            cell.delegate = self;
            
            [cell bindingData: self.pickerType];
            return cell;
        }

    }
    
    return [[UITableViewCell alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    ActionFooterTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[ActionFooterTableViewCell getReuseIdentifier]];
    //    cell.tintColor = [UIColor whiteColor];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50.0;
}


#pragma mark - Action

-(void)handleDismissal:(UITapGestureRecognizer *)sender{
    [self dismissActionSheet];
}


@synthesize delegate;

@end
