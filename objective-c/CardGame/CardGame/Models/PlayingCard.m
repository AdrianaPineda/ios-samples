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
    return @[@"heart", @"rombo", @"pine", @"tree"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] -1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
