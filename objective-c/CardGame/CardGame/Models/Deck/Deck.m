//
//  Deck.m
//  CardGame
//
//  Created by Adriana Pineda on 10/8/21.
//

#import "Deck.h"

@interface Deck()
// all instance variables start at 0/nil, including pointers
// *cards => we want that array to stay in the heap
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation Deck

// lazy instantiation
- (NSMutableArray *)cards {
    if (!_cards) {
        // alloc: allocates memory in the heap
        // init: initializes that memory
        _cards = [[NSMutableArray alloc] init]; // we could do this in the Deck init, but its better to have the init closer to the actual getter, cause it removes junk from the Deck init. This pattern is widely used in objective-c
    }
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;

    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }

    return randomCard;
}

/**
 NSNumber
 NSInteger
 index
 */

@end
