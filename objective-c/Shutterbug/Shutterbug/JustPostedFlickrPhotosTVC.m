//
//  JustPostedFlickrPhotosTVC.m
//  Shutterbug
//
//  Created by Adriana Pineda on 11/26/21.
//

#import "JustPostedFlickrPhotosTVC.h"
#import "FlickrFetcher.h"

@interface JustPostedFlickrPhotosTVC ()

@end

@implementation JustPostedFlickrPhotosTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self fetchPhotos];
}

- (IBAction)fetchPhotos {
    [self.refreshControl beginRefreshing];
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    dispatch_queue_t fetchQ = dispatch_queue_create("flicker fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL]; // we use NULL instead of nil, since it is a pointer to param error pointer (&error) which is NULL
        NSLog(@"Flickr results = %@", propertyListResults);
        NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            self.photos = photos;
        });
    });
}

@end
