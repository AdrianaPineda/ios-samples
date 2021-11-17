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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)preferredFontsChanged:(NSNotification *)notification {
    [self usePreferredFonts];
}

- (void)usePreferredFonts {
    self.bodyTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headlineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
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
