//
//  Quiz6DetailViewController.m
//  Quiz6
//
//  Created by Steve Chakif on 3/28/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import "Quiz6DetailViewController.h"

@interface Quiz6DetailViewController ()
//- (void)configureView;
@end

@implementation Quiz6DetailViewController
@synthesize dismissBlock;

#pragma mark - Managing the detail item

/**
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}
*/
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.nameTextField setText:_task.taskName];
    [self.urgencyLabel setText:[NSString stringWithFormat:@"Urgency: %.2f",_task.urgency]];
    self.urgencySlider.value = _task.urgency;
    self.datePicker.date = _task.dueDate;
    //[self configureView];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    _task.taskName = self.nameTextField.text;
    _task.urgency = self.urgencySlider.value;
    _task.dueDate = self.datePicker.date;
    [self.navigationController popViewControllerAnimated:YES];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
    
}
- (IBAction)sliderChanged:(id)sender {
    UISlider *s = sender;
    [self.urgencyLabel setText:[NSString stringWithFormat:@"Urgency: %.2f",s.value]];
    
}

@end
