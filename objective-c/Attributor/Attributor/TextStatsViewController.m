//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Adriana Pineda on 11/17/21.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *colorfulCharsLabel;
@property (strong, nonatomic) IBOutlet UILabel *outlinedCharsLabel;

@end

@implementation TextStatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{NSForegroundColorAttributeName: [UIColor greenColor], NSStrokeWidthAttributeName: @-3}];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;

    if (self.view.window) { // only when view is on screen, if its off screen the `viewWillAppear` method will call `updateUI`
        [self updateUI];
    }
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];

    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range]; // its id because it could be a font, a number, a color, etc
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }

    return characters;
}

- (void)updateUI {
    NSUInteger colorfulChars = [[self charactersWithAttribute:NSForegroundColorAttributeName] length];
    self.colorfulCharsLabel.text = [NSString stringWithFormat:@"%lu colorful characters", (unsigned long)colorfulChars];

    NSUInteger outlinedChars = [[self charactersWithAttribute:NSStrokeWidthAttributeName] length];
    self.outlinedCharsLabel.text = [NSString stringWithFormat:@"%lu outlined characters", outlinedChars];
}
@end
