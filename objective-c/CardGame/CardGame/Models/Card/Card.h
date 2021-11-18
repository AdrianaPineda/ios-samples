//
//  Card.h
//  CardGame
//
//  Created by Adriana Pineda on 10/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

// all properties start at 0 (primitive) or nil (objects)

// all objects live in the heap (where we allocate free memory)
// and objective-c handles the memory with ARC
// weak cleans up & sets pointer to nil
// nil pointers will not crash the program (no code is executed), we can send messages to nil pointers

// nonatomic => no thread safe
@property (strong, nonatomic) NSString *contents; // @property generates public setter and getter
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched; // primitive types, not stored on the heap, no memory to manage

- (int)match:(NSArray *)cards;

@end

NS_ASSUME_NONNULL_END
