//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by Adriana Pineda on 10/9/21.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

// instancetype -> object of the same type as the object we send this message to
// instancetype is the type of self
- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;

                [self addCard:card];
            }
        }
    }
    return self;
}

@end
