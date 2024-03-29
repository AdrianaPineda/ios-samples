//
//  CardGameViewController.h
//  CardGame
//
//  Created by Adriana Pineda on 10/7/21.
//
// Abstract class that must implement methods below

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property BOOL hideCards;

// protected - for subclasses
- (Deck *)createDeck; // abstract
- (CardMatchType)getMatchType; // abstract
- (NSAttributedString *)cardsTitles:(NSArray *)cards; // abstract
- (NSAttributedString *)titleForCard: (Card *)card; // abstract

@end

