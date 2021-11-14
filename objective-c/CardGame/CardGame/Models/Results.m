//
//  Results.m
//  CardGame
//
//  Created by Adriana Pineda on 11/14/21.
//

#import "Results.h"

@implementation Results

- (instancetype)initWithCards: (NSArray *)cards score: (NSInteger)score allCardsChosen: (BOOL)allCardsChosen {
    self = [super init];

    if (self) {
        _currentCards = cards;
        _currentScore = score;
        _allCardsChosen = allCardsChosen;
    }

    return self;
}

@end
