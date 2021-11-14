//
//  PlayingCard.m
//  CardGame
//
//  Created by Adriana Pineda on 10/9/21.
//

#import "PlayingCard.h"

@interface PlayingCard ()

@end

@implementation PlayingCard
@synthesize suit = _suit; // since we implemented getter AND setter we are required to use @synthesize

// @ in strings makes the string an object, we cannot put *

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits {
    return @[@"🖤", @"♠️", @"♣️", @"♦️"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)cards {
    int score = 0;

    NSMutableArray *currentCards = [[NSMutableArray alloc] initWithArray:cards];
    [currentCards addObject:self];

    for (int i = 0; i < currentCards.count; i++) {
        for (int j = i + 1; j < currentCards.count; j++) {
            PlayingCard *firstCard = currentCards[i];
            PlayingCard *secondCard = currentCards[j];

            if ([firstCard.suit isEqualToString:secondCard.suit]) {
                score += 1;
            } else if (firstCard.rank == secondCard.rank) {
                score += 4;
            }
        }
    }
//    for (PlayingCard *otherCard in currentCards) {
//        if ([self.suit isEqualToString:otherCard.suit]) {
//            score += 1;
//        } else if (self.rank == otherCard.rank) {
//            score += 4;
//        }
//    }

//    if ([cards count] == 1) {
//        // PlayingCard *otherCard = [cards firstObject]; // Alt
//        id card = [cards firstObject]; // returns nil if there is no firstObject, but cards[0] can crash if there is no firstObject
//
//        if ([card isKindOfClass:[PlayingCard class]]) {
//            PlayingCard *otherCard = (PlayingCard *)card;
//            if ([self.suit isEqualToString:otherCard.suit]) {
//                score = 1;
//            } else if (self.rank == otherCard.rank) {
//                score = 4;
//            }
//        }
//
//    }

    return score;
}

@end
