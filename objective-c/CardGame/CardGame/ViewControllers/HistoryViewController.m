//
//  HistoryViewController.m
//  CardGame
//
//  Created by Adriana Pineda on 11/20/21.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (strong, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureContents];
}

- (void)configureContents {
    NSMutableAttributedString *textViewContents = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *content in self.historyContents) {
        [textViewContents appendAttributedString:content];
        [textViewContents appendAttributedString: [[NSAttributedString alloc] initWithString:@"\n"]];
    }

    [self.historyTextView setAttributedText:textViewContents];
}
@end
