//
//  DropitBehavior.m
//  Dropit
//
//  Created by Adriana Pineda on 11/25/21.
//

#import "DropitBehavior.h"

@interface DropitBehavior()

@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collider;

@end

@implementation DropitBehavior

- (instancetype)init {
    self = [super init];

    if (self) {
        [self addChildBehavior:self.gravity];
        [self addChildBehavior:self.collider];
    }

    return self;
}

- (UIGravityBehavior *)gravity {
    if(!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
    }

    return _gravity;
}

- (UICollisionBehavior *)collider {
    if(!_collider) {
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES; // uses bounds of the reference view as its bounds
    }

    return _collider;
}

- (void)addItem:(id<UIDynamicItem>)item {
    [self.gravity addItem:item];
    [self.collider addItem:item];
}

- (void)removeItem:(id<UIDynamicItem>)item {
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
}

@end
