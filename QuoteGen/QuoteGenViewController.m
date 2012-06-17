//
//  QuoteGenViewController.m
//  QuoteGen
//
//  Created by Joy Xi on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuoteGenViewController.h"

@interface QuoteGenViewController ()

@end

@implementation QuoteGenViewController

@synthesize myQuotes = _myQuotes;
@synthesize movieQuotes = _movieQuotes;
@synthesize quote_text=_quote_text;
@synthesize quote_opt = _quote_opt;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 1 - Add array of personal quotes
    
    self.myQuotes = [NSArray arrayWithObjects:
                     @"Live and let life",
                     @"Don't cry over spilt milk", 
                     @"Always look on the bright side of life", 
                     @"Nobody's perfect", 
                     @"Can't see the woods for the trees",
                     @"Better to have loved and lost than not loved at all",
                     @"The early bird catches the worm",
                     @"As slow as a wet week",
                     nil];
    // 2 - Load movie quotes
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"]; // get address of quotes.plist
    self.movieQuotes = [[NSMutableArray arrayWithContentsOfFile:plistCatPath] copy]; // use that to make an NSMUtableArray out of it
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.movieQuotes = nil;
    self.myQuotes = nil;
    self.quote_text = nil;
    self.quote_opt = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)quote_btn_touch:(id)sender {
    // 1 - Ger personal quotes when "mine" is selected
    if (self.quote_opt.selectedSegmentIndex == 2) {
        // 1.1 get # rows in array
        int array_tot = self.myQuotes.count;
        // 1.2 get random index
        int index = (arc4random() % array_tot);
        // 1.3 get the quote sring for the index
        NSString *my_quote = [self.myQuotes objectAtIndex:index];
        // 1.4 display the quote in the text view
        self.quote_text.text = [NSString stringWithFormat:@"Quote:\n\n%@", my_quote];
   
    } else {
        // 2.1 - determine category
        NSString *selectedCategory = @"classic";
        if (self.quote_opt.selectedSegmentIndex == 1) {
            selectedCategory = @"modern";
        }
        
        // 2.2 filter array by category using predicate
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"category == %@", selectedCategory];
        NSArray *filteredArray = [self.movieQuotes filteredArrayUsingPredicate:predicate];
        
        // 2.3 - Get total number in filtered array
        int array_tot = filteredArray.count;
        
        // 2.4 as a safeguard only get quote when the array has rows in it
        if (array_tot > 0) {
            // 2.5 - get random index
            int index = (arc4random() % array_tot);
            // 2.6 - Get the quote string for the index
            NSString *my_quote = [[filteredArray objectAtIndex:index] valueForKey:@"quote"];
            // 2.7 - display the quote in the text view
            self.quote_text.text = [NSString stringWithFormat:@"Quote:\n\n%@", my_quote];
        } else {
            self.quote_text = [NSString stringWithFormat:@"No quotes to display."];
        }
    }
}

@end
