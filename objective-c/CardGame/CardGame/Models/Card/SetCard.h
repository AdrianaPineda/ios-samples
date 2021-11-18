//
//  SetCard.h
//  CardGame
//
//  Created by Adriana Pineda on 11/17/21.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *shape;
@property (nonatomic) NSUInteger count;

+ (NSArray *)validColors;
+ (NSArray *)validShadings;
+ (NSArray *)validShapes;
+ (NSUInteger)maxCount;

@end

NS_ASSUME_NONNULL_END
