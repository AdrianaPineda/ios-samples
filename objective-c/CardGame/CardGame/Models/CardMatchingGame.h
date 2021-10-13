//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Adriana Pineda on 10/12/21.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject
@property (nonatomic, readonly) NSInteger score;

// designated initializer
- (instancetype)initWithCardCount: (NSUInteger)count deck: (Deck *)deck;
- (void)chooseCardAtIndex: (NSUInteger)index;
- (Card *)cardAtIndex: (NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
