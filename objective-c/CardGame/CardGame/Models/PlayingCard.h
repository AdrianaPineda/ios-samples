//
//  PlayingCard.h
//  CardGame
//
//  Created by Adriana Pineda on 10/9/21.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end

NS_ASSUME_NONNULL_END
