//
//  ViewController.m
//  Imaginarium
//
//  Created by Adriana Pineda on 11/26/21.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass: [ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        ivc.imageURL = [NSURL URLWithString: [NSString
                                              stringWithFormat:@"https://img.photographyblog.com/reviews/apple_iphone_12_pro/photos/%@.jpg", segue.identifier]];
        ivc.title = segue.identifier;
    }
}


@end
