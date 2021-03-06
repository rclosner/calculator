//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Ryan Closner on 2/17/13.
//  Copyright (c) 2013 Ryan Closner. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

- (CalculatorBrain *)brain
{
    if (!brain) brain = [[CalculatorBrain alloc] init];
    return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [[sender titleLabel] text];
    
    if (userIsInTheMiddleOfTypingANumber) {
        [display setText:[[display text] stringByAppendingString:digit]];
    } else {
        [display setText:digit];
        userIsInTheMiddleOfTypingANumber = YES;
    }
}

- (IBAction)operationPressed:(UIButton *)sender
{
    if (userIsInTheMiddleOfTypingANumber){
        [[self brain] setOperand:[[display text] doubleValue]];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    
    NSString *operation = [[sender titleLabel] text];
    double result = [[self brain] performOperation:operation];
    [display setText:[NSString stringWithFormat:@"%g", result]];
}

- (IBAction)clear:(UIButton *)sender
{
    [[self brain] setOperand:0.0];
    [display setText:[NSString stringWithFormat:@"%g", 0.0]];
}

@end
