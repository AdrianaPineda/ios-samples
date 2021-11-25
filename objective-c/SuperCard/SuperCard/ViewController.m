//
//  ViewController.m
//  SuperCard
//
//  Created by Adriana Pineda on 11/24/21.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet PlayingCardView *playingCardView;
//@property (strong, nonatomic) Deck *deck;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.playingCardView.suit = @"♥️";
    self.playingCardView.rank = 10;

    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
}

- (IBAction)swipe:(id)sender {
    if (!self.playingCardView.faceUp) {
        [self drawRandomPlayingCard];
    }
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

// init deck
- (void)drawRandomPlayingCard {
    // TODO
}

@end
