//
//  SetDeck.m
//  CardGame
//
//  Created by Adriana Pineda on 11/17/21.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (instancetype)init {
    self = [super init];

    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *shape in [SetCard validShapes]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger count = 1; count <= [SetCard maxCount]; count++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.shape = shape;
                        card.shading = shading;
                        card.count = count;

                        [self addCard:card];
                    }
                }
            }
        }
    }

    return self;
}

@end
