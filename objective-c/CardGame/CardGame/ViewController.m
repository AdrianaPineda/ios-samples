//
//  ViewController.m
//  CardGame
//
//  Created by Adriana Pineda on 10/7/21.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (Deck *)deck {
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }

    return _deck;
}

- (void)setFlipCount:(int)flipCount { // used to keep UI in synced with the property
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];

    NSLog(@"flipCount = %d", self.flipCount);
}

// IBAction is a typedef for void
- (IBAction)cardClicked:(UIButton *)sender {
    UIImage *cardImage;
    NSString *title;

    if ([sender.currentTitle length]) {
        cardImage = [UIImage imageNamed:@"CardBack"];
        title = @"";
    } else {
        Card *currentCard = [self.deck drawRandomCard];
        if (!currentCard) {
            [self handleEmptyDeck];
            return;
        }

        cardImage = [UIImage imageNamed:@"CardFront"];
        title = currentCard.contents;
    }

    [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
    [sender setTitle:title forState:UIControlStateNormal];

    self.flipCount++;
}

- (void)handleEmptyDeck {
    self.flipsLabel.text = @"Ran out of cards";
}
@end
