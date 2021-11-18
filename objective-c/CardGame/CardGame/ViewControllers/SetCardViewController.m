//
//  SetCardViewController.m
//  CardGame
//
//  Created by Adriana Pineda on 11/17/21.
//

#import "SetCardViewController.h"
#import "SetDeck.h"

@implementation SetCardViewController

- (Deck *)createDeck {
    return [[SetDeck alloc] init];
}

- (BOOL)redeal {
    return NO;
}

@end
