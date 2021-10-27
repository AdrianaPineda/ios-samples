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
@property (nonatomic, readwrite) CardMatchType matchType;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)chosenCards {
    if (!_chosenCards) {
        _chosenCards = [[NSMutableArray alloc] init];
    }

    return _chosenCards;
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }

    return _cards;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck matchType: (CardMatchType) matchType {
    self = [super init];

    if (self) {
        BOOL cardsInitialized = [self initCards:count deck:deck];
        _matchType = matchType;
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
        [self.chosenCards removeObject:card];
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

        [self.chosenCards addObject:anotherCard];

        if (![self shouldMatch]) {
            continue;
        }

        int matchScore = [card match:self.chosenCards];
        if (matchScore) {
            self.score += matchScore * MATCH_BONUS;
            card.matched = YES;
        } else {
            self.score -= MISTMATCH_PENALTY;
        }

        [self matchChosenCards:matchScore];

        break;
    }

    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}

- (BOOL)shouldMatch {
    return (self.chosenCards.count + 1) == self.matchType;
}

- (void)matchChosenCards:(int)score {
    for (Card *card in self.chosenCards) {
        if (score) {
            card.matched = YES;
        } else {
            card.chosen = NO;
        }
    }

    [self.chosenCards removeAllObjects];
}

- (Card *)cardAtIndex:(NSUInteger)index {
    if (index >= [self.cards count]) { // self.cards.count
        return nil;
    }
//    return [self.cards objectAtIndex:index];
    return self.cards[index];
}

@end
