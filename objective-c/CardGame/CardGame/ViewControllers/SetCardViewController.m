//
//  SetCardViewController.m
//  CardGame
//
//  Created by Adriana Pineda on 11/17/21.
//

#import "SetCardViewController.h"
#import "SetDeck.h"
#import "SetCard.h"

@implementation SetCardViewController

- (Deck *)createDeck {
    return [[SetDeck alloc] init];
}

- (BOOL)hideCards {
    return NO;
}

- (CardMatchType)getMatchType {
    return CardMatchTypeThree;
}

- (NSAttributedString *)cardsTitles:(NSArray *)cards {
    NSMutableAttributedString *cardsText = [[NSMutableAttributedString alloc] init];
    for (Card *card in cards) {
        [cardsText appendAttributedString: [self titleForCard:card]];
    }

    return cardsText;
}

- (NSAttributedString *)titleForCard: (Card *)card {
    if (![card isKindOfClass:[SetCard class]]) {
        return nil;
    }

    SetCard *setCard = (SetCard *)card;
    UIColor *shapeColor = [self shapeColor:setCard];

    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:setCard.shape];
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:shapeColor forKey:NSStrokeColorAttributeName];
    [attributes setObject:@-10 forKey:NSStrokeWidthAttributeName];
    [attributes addEntriesFromDictionary: [self filling:setCard]];
    [title setAttributes:attributes range:NSMakeRange(0, title.length)];
    return title;
}

- (UIColor *)shapeColor:(SetCard *)card {
    NSString *color = card.color;

    if ([color isEqualToString:@"red"]) {
        return [UIColor redColor];
    }

    if ([color isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }

    if ([color isEqualToString:@"green"]) {
        return [UIColor greenColor];
    }

    return [UIColor blackColor];
}

- (NSDictionary *)filling:(SetCard *)card {
    NSString *shading = card.shading;

    if ([shading isEqualToString:@"dot"]) {
        return @{NSForegroundColorAttributeName: [self shapeColor:card]};
    }

    if ([shading isEqualToString:@"fill"]) {
        return @{NSForegroundColorAttributeName: [self shapeColor:card]};
    }

    if ([shading isEqualToString:@"empty"]) {
        return @{NSForegroundColorAttributeName: [UIColor clearColor]};
    }

    return @{};
}

@end
