//
//  ViewController.m
//  CardGame
//
//  Created by Adriana Pineda on 10/7/21.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

// has to be strong, because even though the view has a strong reference to the views individually, the view does not have a strong pointer to this array
// IBOutletCollection(UIButton) is only for us, the compiler ignores it. Its just like IBAction
// Order is *NOT* known for IBOutletCollection. The order will be determined by iOS, regardless of the order I connect the elements
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *matchTypeControl;
@property (strong, nonatomic) IBOutlet UILabel *resultsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;

- (IBAction)reDealClicked;
- (IBAction)matchTypeChanged;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (Deck *)deck {
    if (!_deck) {
        _deck = [self createDeck];
    }

    return _deck;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [self createGame];
    }

    return _game;
}

- (CardMatchingGame *)createGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] deck:self.deck matchType: [self getMatchType]];
}

- (void)setFlipCount:(int)flipCount { // used to keep UI in synced with the property
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];

    NSLog(@"flipCount = %d", self.flipCount);
}

// IBAction is a typedef for void
- (IBAction)cardClicked:(UIButton *)sender {
//    UIImage *cardImage;
//    NSString *title;
//
//    if ([sender.currentTitle length]) {
//        cardImage = [UIImage imageNamed:@"CardBack"];
//        title = @"";
//    } else {
//        Card *currentCard = [self.deck drawRandomCard];
//        if (!currentCard) {
//            [self handleEmptyDeck];
//            return;
//        }
//
//        cardImage = [UIImage imageNamed:@"CardFront"];
//        title = currentCard.contents;
//    }
//
//    [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
//    [sender setTitle:title forState:UIControlStateNormal];
//
//    self.flipCount++;
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    [self.matchTypeControl setEnabled: !self.game.hasGameStarted];
    [self configureResultsText];
}

- (void)configureResultsText {
    Results *results = [self.game results];
    NSMutableString *cardsText = [[NSMutableString alloc] init];
    for (Card *card in results.currentCards) {
        [cardsText appendString: card.contents];
    }

    NSString *resultsText = @"";
    if (!results.allCardsChosen) {
        resultsText = cardsText;
    } else if (results.currentScore > 0) {
        resultsText = [NSString stringWithFormat:@"Matched %@ for %ld points", cardsText, (long)results.currentScore];
    } else {
        resultsText = [NSString stringWithFormat:@"%@ don't match! %ld points penalty", cardsText, (long)results.currentScore];
    }

    [self.resultsLabel setText:resultsText];
}

- (NSString *)titleForCard: (Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}

- (void)handleEmptyDeck {
    self.flipsLabel.text = @"Ran out of cards";
}

- (IBAction)reDealClicked {
    self.game = nil;
    [self updateUI];
}

- (IBAction)matchTypeChanged {
    CardMatchType cardMatchType = [self getMatchType];
    [self.game setMatchType:cardMatchType];
}

- (CardMatchType)getMatchType {
    switch (self.matchTypeControl.selectedSegmentIndex) {
        case 0:
            return CardMatchTypeTwo;

        default:
            return CardMatchTypeThree;
    }
}


@end
