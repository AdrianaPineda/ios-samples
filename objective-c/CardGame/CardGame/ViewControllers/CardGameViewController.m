//
//  ViewController.m
//  CardGame
//
//  Created by Adriana Pineda on 10/7/21.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()

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
@property (strong, nonatomic) NSMutableArray *history;

- (IBAction)reDealClicked;
- (IBAction)matchTypeChanged;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)history {
    if (!_history) {
        _history = [[NSMutableArray alloc] init];
    }

    return _history;
}

- (Deck *)deck {
    if (!_deck) {
        _deck = [self createDeck];
    }

    return _deck;
}

- (Deck *)createDeck { // abstract
    return nil;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [self createGame];
    }

    return _game;
}

- (CardMatchingGame *)createGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] deck:self.deck matchType: [self getMatchType] hideCards:self.hideCards];
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
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    [self.matchTypeControl setEnabled: !self.game.hasGameStarted];
    [self configureResultsText];
}

- (NSAttributedString *)cardsTitles:(NSArray *)cards {
    NSMutableAttributedString *cardsText = [[NSMutableAttributedString alloc] init];
    for (Card *card in cards) {
        [cardsText appendAttributedString: [[NSAttributedString alloc] initWithString: card.contents]];
    }

    return cardsText;
}

- (void)configureResultsText {
    Results *results = [self.game results];
    if (!results) {
        [self.resultsLabel setText:@"Results"];
        return;
    }

    NSAttributedString *cardsText = [self cardsTitles:results.currentCards];
    NSMutableAttributedString *resultsText = [[NSMutableAttributedString alloc] init];
    if (!results.allCardsChosen) {
        [resultsText appendAttributedString:cardsText];
    } else if (results.currentScore > 0) {
        NSAttributedString *firstMessage = [[NSAttributedString alloc] initWithString: @"Matched "];
        NSAttributedString *secondMessage = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" for %ld points", (long)results.currentScore]];

        [resultsText appendAttributedString:firstMessage];
        [resultsText appendAttributedString:cardsText];
        [resultsText appendAttributedString:secondMessage];

    } else {
        NSAttributedString *message = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" don't match! %ld points penalty", (long)results.currentScore]];
        [resultsText appendAttributedString:cardsText];
        [resultsText appendAttributedString:message];
    }

    [self.resultsLabel setAttributedText:resultsText];
    [self.history addObject:resultsText];
}

- (NSAttributedString *)titleForCard: (Card *)card {
    return nil;
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen || !self.hideCards ? @"CardFront" : @"CardBack"];
}

- (void)handleEmptyDeck {
    self.flipsLabel.text = @"Ran out of cards";
}

- (IBAction)reDealClicked {
    self.deck = nil;
    self.game = nil;
    self.history = nil;
    [self updateUI];
}

- (IBAction)matchTypeChanged {
    CardMatchType cardMatchType = [self getMatchType];
    [self.game setMatchType:cardMatchType];
}

- (CardMatchType)getMatchType {
    return 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![segue.identifier isEqualToString:@"history"]) {
        return;
    }

    if (![segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
        return;
    }

    HistoryViewController *historyVC = (HistoryViewController *)segue.destinationViewController;
    historyVC.historyContents = self.history;
}


@end
