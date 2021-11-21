//
//  PlayingCardViewController.m
//  CardGame
//
//  Created by Adriana Pineda on 11/16/21.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *matchTypeControl;

@end

@implementation PlayingCardViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (BOOL)hideCards {
    return YES;
}

- (CardMatchType)getMatchType {
    switch (self.matchTypeControl.selectedSegmentIndex) {
        case 0:
            return CardMatchTypeTwo;

        default:
            return CardMatchTypeThree;
    }
}

- (NSAttributedString *)titleForCard: (Card *)card {
    if (card.isChosen) {
        return [[NSAttributedString alloc] initWithString:card.contents];
    }
    return [[NSAttributedString alloc] init];
}

@end
