//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Adriana Pineda on 10/12/21.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()

// readwrite is default, but we need it because we are re-declaring the property
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }

    return _cards;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck {
    self = [super init];

    if (self) {
        BOOL cardsInitialized = [self initCards:count deck:deck];
        if (!cardsInitialized) {
            self = nil;
        }
    }

    return self;
}

- (BOOL)initCards:(NSUInteger)count deck:(Deck *)deck {
    if (count < 2) {
        return NO;
    }

    for (int i = 0; i < count; i++) {
        Card *card = [deck drawRandomCard];
        if (!card) {
            return NO;
        }
        [self.cards addObject: card];
    }

    return YES;
}


//#define MISTMATCH_PENALTY = 2
static const int MISTMATCH_PENALTY = 2; // better because its typed
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (card.isMatched) {
        return;
    }

    if (card.isChosen) {
        card.chosen = NO;
    } else {
        // match against another card
        [self matchAnotherCard:card];
    }
}

- (void)matchAnotherCard: (Card *)card {

    for (Card *anotherCard in self.cards) {
        if (!anotherCard.isChosen || anotherCard.isMatched) {
            continue;
        }

        int matchScore = [card match:@[anotherCard]];
        if (matchScore) {
            self.score += matchScore * MATCH_BONUS;
            card.matched = YES;
            anotherCard.matched = YES;
        } else {
            self.score -= MISTMATCH_PENALTY;
            anotherCard.chosen = NO;
        }

        break;
    }

    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    if (index >= [self.cards count]) { // self.cards.count
        return nil;
    }
//    return [self.cards objectAtIndex:index];
    return self.cards[index];
}

@end
