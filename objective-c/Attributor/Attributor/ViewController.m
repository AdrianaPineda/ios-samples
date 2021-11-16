//
//  ViewController.m
//  Attributor
//
//  Created by Adriana Pineda on 11/15/21.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *headlineLabel;
@property (strong, nonatomic) IBOutlet UITextView *bodyTextView;
@property (strong, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.titleLabel.text];
    // @3 stroke and *no* fill
    [title setAttributes:@{NSStrokeWidthAttributeName: @3, NSStrokeColorAttributeName: self.outlineButton.tintColor} range:NSMakeRange(0, title.length)];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender {
    [self.bodyTextView.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.bodyTextView.selectedRange];
}

- (IBAction)outlineBodySelection {
    // @-3 stroke and fill
    [self.bodyTextView.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-3, NSStrokeColorAttributeName: [UIColor blackColor]} range:self.bodyTextView.selectedRange];
}

- (IBAction)unoutlineBodySelection {
    [self.bodyTextView.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.bodyTextView.selectedRange];
}
@end
