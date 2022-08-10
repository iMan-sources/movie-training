//
//  YearPickerActionTableViewCell.m
//  Movie
//
//  Created by AnhLe on 09/08/2022.
//

#import "YearPickerActionTableViewCell.h"
#import "SettingsViewModel.h"
@interface YearPickerActionTableViewCell()<UIPickerViewDelegate, UIPickerViewDataSource>
@property(strong, nonatomic) NSMutableArray *years;
@property(strong, nonatomic) UIPickerView *pickerView;
@property(strong, nonatomic) SettingsViewModel *settingsViewModel;
@end
@implementation YearPickerActionTableViewCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        [self layout];
        self.settingsViewModel = [[SettingsViewModel alloc] init];
        
        [self setSelectedRow];
    }
    return self;
    
}

#pragma mark - Class Helper
+ (NSString *)getReuseIdentifier{
    return @"YearPickerActionTableViewCell";
}

#pragma mark - Helper
-(void) setup{
    [self configYearSelections];
    [self configYearPicker];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void) layout{
    [self.contentView addSubview:self.pickerView];
    [self.pickerView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8].active = true;
    [self.pickerView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8].active = true;
    [self.pickerView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8].active = true;
    [self.pickerView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8].active = true;

}

-(void) configYearPicker{
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.translatesAutoresizingMaskIntoConstraints = false;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.pickerView setValue:[UIColor blackColor] forKey:@"textColor"];
    self.pickerView.layer.cornerRadius = 10;
    self.pickerView.layer.masksToBounds = YES;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    
    [self.pickerView reloadAllComponents];

}

-(void) configYearSelections{
    self.years = [[NSMutableArray alloc] initWithArray:@[]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int currentYear = [[formatter stringFromDate:[NSDate date]] intValue];
    
    for (int i = 1960;  i <= currentYear; i++) {
        [self.years addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
}



#pragma mark - Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *year = self.years[row];
    [self.delegate didYearPickerSelectedWithYear:year];
}


#pragma mark - Datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.years.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.years objectAtIndex:row];
}

-(void) setSelectedRow{
    NSInteger selectedRow = [self.settingsViewModel loadYearSettingsInUserDefault:self.years];
    [self.pickerView selectRow:selectedRow inComponent:0 animated:YES];
}

#pragma mark - Action


@end
