//
//  Quiz6DetailViewController.h
//  Quiz6
//
//  Created by Steve Chakif on 3/28/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"

@interface Quiz6DetailViewController : UIViewController <UITextFieldDelegate>

//@property (strong, nonatomic) id detailItem;

//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;


@property (nonatomic, retain) Tasks *task;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *urgencyLabel;
@property (weak, nonatomic) IBOutlet UISlider *urgencySlider;
- (IBAction)sliderChanged:(id)sender;

@property (nonatomic, copy) void (^dismissBlock)(void);

@end
