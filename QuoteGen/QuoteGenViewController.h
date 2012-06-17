//
//  QuoteGenViewController.h
//  QuoteGen
//
//  Created by Joy Xi on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteGenViewController : UIViewController

@property (nonatomic, strong) NSArray *myQuotes;
@property (nonatomic, strong) NSMutableArray *movieQuotes;

@property (nonatomic, strong) IBOutlet UITextView *quote_text;

@property (nonatomic, strong) IBOutlet UISegmentedControl *quote_opt;

-(IBAction)quote_btn_touch:(id)sender;

@end
