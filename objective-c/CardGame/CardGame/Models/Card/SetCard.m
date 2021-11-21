//
//  SetCard.m
//  CardGame
//
//  Created by Adriana Pineda on 11/17/21.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validColors {
    return @[@"red", @"green", @"blue"];
}

+ (NSArray *)validShadings {
    return @[@"dot", @"fill", @"empty"];;
}

+ (NSArray *)validShapes {
    return @[@"▲", @"■", @"●"];
}

+ (NSUInteger)maxCount {
    return 3;
}

- (NSString *)contents {
    return [NSString stringWithFormat:@"%@ %@ (%@) x %lu", self.shape, self.color, self.shading, self.count];
}

- (int)match:(NSArray *)cards {
    // TODO
    return 0;
}
@end
