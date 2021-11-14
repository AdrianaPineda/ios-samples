//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Adriana Pineda on 10/12/21.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CardMatchType) {
    CardMatchTypeTwo = 2,
    CardMatchTypeThree = 3
};

@interface CardMatchingGame : NSObject
@property (nonatomic, readonly) NSInteger score;

// designated initializer
- (instancetype)initWithCardCount: (NSUInteger)count deck: (Deck *)deck matchType: (CardMatchType) matchType;
- (void)chooseCardAtIndex: (NSUInteger)index;
- (Card *)cardAtIndex: (NSUInteger)index;
- (void)updateMatchType: (CardMatchType)matchType;

@end

NS_ASSUME_NONNULL_END
