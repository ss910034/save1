//
//  HiiiirDateSelectionViewController.m
//  HiiiirDateSelectionViewController
//
//  Created by Roland Moers on 26.10.13.
//  Copyright (c) 2013 Roland Moers
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "BillDateSelectionVC.h"
#import <QuartzCore/QuartzCore.h>

#define RM_DATE_PICKER_HEIGHT_PORTRAIT 216
#define RM_DATE_PICKER_HEIGHT_LANDSCAPE 162

#if !__has_feature(attribute_availability_app_extension)
//Normal App
#define RM_CURRENT_ORIENTATION_IS_LANDSCAPE_PREDICATE UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
#else
//App Extension
#define RM_CURRENT_ORIENTATION_IS_LANDSCAPE_PREDICATE [UIScreen mainScreen].bounds.size.height < [UIScreen mainScreen].bounds.size.width
#endif

@interface BillDateSelectionVC () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, weak) NSLayoutConstraint *xConstraint;
@property (nonatomic, weak) NSLayoutConstraint *yConstraint;
@property (nonatomic, weak) NSLayoutConstraint *widthConstraint;

@property (nonatomic, strong) UIView *titleLabelContainer;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@property (nonatomic, strong) UIView *nowButtonContainer;
@property (nonatomic, strong) UIButton *nowButton;

@property (nonatomic, strong) UIView *datePickerContainer;
@property (nonatomic, readwrite, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSLayoutConstraint *pickerHeightConstraint;

@property (nonatomic, strong) UIView *cancelAndSelectButtonContainer;
@property (nonatomic, strong) UIView *cancelAndSelectSeperator;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) UIMotionEffectGroup *motionEffectGroup;

@property (nonatomic, assign) BOOL hasBeenDismissed;

// frank liu
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *dateArray1;
@property (nonatomic, strong) NSMutableArray *dateArray2;
@property (nonatomic, strong) NSMutableArray *dateArray3;
@property (nonatomic, assign) PickerViewMode pickViewMode;

@end

@interface NSDate (Rounding)

- (NSDate *)dateByRoundingToMinutes:(NSInteger)minutes;

@end

@implementation NSDate (Rounding)

- (NSDate *)dateByRoundingToMinutes:(NSInteger)minutes {
    NSTimeInterval absoluteTime = floor([self timeIntervalSinceReferenceDate]);
    NSTimeInterval minuteInterval = minutes*60;
    
    NSTimeInterval remainder = (absoluteTime - (floor(absoluteTime/minuteInterval)*minuteInterval));
    if(remainder < 60) {
        return self;
    } else {
        NSTimeInterval remainingSeconds = minuteInterval - remainder;
        return [self dateByAddingTimeInterval:remainingSeconds];
    }
}

@end

typedef NS_ENUM(NSInteger, HiiiirDateSelectionViewControllerAnimationStyle) {
    HiiiirDateSelectionViewControllerAnimationStylePresenting,
    HiiiirDateSelectionViewControllerAnimationStyleDismissing
};

@interface HiiiirDateSelectionViewControllerAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) HiiiirDateSelectionViewControllerAnimationStyle animationStyle;

@end

@implementation HiiiirDateSelectionViewControllerAnimationController

#pragma mark - Transition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if(self.animationStyle == HiiiirDateSelectionViewControllerAnimationStylePresenting) {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        if([toVC isKindOfClass:[BillDateSelectionVC class]]) {
            BillDateSelectionVC *dateSelectionVC = (BillDateSelectionVC *)toVC;
            
            if(dateSelectionVC.disableBouncingWhenShowing) {
                return 0.3f;
            } else {
                return 1.0f;
            }
        }
    } else if(self.animationStyle == HiiiirDateSelectionViewControllerAnimationStyleDismissing) {
        return 0.3f;
    }
    
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    
    if(self.animationStyle == HiiiirDateSelectionViewControllerAnimationStylePresenting) {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        if([toVC isKindOfClass:[BillDateSelectionVC class]]) {
            BillDateSelectionVC *dateSelectionVC = (BillDateSelectionVC *)toVC;
            
            dateSelectionVC.backgroundView.alpha = 0;
            [containerView addSubview:dateSelectionVC.backgroundView];
            [containerView addSubview:dateSelectionVC.view];
            
            NSDictionary *bindingsDict = @{@"Container": containerView, @"BGView": dateSelectionVC.backgroundView};
            
            [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[BGView]-(0)-|" options:0 metrics:nil views:bindingsDict]];
            [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[BGView]-(0)-|" options:0 metrics:nil views:bindingsDict]];
            
            if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
                if(RM_CURRENT_ORIENTATION_IS_LANDSCAPE_PREDICATE) {
                    dateSelectionVC.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_LANDSCAPE;
                } else {
                    dateSelectionVC.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_PORTRAIT;
                }
            }
            
            dateSelectionVC.xConstraint = [NSLayoutConstraint constraintWithItem:dateSelectionVC.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            dateSelectionVC.yConstraint = [NSLayoutConstraint constraintWithItem:dateSelectionVC.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            dateSelectionVC.widthConstraint = [NSLayoutConstraint constraintWithItem:dateSelectionVC.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
            
            [containerView addConstraint:dateSelectionVC.xConstraint];
            [containerView addConstraint:dateSelectionVC.yConstraint];
            [containerView addConstraint:dateSelectionVC.widthConstraint];
            
            [containerView setNeedsUpdateConstraints];
            [containerView layoutIfNeeded];
            
            [containerView removeConstraint:dateSelectionVC.yConstraint];
            dateSelectionVC.yConstraint = [NSLayoutConstraint constraintWithItem:dateSelectionVC.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
            [containerView addConstraint:dateSelectionVC.yConstraint];
            
            [containerView setNeedsUpdateConstraints];
            
            CGFloat damping = 1.0f;
            CGFloat duration = 0.3f;
            if(!dateSelectionVC.disableBouncingWhenShowing) {
                damping = 0.6f;
                duration = 1.0f;
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
                dateSelectionVC.backgroundView.alpha = 1;
                
                [containerView layoutIfNeeded];
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }
    } else if(self.animationStyle == HiiiirDateSelectionViewControllerAnimationStyleDismissing) {
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        if([fromVC isKindOfClass:[BillDateSelectionVC class]]) {
            BillDateSelectionVC *dateSelectionVC = (BillDateSelectionVC *)fromVC;
            
            [containerView removeConstraint:dateSelectionVC.yConstraint];
            dateSelectionVC.yConstraint = [NSLayoutConstraint constraintWithItem:dateSelectionVC.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            [containerView addConstraint:dateSelectionVC.yConstraint];
            
            [containerView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                dateSelectionVC.backgroundView.alpha = 0;
                
                [containerView layoutIfNeeded];
            } completion:^(BOOL finished) {
                [dateSelectionVC.view removeFromSuperview];
                [dateSelectionVC.backgroundView removeFromSuperview];
                
                dateSelectionVC.hasBeenDismissed = NO;
                [transitionContext completeTransition:YES];
            }];
        }
    }
}

@end

@implementation BillDateSelectionVC
// frank liu
@synthesize dateArray;
@synthesize dateArray1;
@synthesize dateArray2;
@synthesize dateArray3;
@synthesize pickViewMode;
@synthesize frankPicker;
@synthesize setYear;
@synthesize setMonth;
@synthesize setDay;
@synthesize setDate;
@synthesize data;
@synthesize selRow;
@synthesize data1;
@synthesize data2;
@synthesize selRow1;
@synthesize selRow2;
@synthesize setHour;
@synthesize setMinute;
@synthesize minutesAry;
@synthesize hoursAry;
@synthesize daysAry;
@synthesize weeksAry;

@synthesize selectedBackgroundColor = _selectedBackgroundColor;
@synthesize disableMotionEffects = _disableMotionEffects;

#pragma mark - Class
+ (instancetype)dateSelectionController:(PickerViewMode)pickerMode withYear:(int)year withMonth:(int)month endDay:(int)day hour:(int)hour minute:(int)minute
{
    return [[BillDateSelectionVC alloc]init:pickerMode withYear:year withMonth:month endDay:day hour:hour minute:minute];
}

+ (instancetype)oneRowelectionController:(PickerViewMode)pickerMode data:(NSArray *)data defRow:(int)defRow
{
    return [[BillDateSelectionVC alloc]init:CUSTOME data:data defRow:defRow];
}

+ (instancetype)towRowelectionController:(PickerViewMode)pickerMode data1:(NSArray *)data1 data2:(NSArray *)data2 defRow1:(int)defRow1 defRow2:(int)defRow2
{
    return [[BillDateSelectionVC alloc]init:TWOCOLUM data1:data1 data2:data2 defRow1:defRow1 defRow2:defRow2];
}

+ (instancetype)towRowChangedSelectionController:(PickerViewMode)pickerMode
                                           data1:(NSArray *)dataAry1
                                           data2:(NSArray *)dataAry2
                                         minutes:(NSArray *)minutes
                                           hours:(NSArray *)hours
                                            days:(NSArray *)days
                                           weeks:(NSArray *)weeks
                                         repeats:(NSArray *)repeats
                                         defRow1:(int)defRow1
                                         defRow2:(int)defRow2
{
    return [[BillDateSelectionVC alloc]init:pickerMode
                                      data1:(NSArray *)dataAry1
                                      data2:(NSArray *)dataAry2
                                    minutes:minutes
                                      hours:hours
                                       days:days
                                      weeks:weeks
                                    repeats:repeats
                                    defRow1:defRow1
                                    defRow2:defRow2];
}

static NSString *_localizedNowTitle = @"Now";
static NSString *_localizedCancelTitle = @"取消";
static NSString *_localizedSelectTitle = @"確定";
static UIImage *_selectImage;
static UIImage *_cancelImage;

+ (NSString *)localizedTitleForNowButton {
    return _localizedNowTitle;
}

+ (NSString *)localizedTitleForCancelButton {
    // return _localizedCancelTitle;
    return @"取消";
}

+ (NSString *)localizedTitleForSelectButton {
    // return _localizedSelectTitle;
    return @"確定";
}

+ (void)setLocalizedTitleForNowButton:(NSString *)newLocalizedTitle {
    _localizedNowTitle = newLocalizedTitle;
}

+ (void)setLocalizedTitleForCancelButton:(NSString *)newLocalizedTitle {
    _localizedCancelTitle = newLocalizedTitle;
}

+ (void)setLocalizedTitleForSelectButton:(NSString *)newLocalizedTitle {
    _localizedSelectTitle = newLocalizedTitle;
}

+ (UIImage *)imageForSelectButton {
    return _selectImage;
}

+ (UIImage *)imageForCancelButton {
    return _cancelImage;
}

+ (void)setImageForSelectButton:(UIImage *)newImage {
    _selectImage = newImage;
}

+ (void)setImageForCancelButton:(UIImage *)newImage {
    _cancelImage = newImage;
}

#pragma mark - Init and Dealloc
- (id)init:(PickerViewMode)mode withYear:(int)year withMonth:(int)month endDay:(int)day hour:(int)hour minute:(int)minute
{
    self = [super init];
    if(self) {
        // frank liu
        pickViewMode = mode;
        
        self.setYear  = (year != 0) ? year  : 1974;
        self.setMonth = (month != 0) ? month : 5;
        self.setDay   = (day != 0) ? day   : 25;
        self.setHour = hour;
        self.setMinute = minute;
    
        self.setDate = [NSDate date];
        
        self.blurEffectStyle = UIBlurEffectStyleExtraLight;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        } else {
            self.modalPresentationStyle = UIModalPresentationCustom;
        }
        
        self.transitioningDelegate = self;
        
        [self setupUIElements];
        self.hideNowButton = YES;
    }
    return self;
}

- (id)init:(PickerViewMode)mode data:(NSArray *)dataAry defRow:(int)defRow
{
    self = [super init];
    if(self) {
        // frank liu
        pickViewMode = mode;
        self.selRow = defRow;
        self.data = dataAry;
        
        self.blurEffectStyle = UIBlurEffectStyleExtraLight;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        } else {
            self.modalPresentationStyle = UIModalPresentationCustom;
        }
        
        self.transitioningDelegate = self;
        
        [self setupUIElements];
        self.hideNowButton = YES;
    }
    return self;
}

- (id)init:(PickerViewMode)mode data1:(NSArray *)dataAry1 data2:(NSArray *)dataAry2 defRow1:(int)defRow1 defRow2:(int)defRow2
{
    self = [super init];
    if(self) {
        // frank liu
        pickViewMode = mode;
        self.selRow1 = defRow1;
        self.selRow2 = defRow2;
        self.data1 = dataAry1;
        self.data2 = dataAry2;
        
        self.blurEffectStyle = UIBlurEffectStyleExtraLight;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        } else {
            self.modalPresentationStyle = UIModalPresentationCustom;
        }
        
        self.transitioningDelegate = self;
        
        [self setupUIElements];
        self.hideNowButton = YES;
    }
    return self;
}

- (id)init:(PickerViewMode)mode
     data1:(NSArray *)dataAry1
     data2:(NSArray *)dataAry2
   minutes:(NSArray *)minutes
     hours:(NSArray *)hours
      days:(NSArray *)days
     weeks:(NSArray *)weeks
   repeats:(NSArray *)repeats
   defRow1:(int)defRow1
   defRow2:(int)defRow2
{
    self = [super init];
    if(self) {
        // frank liu
        pickViewMode    = mode;
        self.selRow1    = defRow1;
        self.selRow2    = defRow2;
        self.data1      = dataAry1;
        self.data2      = dataAry2;
        self.minutesAry = minutes;
        self.hoursAry   = hours;
        self.daysAry    = days;
        self.weeksAry   = weeks;
        self.repeatsAry = repeats;
        
        self.blurEffectStyle = UIBlurEffectStyleExtraLight;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        } else {
            self.modalPresentationStyle = UIModalPresentationCustom;
        }
        
        self.transitioningDelegate = self;
        
        [self setupUIElements];
        self.hideNowButton = YES;
    }
    return self;
}

- (void)setupUIElements {
    //Instantiate elements
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nowButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    if (self.pickViewMode == DATEMODE) {
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        self.datePicker.minuteInterval = 1;
        
        // frank chuang
        NSDateComponents *dateComponets = [[NSDateComponents alloc] init];
        dateComponets.minute = 5;
        NSCalendar *calendar = NSCalendar.currentCalendar;
        NSDate *currentDate = [[NSDate alloc]init];
        NSDate *newDate = [calendar dateByAddingComponents:dateComponets toDate:currentDate options:NSCalendarMatchStrictly];
        self.datePicker.minimumDate = newDate;
        
        // frank liu
        // self.datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:self.setDay];
        [comps setMonth:self.setMonth];
        [comps setYear:self.setYear];
        [comps setHour:self.setHour];
        [comps setMinute:self.setMinute];
        
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // frank liu
        gregorian.timeZone = [NSTimeZone localTimeZone];
        self.datePicker.date = [gregorian dateFromComponents:comps];
    }
    else if(self.pickViewMode == TWODATE){
        self.frankPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        
        // frank liu
        self.frankPicker.delegate = (id)self;
        self.frankPicker.dataSource = (id)self;
        
        [self setupTwoDateMode];
    }
    else if(self.pickViewMode == TWOCOLUM){
        self.frankPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        
        // frank liu
        self.frankPicker.delegate = (id)self;
        self.frankPicker.dataSource = (id)self;
        
        [self setupTwoColumnMode];
    }
    else if(self.pickViewMode == CHANGEDTWOCOLUM){
        self.frankPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        
        // frank liu
        self.frankPicker.delegate = (id)self;
        self.frankPicker.dataSource = (id)self;
        
        [self setupChangedTwoColumnMode];
    }
    else if(self.pickViewMode == THREEDATE){
        self.frankPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        
        // frank liu
        self.frankPicker.delegate = (id)self;
        self.frankPicker.dataSource = (id)self;
        
        [self setupThreeDateMode];
    }
    else{
        self.frankPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        
        // frank liu
        self.frankPicker.delegate = (id)self;
        self.frankPicker.dataSource = (id)self;
        
        if (pickViewMode == DATEYEAR) {
            [self setupYear];
        }
        else if (pickViewMode == DATEMONTH)
            [self setupMonth];
        else if(pickViewMode == DATEDAY)
            [self setupDay];
        else
            [self setupCustom:self.selRow];
    }
    
    self.cancelAndSelectSeperator = [[UIView alloc] initWithFrame:CGRectZero];
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.selectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    //Setup properties of elements
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    
    [self.nowButton setTitle:[BillDateSelectionVC localizedTitleForNowButton] forState:UIControlStateNormal];
    [self.nowButton addTarget:self action:@selector(nowButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.nowButton.titleLabel.font = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
    self.nowButton.backgroundColor = [UIColor clearColor];
    self.nowButton.layer.cornerRadius = 4;
    self.nowButton.clipsToBounds = YES;
    self.nowButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (self.pickViewMode == DATEMODE) {
        self.datePicker.layer.cornerRadius = 4;
        self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    }
    else{
        self.frankPicker.layer.cornerRadius = 4;
        self.frankPicker.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    if ([BillDateSelectionVC imageForSelectButton]) {
        [self.cancelButton setImage:[BillDateSelectionVC imageForCancelButton] forState:UIControlStateNormal];
    } else {
        [self.cancelButton setTitle:[BillDateSelectionVC localizedTitleForCancelButton] forState:UIControlStateNormal];
    }
    
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
    self.cancelButton.layer.cornerRadius = 4;
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cancelButton setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    if ([BillDateSelectionVC imageForSelectButton]) {
        [self.selectButton setImage:[BillDateSelectionVC imageForSelectButton] forState:UIControlStateNormal];
    } else {
        [self.selectButton setTitle:[BillDateSelectionVC localizedTitleForSelectButton] forState:UIControlStateNormal];
    }
    
    [self.selectButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.selectButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    self.selectButton.layer.cornerRadius = 4;
    self.selectButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.selectButton setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setupTwoDateMode
{
    dateArray1 = [NSMutableArray new];
    dateArray2 = [NSMutableArray new];
    
    for (int i = 1 ; i <= 12; i++) {
        [dateArray1 addObject:[NSString stringWithFormat:@"%d 月",i]];
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    for (int i = 1950; i <= 2030; i++) {
        [dateArray2 addObject:[NSString stringWithFormat:@"%d 年",i]];
    }
    
    [self.frankPicker selectRow:self.setMonth - 1 inComponent:0 animated:NO];
    [self.frankPicker selectRow:self.setYear - 1950 inComponent:1 animated:NO];
}

- (void)setupTwoColumnMode
{
    dateArray1 = [[NSMutableArray alloc]initWithArray:self.data1];
    dateArray2 = [[NSMutableArray alloc]initWithArray:self.data2];

    [self.frankPicker selectRow:0 inComponent:0 animated:NO];
    [self.frankPicker selectRow:0 inComponent:1 animated:NO];
}

- (void)setupChangedTwoColumnMode
{
    dateArray1 = [[NSMutableArray alloc]initWithArray:self.data1];
    dateArray2 = [[NSMutableArray alloc]initWithArray:self.data2];
    
    [self.frankPicker selectRow:self.selRow1 inComponent:0 animated:NO];
    [self.frankPicker selectRow:self.selRow2 inComponent:1 animated:NO];
}

- (void)setupThreeDateMode
{
    dateArray1 = [NSMutableArray new];
    dateArray2 = [NSMutableArray new];
    dateArray3 = [NSMutableArray new];
    
    for (int i = 1 ; i <= 31; i++) {
        [dateArray3 addObject:[NSString stringWithFormat:@"%d日",i]];
    }
    
    for (int i = 1 ; i <= 12; i++) {
        [dateArray2 addObject:[NSString stringWithFormat:@"%d月",i]];
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    for (int i = 1930; i <= 2030; i++) {
        [dateArray1 addObject:[NSString stringWithFormat:@"%d年",i]];
    }
    
    [self.frankPicker selectRow:self.setDay - 1 inComponent:2 animated:NO];
    [self.frankPicker selectRow:self.setMonth - 1 inComponent:1 animated:NO];
    [self.frankPicker selectRow:self.setYear - 1930 inComponent:0 animated:NO];
}

- (void)setupYear
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    dateArray = [[NSMutableArray alloc] init];
    for (int i = 1950; i <= 2030; i++) {
        [dateArray addObject:[NSString stringWithFormat:@"%d 年",i]];
    }
    
    [self.frankPicker selectRow:self.setYear - 1950 inComponent:0 animated:NO];
}

- (void)setupMonth
{
    dateArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i <= 12; i++) {
        [dateArray addObject:[NSString stringWithFormat:@"%d 月",i]];
    }
    
    [self.frankPicker selectRow:self.setMonth - 1 inComponent:0 animated:NO];
}

- (void)setupDay
{
    dateArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i <= 31; i++) {
        [dateArray addObject:[NSString stringWithFormat:@"%d 日",i]];
    }
    
    [self.frankPicker selectRow:self.setDay - 1 inComponent:0 animated:NO];
}

- (void)setupCustom:(int)defRow
{
    // dateArray = [[NSMutableArray alloc] init];
    dateArray = (NSMutableArray *)[NSArray arrayWithArray:self.data];
    
    [self.frankPicker selectRow:defRow inComponent:0 animated:NO];
}

// frank liu
- (NSInteger)numberOfComponentsInPickerView: (UIPickerView*)thePickerView
{
    if(pickViewMode == TWODATE || pickViewMode == TWOCOLUM || pickViewMode == CHANGEDTWOCOLUM)
        return 2;
    else if(pickViewMode == THREEDATE)
        return 3;
    else
        return 1;
}

// frank liu
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickViewMode == TWODATE )
        return (component == 0) ? self.dateArray1.count : self.dateArray2.count;
    
    if (pickViewMode == CHANGEDTWOCOLUM) {
        if (component == 1) {
            return self.dateArray2.count;
        }
        if (self.selRow2 == 0) {
            return minutesAry.count;
        }
        else if (self.selRow2 == 1 ){
            return hoursAry.count;
        }
        else if (self.selRow2 == 2){
            return daysAry.count;
        }
        else if (self.selRow2 == 3){
            return weeksAry.count;
        }
    }
    if (pickViewMode == TWOCOLUM) {
        if (component == 0) {
            return self.dateArray1.count;
        }
        else{
            return [self.dateArray2[self.selRow1] count];
        }
    }
    
    if (pickViewMode == THREEDATE) {
        if (component == 0) {
            return self.dateArray1.count;
        }
        else if(component == 1)
            return self.dateArray2.count;
        else
            return self.dateArray3.count;
    }
    
    return [self.dateArray count];
}

// frank liu
- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickViewMode == TWODATE)
        return (component == 0) ? [self.dateArray1 objectAtIndex:row] : [self.dateArray2 objectAtIndex:row];
    
    if (pickViewMode == CHANGEDTWOCOLUM){
        if (component == 0) {
            // [self.dateArray1 removeAllObjects];
            if (selRow2 == 0) {
                self.dateArray1 = (NSMutableArray *)minutesAry;
            }
            else if (selRow2 == 1){
                self.dateArray1 = (NSMutableArray *)hoursAry;
            }
            else if (selRow2 == 2){
                self.dateArray1 = (NSMutableArray *)daysAry;
            }
            else if (selRow2 == 3){
                self.dateArray1 = (NSMutableArray *)weeksAry;
            }
            return [self.dateArray1 objectAtIndex:row];
        }
        else{
            return [self.dateArray2 objectAtIndex:row];
        }
    }
    
    if (pickViewMode == TWOCOLUM) {
        if (component == 0) {
            return [self.dateArray1 objectAtIndex:row];
        }
        else{
            NSArray *tmp = self.dateArray2[self.selRow1];
            return [tmp objectAtIndex:row];
        }
    }
    
    if (pickViewMode == THREEDATE) {
        if (component == 0) {
            return [self.dateArray1 objectAtIndex:row];
        }
        else if(component == 1){
            return [self.dateArray2 objectAtIndex:row];
        }
        else{
            return [self.dateArray3 objectAtIndex:row];
        }
    }
    
    return [self.dateArray objectAtIndex:row];
}

// frank liu
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickViewMode == CUSTOME) {
        self.selRow = (int)row;
    }
    
    else if (pickViewMode == TWOCOLUM) {
        if (component == 0) {
            self.selRow1 = (int)row;
            [pickerView reloadComponent:1];
        }
        else{
            self.selRow2 = (int)row;
        }
    }
    
    else if (pickViewMode == CHANGEDTWOCOLUM) {
        if (component == 0) {
            self.selRow1 = (int)row;
        }
        else{
            self.selRow2 = (int)row;
            [pickerView reloadComponent:0];
        }
    }
}

- (void)setupContainerElements {
    if(!self.disableBlurEffects) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:self.blurEffectStyle];
        UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
        
        UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancy];
        vibrancyView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.titleLabelContainer = [[UIVisualEffectView alloc] initWithEffect:blur];
        [((UIVisualEffectView *)self.titleLabelContainer).contentView addSubview:vibrancyView];
    } else {
        self.titleLabelContainer = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    if(!self.disableBlurEffects) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:self.blurEffectStyle];
        UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
        
        UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancy];
        vibrancyView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.nowButtonContainer = [[UIVisualEffectView alloc] initWithEffect:blur];
        [((UIVisualEffectView *)self.nowButtonContainer).contentView addSubview:vibrancyView];
    } else {
        self.nowButtonContainer = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    if(!self.disableBlurEffects) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:self.blurEffectStyle];
        UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
        
        UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancy];
        vibrancyView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.datePickerContainer = [[UIVisualEffectView alloc] initWithEffect:blur];
        [((UIVisualEffectView *)self.datePickerContainer).contentView addSubview:vibrancyView];
    } else {
        self.datePickerContainer = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    if(!self.disableBlurEffects) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:self.blurEffectStyle];
        UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
        
        UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancy];
        vibrancyView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.cancelAndSelectButtonContainer = [[UIVisualEffectView alloc] initWithEffect:blur];
        [((UIVisualEffectView *)self.cancelAndSelectButtonContainer).contentView addSubview:vibrancyView];
    } else {
        self.cancelAndSelectButtonContainer = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    if(!self.disableBlurEffects) {
        [[[[[(UIVisualEffectView *)self.titleLabelContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.titleLabel];
        [[[[[(UIVisualEffectView *)self.nowButtonContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.nowButton];
        
        // frank liu
        if (self.pickViewMode == DATEMODE) {
            [[[[[(UIVisualEffectView *)self.datePickerContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.datePicker];
            [[[[[(UIVisualEffectView *)self.datePickerContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.datePicker];
            [[[[[(UIVisualEffectView *)self.datePickerContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.datePicker];
        }
        else{
            [[[[[(UIVisualEffectView *)self.datePickerContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.frankPicker];
            [[[[[(UIVisualEffectView *)self.datePickerContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.frankPicker];
            [[[[[(UIVisualEffectView *)self.datePickerContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.frankPicker];
        }
        
        [[[[[(UIVisualEffectView *)self.cancelAndSelectButtonContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.cancelAndSelectSeperator];
        [[[[[(UIVisualEffectView *)self.cancelAndSelectButtonContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.cancelButton];
        [[[[[(UIVisualEffectView *)self.cancelAndSelectButtonContainer contentView] subviews] objectAtIndex:0] contentView] addSubview:self.selectButton];
        
        self.titleLabelContainer.backgroundColor = [UIColor clearColor];
        self.nowButtonContainer.backgroundColor = [UIColor clearColor];
        self.datePickerContainer.backgroundColor = [UIColor clearColor];
        self.cancelAndSelectButtonContainer.backgroundColor = [UIColor clearColor];
    } else {
        [self.titleLabelContainer addSubview:self.titleLabel];
        [self.nowButtonContainer addSubview:self.nowButton];
        
        // frank liu
        if (pickViewMode == DATEMODE) {
            [self.datePickerContainer addSubview:self.datePicker];
        }
        else{
            [self.datePickerContainer addSubview:self.frankPicker];
        }
        
        [self.cancelAndSelectButtonContainer addSubview:self.cancelAndSelectSeperator];
        [self.cancelAndSelectButtonContainer addSubview:self.cancelButton];
        [self.cancelAndSelectButtonContainer addSubview:self.selectButton];
        
        self.titleLabelContainer.backgroundColor = [UIColor whiteColor];
        self.nowButtonContainer.backgroundColor = [UIColor whiteColor];
        self.datePickerContainer.backgroundColor = [UIColor whiteColor];
        self.cancelAndSelectButtonContainer.backgroundColor = [UIColor whiteColor];
    }
    
    self.titleLabelContainer.layer.cornerRadius = 4;
    self.titleLabelContainer.clipsToBounds = YES;
    self.titleLabelContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.nowButtonContainer.layer.cornerRadius = 4;
    self.nowButtonContainer.clipsToBounds = YES;
    self.nowButtonContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.datePickerContainer.layer.cornerRadius = 4;
    self.datePickerContainer.clipsToBounds = YES;
    self.datePickerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.cancelAndSelectButtonContainer.layer.cornerRadius = 4;
    self.cancelAndSelectButtonContainer.clipsToBounds = YES;
    self.cancelAndSelectButtonContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.cancelAndSelectSeperator.backgroundColor = [UIColor lightGrayColor];
    self.cancelAndSelectSeperator.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupConstraints {
    UIView *pickerContainer = self.datePickerContainer;
    UIView *cancelSelectContainer = self.cancelAndSelectButtonContainer;
    UIView *seperator = self.cancelAndSelectSeperator;
    UIButton *cancel = self.cancelButton;
    UIButton *select = self.selectButton;
    
    // frank liu
    id picker;
    
    if (self.pickViewMode == DATEMODE) {
        picker = self.datePicker;
    }
    else
        picker = self.frankPicker;
    
    UIView *labelContainer = self.titleLabelContainer;
    UILabel *label = self.titleLabel;
    UIButton *now = self.nowButton;
    UIView *nowContainer = self.nowButtonContainer;
    
    NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(cancelSelectContainer, seperator, pickerContainer, cancel, select, picker, labelContainer, label, now, nowContainer);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(10)-[pickerContainer]-(10)-|" options:0 metrics:nil views:bindingsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(10)-[cancelSelectContainer]-(10)-|" options:0 metrics:nil views:bindingsDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pickerContainer]-(10)-[cancelSelectContainer(44)]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    self.pickerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.datePickerContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:RM_DATE_PICKER_HEIGHT_PORTRAIT];
    [self.view addConstraint:self.pickerHeightConstraint];
    
    [self.datePickerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[picker]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    [self.cancelAndSelectButtonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[cancel]-(0)-[seperator(0.5)]-(0)-[select]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    [self.cancelAndSelectButtonContainer addConstraint:[NSLayoutConstraint constraintWithItem:self.cancelAndSelectSeperator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.cancelAndSelectButtonContainer attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self.datePickerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[picker]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    [self.cancelAndSelectButtonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[cancel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    [self.cancelAndSelectButtonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[seperator]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    [self.cancelAndSelectButtonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[select]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    
    BOOL showTitle = self.titleLabel.text && self.titleLabel.text.length != 0;
    BOOL showNowButton = !self.hideNowButton;
    
    if(showNowButton) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(10)-[nowContainer]-(10)-|" options:0 metrics:nil views:bindingsDict]];
        
        [self.nowButtonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[now]-(0)-|" options:0 metrics:nil views:bindingsDict]];
        [self.nowButtonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[now]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    }
    
    if(showTitle) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(10)-[labelContainer]-(10)-|" options:0 metrics:nil views:bindingsDict]];
        
        [self.titleLabelContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(10)-[label]-(10)-|" options:0 metrics:nil views:bindingsDict]];
        [self.titleLabelContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[label]-(10)-|" options:0 metrics:nil views:bindingsDict]];
    }
    
    NSDictionary *metricsDict = @{@"TopMargin": @(self.modalPresentationStyle == UIModalPresentationPopover ? 10 : 0)};
    
    if(showNowButton && showTitle) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(TopMargin)-[labelContainer]-(10)-[now(44)]-(10)-[pickerContainer]" options:0 metrics:metricsDict views:bindingsDict]];
    } else if(showNowButton && !showTitle) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(TopMargin)-[nowContainer(44)]-(10)-[pickerContainer]" options:0 metrics:metricsDict views:bindingsDict]];
    } else if(!showNowButton && showTitle) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(TopMargin)-[labelContainer]-(10)-[pickerContainer]" options:0 metrics:metricsDict views:bindingsDict]];
    } else if(!showNowButton && !showTitle) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(TopMargin)-[pickerContainer]" options:0 metrics:metricsDict views:bindingsDict]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.layer.masksToBounds = YES;
    
    [self setupContainerElements];
    
    if(self.titleLabel.text && self.titleLabel.text.length != 0) {
        [self.view addSubview:self.titleLabelContainer];
    }
    
    if(!self.hideNowButton) {
        [self.view addSubview:self.nowButtonContainer];
    }
    
    [self.view addSubview:self.datePickerContainer];
    [self.view addSubview:self.cancelAndSelectButtonContainer];
    
    [self setupConstraints];
    
    if(self.disableBlurEffects) {
        if(self.tintColor) {
            self.nowButton.tintColor = self.tintColor;
            self.cancelButton.tintColor = self.tintColor;
            self.selectButton.tintColor = self.tintColor;
        } else {
            self.nowButton.tintColor = [UIColor colorWithRed:0 green:122./255. blue:1 alpha:1];
            self.cancelButton.tintColor = [UIColor colorWithRed:0 green:122./255. blue:1 alpha:1];
            self.selectButton.tintColor = [UIColor colorWithRed:0 green:122./255. blue:1 alpha:1];
        }
    }
    
    if(self.backgroundColor) {
        if(!self.disableBlurEffects) {
            [((UIVisualEffectView *)self.titleLabelContainer).contentView setBackgroundColor:self.backgroundColor];
            [((UIVisualEffectView *)self.nowButtonContainer).contentView setBackgroundColor:self.backgroundColor];
            [((UIVisualEffectView *)self.datePickerContainer).contentView setBackgroundColor:self.backgroundColor];
            [((UIVisualEffectView *)self.cancelAndSelectButtonContainer).contentView setBackgroundColor:self.backgroundColor];
        } else {
            self.titleLabelContainer.backgroundColor = self.backgroundColor;
            self.nowButtonContainer.backgroundColor = self.backgroundColor;
            self.datePickerContainer.backgroundColor = self.backgroundColor;
            self.cancelAndSelectButtonContainer.backgroundColor = self.backgroundColor;
        }
    }
    
    if(self.selectedBackgroundColor) {
        if(!self.disableBlurEffects) {
            [self.nowButton setBackgroundImage:[self imageWithColor:[self.selectedBackgroundColor colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
            [self.cancelButton setBackgroundImage:[self imageWithColor:[self.selectedBackgroundColor colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
            [self.selectButton setBackgroundImage:[self imageWithColor:[self.selectedBackgroundColor colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
        } else {
            [self.nowButton setBackgroundImage:[self imageWithColor:self.selectedBackgroundColor] forState:UIControlStateHighlighted];
            [self.cancelButton setBackgroundImage:[self imageWithColor:self.selectedBackgroundColor] forState:UIControlStateHighlighted];
            [self.selectButton setBackgroundImage:[self imageWithColor:self.selectedBackgroundColor] forState:UIControlStateHighlighted];
        }
    }
    
    if(!self.disableMotionEffects) {
        [self addMotionEffects];
    }
    
    if([self respondsToSelector:@selector(popoverPresentationController)]) {
        CGSize minimalSize = [self.view systemLayoutSizeFittingSize:CGSizeMake(999, 999)];
        self.preferredContentSize = CGSizeMake(minimalSize.width, minimalSize.height+10);
        self.popoverPresentationController.backgroundColor = self.backgroundView.backgroundColor;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Date selection controller will appear, so it hasn't been dismissed, right?
    self.hasBeenDismissed = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    [super viewDidDisappear:animated];
}

#pragma mark - Orientation
- (void)didRotate {
    NSTimeInterval duration = 0.4;
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        duration = 0.3;
        
        if(RM_CURRENT_ORIENTATION_IS_LANDSCAPE_PREDICATE) {
            self.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_LANDSCAPE;
        } else {
            self.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_PORTRAIT;
        }
        
        // frank liu
        if (self.pickViewMode == DATEMODE) {
            [self.datePicker setNeedsUpdateConstraints];
            [self.datePicker layoutIfNeeded];
        }
        else{
            [self.frankPicker setNeedsUpdateConstraints];
            [self.frankPicker layoutIfNeeded];
        }
    }
    
    [self.view.superview setNeedsUpdateConstraints];
    __weak BillDateSelectionVC *blockself = self;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [blockself.view.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - Helper
- (void)addMotionEffects {
    [self.view addMotionEffect:self.motionEffectGroup];
}

- (void)removeMotionEffects {
    [self.view removeMotionEffect:self.motionEffectGroup];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Custom Properties
- (BOOL)disableBlurEffects {
    if(!NSClassFromString(@"UIBlurEffect") || !NSClassFromString(@"UIVibrancyEffect") || !NSClassFromString(@"UIVisualEffectView")) {
        return YES;
    } else if(&UIAccessibilityIsReduceTransparencyEnabled && UIAccessibilityIsReduceTransparencyEnabled()) {
        return YES;
    }
    
    return _disableBlurEffects;
}

- (BOOL)disableMotionEffects {
    if(&UIAccessibilityIsReduceMotionEnabled && UIAccessibilityIsReduceMotionEnabled()) {
        return YES;
    }
    
    return _disableMotionEffects;
}

- (void)setDisableMotionEffects:(BOOL)newDisableMotionEffects {
    if(_disableMotionEffects != newDisableMotionEffects) {
        _disableMotionEffects = newDisableMotionEffects;
        
        if([self isViewLoaded]) {
            if(newDisableMotionEffects) {
                [self removeMotionEffects];
            } else {
                [self addMotionEffects];
            }
        }
    }
}

- (BOOL)disableBouncingWhenShowing {
    if(&UIAccessibilityIsReduceMotionEnabled && UIAccessibilityIsReduceMotionEnabled()) {
        return YES;
    }
    
    return _disableBouncingWhenShowing;
}

- (UIMotionEffectGroup *)motionEffectGroup {
    if(!_motionEffectGroup) {
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-10);
        verticalMotionEffect.maximumRelativeValue = @(10);
        
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-10);
        horizontalMotionEffect.maximumRelativeValue = @(10);
        
        _motionEffectGroup = [UIMotionEffectGroup new];
        _motionEffectGroup.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    }
    
    return _motionEffectGroup;
}

- (UIView *)backgroundView {
    if(!_backgroundView) {
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped:)];
        [_backgroundView addGestureRecognizer:tapRecognizer];
    }
    
    return _backgroundView;
}

- (void)setTintColor:(UIColor *)newTintColor {
    if(_tintColor != newTintColor) {
        _tintColor = newTintColor;
        
        if(!self.disableBlurEffects)
        {
            // frank liu
            if (self.pickViewMode == DATEMODE) {
                self.datePicker.tintColor = newTintColor;
            }
            else{
                self.frankPicker.tintColor = newTintColor;
            }
        }
        
        self.nowButton.tintColor = newTintColor;
        self.cancelButton.tintColor = newTintColor;
        self.selectButton.tintColor = newTintColor;
    }
}

- (void)setBackgroundColor:(UIColor *)newBackgroundColor {
    if(_backgroundColor != newBackgroundColor) {
        _backgroundColor = newBackgroundColor;
        
        if([self isViewLoaded]) {
            if(!self.disableBlurEffects &&
               [self.titleLabelContainer isKindOfClass:[UIVisualEffectView class]] &&
               [self.nowButtonContainer isKindOfClass:[UIVisualEffectView class]] &&
               [self.datePickerContainer isKindOfClass:[UIVisualEffectView class]] &&
               [self.cancelAndSelectButtonContainer isKindOfClass:[UIVisualEffectView class]]) {
                [((UIVisualEffectView *)self.titleLabelContainer).contentView setBackgroundColor:newBackgroundColor];
                [((UIVisualEffectView *)self.nowButtonContainer).contentView setBackgroundColor:newBackgroundColor];
                [((UIVisualEffectView *)self.datePickerContainer).contentView setBackgroundColor:newBackgroundColor];
                [((UIVisualEffectView *)self.cancelAndSelectButtonContainer).contentView setBackgroundColor:newBackgroundColor];
            } else {
                self.titleLabelContainer.backgroundColor = newBackgroundColor;
                self.nowButtonContainer.backgroundColor = newBackgroundColor;
                self.datePickerContainer.backgroundColor = newBackgroundColor;
                self.cancelAndSelectButtonContainer.backgroundColor = newBackgroundColor;
            }
        }
    }
}

- (UIColor *)selectedBackgroundColor {
    if(!_selectedBackgroundColor) {
        self.selectedBackgroundColor = [UIColor colorWithWhite:230./255. alpha:1];
    }
    
    return _selectedBackgroundColor;
}

- (void)setSelectedBackgroundColor:(UIColor *)newSelectedBackgroundColor {
    if(_selectedBackgroundColor != newSelectedBackgroundColor) {
        _selectedBackgroundColor = newSelectedBackgroundColor;
        
        if(!self.disableBlurEffects) {
            [self.nowButton setBackgroundImage:[self imageWithColor:[newSelectedBackgroundColor colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
            [self.cancelButton setBackgroundImage:[self imageWithColor:[newSelectedBackgroundColor colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
            [self.selectButton setBackgroundImage:[self imageWithColor:[newSelectedBackgroundColor colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
        } else {
            [self.nowButton setBackgroundImage:[self imageWithColor:newSelectedBackgroundColor] forState:UIControlStateHighlighted];
            [self.cancelButton setBackgroundImage:[self imageWithColor:newSelectedBackgroundColor] forState:UIControlStateHighlighted];
            [self.selectButton setBackgroundImage:[self imageWithColor:newSelectedBackgroundColor] forState:UIControlStateHighlighted];
        }
    }
}

#pragma mark - Custom Transitions
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    HiiiirDateSelectionViewControllerAnimationController *animationController = [[HiiiirDateSelectionViewControllerAnimationController alloc] init];
    animationController.animationStyle = HiiiirDateSelectionViewControllerAnimationStylePresenting;
    
    return animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    HiiiirDateSelectionViewControllerAnimationController *animationController = [[HiiiirDateSelectionViewControllerAnimationController alloc] init];
    animationController.animationStyle = HiiiirDateSelectionViewControllerAnimationStyleDismissing;
    
    return animationController;
}

#pragma mark - Actions
- (IBAction)doneButtonPressed:(id)sender {
    if(!self.hasBeenDismissed) {
        self.hasBeenDismissed = YES;
        
       // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(self.selectButtonAction && pickViewMode == DATEMODE) {
                self.selectButtonAction(self, self.datePicker.date);
            }
            else if(self.frankSelection2Block && pickViewMode == TWODATE){
                NSArray *ary = [NSArray arrayWithObjects:self.dateArray1[[self.frankPicker selectedRowInComponent:0]],
                                self.dateArray2[[self.frankPicker selectedRowInComponent:1]], nil];
                self.frankSelection2Block(self, ary);
            }
            else if(self.frankSelection3Block && pickViewMode == THREEDATE){
                NSArray *ary = [NSArray arrayWithObjects:self.dateArray1[[self.frankPicker selectedRowInComponent:0]],
                                self.dateArray2[[self.frankPicker selectedRowInComponent:1]],
                                self.dateArray3[[self.frankPicker selectedRowInComponent:2]],nil];
                self.frankSelection3Block(self, ary);
            }
            else if(self.frankSelectionOneRow && pickViewMode == CUSTOME)
            {
                self.frankSelectionOneRow(self, self.dateArray[[self.frankPicker selectedRowInComponent:0]], selRow);
            }
            else if((self.frankSelection2Block_1) && pickViewMode == TWOCOLUM){
                NSArray *tmp = self.dateArray2[self.selRow1];
                self.frankSelection2Block_1(self, self.dateArray1[[self.frankPicker selectedRowInComponent:0]], tmp[[self.frankPicker selectedRowInComponent:1]], self.selRow1, self.selRow2);
            }
            else if((self.frankSelectionChanged2Block) && pickViewMode == CHANGEDTWOCOLUM){
                self.frankSelectionChanged2Block(self, self.dateArray1[[self.frankPicker selectedRowInComponent:0]], self.dateArray2[[self.frankPicker selectedRowInComponent:1]], self.selRow1, self.selRow2);
            }
            else if(self.frankSelectionBlock){
                self.frankSelectionBlock(self, self.dateArray[[self.frankPicker selectedRowInComponent:0]]);
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
       // });
    }

}

- (IBAction)cancelButtonPressed:(id)sender {
    if(!self.hasBeenDismissed) {
        self.hasBeenDismissed = YES;
        
        if(self.cancelButtonAction) {
            self.cancelButtonAction(self);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)nowButtonPressed:(id)sender {
    if(self.nowButtonAction) {
        self.nowButtonAction(self);
    } else {
        [self.datePicker setDate:[[NSDate date] dateByRoundingToMinutes:self.datePicker.minuteInterval]];
    }
}

- (IBAction)backgroundViewTapped:(UIGestureRecognizer *)sender {
    if(!self.backgroundTapsDisabled) {
        [self cancelButtonPressed:sender];
    }
}

- (void)showIn:(UIViewController *)parent withTarget:(UIViewController *)target
{
    self.disableBouncingWhenShowing = NO;
    self.disableMotionEffects = NO;
    self.disableBlurEffects = YES;
    self.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];

    [parent presentViewController:target animated:YES completion:nil];
}
@end
