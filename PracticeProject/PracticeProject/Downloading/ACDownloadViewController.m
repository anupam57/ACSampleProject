//
//  ACDownloadViewController.m
//  PracticeProject
//
//  Created by Anupam on 30/08/13.
//  Copyright (c) 2013 BantuLaLKiDukaan. All rights reserved.
//

#import "ACDownloadViewController.h"
#import "ACDownloadURLOperation.h"

static NSString* const kDropBoxUrlOne = @"https://dl.dropboxusercontent.com/u/196217121/myMovie.mov";
static NSString* const kDropBoxUrlTwo = @"https://dl.dropboxusercontent.com/u/196217121/big-buck-bunny-clip.m4v";

@interface ACDownloadViewController ()

@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation ACDownloadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;  
}

- (void)viewDidLoad
{
  _operationQueue = [[NSOperationQueue alloc] init];
  [_operationQueue setMaxConcurrentOperationCount:2];  
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadOne:(id)sender {
  ACDownloadURLOperation *operationFirst =
  [[ACDownloadURLOperation alloc]
   initWithURL:[NSURL URLWithString:kDropBoxUrlOne]
   andProgress:^(float progress) {
     [self.progressView setProgress:progress];
   }];
//  [operationFirst addObserver:self
//                   forKeyPath:@"finished"
//                      options:NSKeyValueObservingOptionInitial
//                      context:nil];
  [self.operationQueue addOperation:operationFirst];
}

- (IBAction)downloadTwo:(id)sender {
  
}

@end
