//
//  Results.h
//  CardGame
//
//  Created by Adriana Pineda on 11/14/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Results : NSObject

@property (nonatomic, strong) NSArray *currentCards;
@property (nonatomic, readonly) NSInteger currentScore;
@property (nonatomic, readonly) BOOL allCardsChosen;

- (instancetype)initWithCards: (NSArray *)cards score: (NSInteger)score allCardsChosen: (BOOL)allCardsChosen;

@end

NS_ASSUME_NONNULL_END
