//
//  PlayingCardViewController.m
//  CardGame
//
//  Created by Adriana Pineda on 11/16/21.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
