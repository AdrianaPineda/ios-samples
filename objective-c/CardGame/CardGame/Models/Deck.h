//
//  Deck.h
//  CardGame
//
//  Created by Adriana Pineda on 10/8/21.
//

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card; // to mimic an optional param
- (Card *)drawRandomCard;

@end

NS_ASSUME_NONNULL_END
