//
//  HiiiirDateSelectionViewController.h
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PickerViewMode)
{
    DATEMODE        = 0,
    DATEYEAR        = 1,
    DATEMONTH       = 2,
    DATEDAY         = 3,
    TWODATE         = 4,
    THREEDATE       = 5,
    CUSTOME         = 6,
    TWOCOLUM        = 7,
    CHANGEDTWOCOLUM = 8
};

/**
 *  HiiiirDateSelectionViewController is an iOS control for selecting a date using UIDatePicker in a UIActionSheet like fashon. When a HiiiirDateSelectionViewController is shown the user gets the opportunity to select a date using a UIDatePicker.
 *
 *  HiiiirDateSelectionViewController supports bouncing effects when animating the date selection view controller. In addition, motion effects are supported while showing the date selection view controller. Both effects can be disabled by using the properties called disableBouncingWhenShowing and disableMotionEffects.
 *
 *  On iOS 8 and later Apple opened up their API for blurring the background of UIViews. HiiiirDateSelectionViewController makes use of this API. The type of the blur effect can be changed by using the blurEffectStyle property. If you want to disable the blur effect you can do so by using the disableBlurEffects property.
 *
 *  @warning HiiiirDateSelectionViewController is not designed to be reused. Each time you want to display a HiiiirDateSelectionViewController a new instance should be created. If you want to set a specific date before displaying, you can do so by using the datePicker property.
 */
@interface BillDateSelectionVC : UIViewController

/// @name Getting an Instance

/**
 *  This returns a new instance of HiiiirDateSelectionViewController.
 *
 *  @warning Always use this class method to get an instance. Do not initialize an instance yourself.
 *
 *  @return  Returns a new instance of HiiiirDateSelectionViewController
 */
+ (instancetype)dateSelectionController:(PickerViewMode)pickerMode withYear:(int)year withMonth:(int)month endDay:(int)day hour:(int)hour minute:(int)minute;

+ (instancetype)oneRowelectionController:(PickerViewMode)pickerMode data:(NSArray *)data defRow:(int)defRow;

+ (instancetype)towRowelectionController:(PickerViewMode)pickerMode data1:(NSArray *)data1 data2:(NSArray *)data2 defRow1:(int)defRow1 defRow2:(int)defRow2;

+ (instancetype)towRowChangedSelectionController:(PickerViewMode)pickerMode
                                           data1:(NSArray *)dataAry1
                                           data2:(NSArray *)dataAry2
                                         minutes:(NSArray *)minutes
                                           hours:(NSArray *)hours
                                            days:(NSArray *)days
                                           weeks:(NSArray *)weeks
                                         repeats:(NSArray *)repeats
                                         defRow1:(int)defRow1
                                         defRow2:(int)defRow2;

// frank liu
- (id)init:(PickerViewMode)mode data1:(NSArray *)dataAry1 data2:(NSArray *)dataAry2 defRow1:(int)defRow1 defRow2:(int)defRow2;

// frank liu
- (id)init:(PickerViewMode)mode
     data1:(NSArray *)dataAry1
     data2:(NSArray *)dataAry2
   minutes:(NSArray *)minutes
     hours:(NSArray *)hours
      days:(NSArray *)days
     weeks:(NSArray *)weeks
   repeats:(NSArray *)repeats
   defRow1:(int)defRow1
   defRow2:(int)defRow2;

/// @name Localization

/**
 *  Set a localized title for the now button. Default title is 'Now'.
 *
 *  @param newLocalizedTitle    The new localized title for the now button.
 */
+ (void)setLocalizedTitleForNowButton:(NSString *)newLocalizedTitle;

/**
 *  Set a localized title for the cancel button. Default title is 'Cancel'.
 *
 *  @param newLocalizedTitle    The new localized title for the cancel button.
 */
+ (void)setLocalizedTitleForCancelButton:(NSString *)newLocalizedTitle;

/**
 *  Set a localized title for the select button. Default is 'Select'.
 *
 *  @param newLocalizedTitle    The new localized title for the select button.
 */
+ (void)setLocalizedTitleForSelectButton:(NSString *)newLocalizedTitle;

/**
 *  Set a image for the select button. Default is nil.
 *
 *  @param newImage    The new image for the select button.
 */
+ (void)setImageForSelectButton:(UIImage *)newImage;

/**
 *  Set a image for the cancel button. Default is nil.
 *
 *  @param newImage    The new image for the cancel button.
 */
+ (void)setImageForCancelButton:(UIImage *)newImage;

/// @name Block Support

/**
 *  The block that is executed when the now button is tapped.
 *
 *  @warning Setting this block is optional. The default behavior of the now button is to set the date picker to the current date. Only use this property, if you want to override this default behavior.
 */
@property (nonatomic, copy) void (^nowButtonAction)(BillDateSelectionVC *controller);

/**
 *  The block that is executed when the select button is tapped.
 *
 *  @warning Although your app won't crash when presenting a HiiiirDateSelectionViewController without a select block, setting this block is not really optional. You will need this block to get the date selected by the user.
 */
@property (nonatomic, copy) void (^selectButtonAction)(BillDateSelectionVC *controller, NSDate *date);

// frank liu
@property (nonatomic, copy) void (^frankSelectionBlock)(BillDateSelectionVC *vc, NSString *dateStr);

@property (nonatomic, copy) void (^frankSelection2Block)(BillDateSelectionVC *vc, NSArray *dateAry);

// frank liu
@property (nonatomic, copy) void (^frankSelection2Block_1)(BillDateSelectionVC *vc, NSString *string1, NSString *string2, int homeRow, int roomRow);

// frank liu
@property (nonatomic, copy) void (^frankSelectionChanged2Block)(BillDateSelectionVC *vc, NSString *string1, NSString *string2, int row1, int row2);

// frank liu
@property (nonatomic, copy) void (^frankSelection3Block)(BillDateSelectionVC *vc, NSArray *dateAry);

@property (nonatomic, copy) void (^frankSelectionOneRow)(BillDateSelectionVC *vc, NSString *data, int selRow);

/**
 *  The block that is executed when the cancel button or the background view is tapped.
 *
 *  @warning Setting this block is optional. the default behavior of HiiiirDateSelectionViewController already dismisses the view controller when select or cancel is tapped.
 */
@property (nonatomic, copy) void (^cancelButtonAction)(BillDateSelectionVC *controller);

/// @name User Interface

/**
 *  Will return the instance of UIDatePicker that is used.
 */
@property (nonatomic, readonly) UIDatePicker *datePicker;

// frank liu
@property (nonatomic, strong) UIPickerView *frankPicker;

// frank liu
@property (nonatomic, assign) NSInteger setYear;
@property (nonatomic, assign) NSInteger setMonth;
@property (nonatomic, assign) NSInteger setDay;
@property (nonatomic, assign) NSInteger setHour;
@property (nonatomic, assign) NSInteger setMinute;
@property (nonatomic, assign) NSDate    *setDate;
@property (nonatomic, strong) NSArray   *data;
// frank liu for custom picker
@property (nonatomic, strong) NSArray   *data1;
@property (nonatomic, strong) NSArray   *data2;
@property (nonatomic, assign) int       selRow1;
@property (nonatomic, assign) int       selRow2;
@property (nonatomic, assign) int       selRow;

// frank liu for changed 2 block
@property (nonatomic, strong) NSArray   *minutesAry;
@property (nonatomic, strong) NSArray   *hoursAry;
@property (nonatomic, strong) NSArray   *daysAry;
@property (nonatomic, strong) NSArray   *weeksAry;
@property (nonatomic, strong) NSArray   *repeatsAry;

/**
 *  Will return the label that is used as a title for the picker. You can use this property to set a title and to customize the appearance of the title.
 *
 *  @warning If you want to set a title, be sure to set it before showing the picker view controller as otherwise the title will not be shown.
 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/**
 *  When YES the now button is hidden. Default value is NO.
 *
 *  @warning If you want to change this property you must do this before showing the HiiiirDateSelectionViewController or otherwise setting this property has no effect.
 */
@property (assign, nonatomic) BOOL hideNowButton;

/**
 *  When YES taps on the background view are ignored. Default value is NO.
 */
@property (assign, nonatomic) BOOL backgroundTapsDisabled;

/// @name Appearance

/**
 *  Used to set the text color of the buttons but not the date picker.
 */
@property (strong, nonatomic) UIColor *tintColor;

/**
 *  Used to set the background color.
 */
@property (strong, nonatomic) UIColor *backgroundColor;

/**
 *  Used to set the background color when the user selets a button.
 */
@property (strong, nonatomic) UIColor *selectedBackgroundColor;

/// @name Effects

/**
 *  Used to enable or disable motion effects. Default value is NO.
 *
 *  @warning This property always returns YES, if motion is reduced via accessibilty options.
 */
@property (assign, nonatomic) BOOL disableMotionEffects;

/**
 *  Used to enable or disable bouncing effects when sliding in the date selection view. Default value is NO.
 *
 *  @warning This property always returns YES, if motion is reduced via accessibilty options.
 */
@property (assign, nonatomic) BOOL disableBouncingWhenShowing;

/**
 *  Used to enable or disable blurring the date selection view. Default value is NO.
 *
 *  @warning This property always returns YES if either UIBlurEffect, UIVibrancyEffect or UIVisualEffectView is not available on your system at runtime or transparency is reduced via accessibility options.
 */
@property (assign, nonatomic) BOOL disableBlurEffects;

/**
 *  Used to choose a particular blur effect style (default value is UIBlurEffectStyleExtraLight). The value ir ignored if blur effects are disabled.
 */
@property (assign, nonatomic) UIBlurEffectStyle blurEffectStyle;

- (void) showIn:(UIViewController *)parent withTarget:(UIViewController *)target;

@end
