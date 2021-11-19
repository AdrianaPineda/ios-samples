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
@property (nonatomic, readwrite) NSInteger currentScore;
@property (nonatomic, strong) NSArray *lastChosenCards; // of Card
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic) BOOL hideCards;
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

- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck matchType: (CardMatchType) matchType hideCards:(BOOL)hideCards {
    self = [super init];

    if (self) {
        BOOL cardsInitialized = [self initCards:count deck:deck];
        _matchType = matchType;
        _gameStarted = NO;
        _hideCards = hideCards;
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
    self.gameStarted = YES;

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
    card.chosen = YES;

    NSArray *chosenCards = [self currentChosenCards]; // assigning it to chosenCards, will reference to the original array and modify it
    self.lastChosenCards = chosenCards;

    if ([self isChosingCards:chosenCards]) {
        self.currentScore = -COST_TO_CHOOSE;
        self.score += self.currentScore;
        return;
    }

    int matchScore = [self matchScore:chosenCards];
    if (matchScore) {
        self.currentScore = matchScore * MATCH_BONUS;
        card.matched = YES;
    } else {
        self.currentScore -= MISTMATCH_PENALTY;
    }

    self.score += self.currentScore;
    if (self.hideCards) {
        [self matchChosenCards:matchScore chosenCards:chosenCards];
    }
}

- (int)matchScore: (NSArray *)chosenCards {
    int score = 0;
    for (int i = 0; i < chosenCards.count; i++) {
        Card *card = chosenCards[i];
        NSRange range = NSMakeRange(i + 1, chosenCards.count - i - 1);
        NSArray *otherCards = [chosenCards subarrayWithRange:range];
        score += [card match:otherCards];
    }

    return score;
}

- (NSMutableArray *)currentChosenCards {
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    for (Card *anotherCard in self.cards) {
        if (!anotherCard.isChosen || anotherCard.isMatched) {
            continue;
        }

        [chosenCards addObject:anotherCard];
    }

    return chosenCards;
}

- (void)matchChosenCards:(int)score chosenCards:(NSArray *)chosenCards {
    for (Card *card in chosenCards) {
        if (score) {
            card.matched = YES;
        } else {
            card.chosen = NO;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    if (index >= [self.cards count]) { // self.cards.count
        return nil;
    }
//    return [self.cards objectAtIndex:index];
    return self.cards[index];
}

- (Results *)results {
    if (!self.gameStarted) {
        return nil;
    }
    BOOL areAllCardsChosen = ![self isChosingCards:self.lastChosenCards];
    return [[Results alloc] initWithCards:self.lastChosenCards score:self.currentScore allCardsChosen:areAllCardsChosen];
}

- (BOOL)isChosingCards: (NSArray *)chosenCards {
    return chosenCards.count != self.matchType;
}

@end
