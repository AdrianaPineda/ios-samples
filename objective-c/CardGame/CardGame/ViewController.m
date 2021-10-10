//
//  ViewController.m
//  CardGame
//
//  Created by Adriana Pineda on 10/7/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// IBAction is a typedef for void
- (IBAction)cardClicked:(UIButton *)sender {
    UIImage *cardImage;
    NSString *title;
    if ([sender.currentTitle length]) {
        cardImage = [UIImage imageNamed:@"CardBack"];
        title = @"";
    } else {
        cardImage = [UIImage imageNamed:@"CardFront"];
        title = @"A♣️";
    }

    [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
    [sender setTitle:title forState:UIControlStateNormal];
}

@end
