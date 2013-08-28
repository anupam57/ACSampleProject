//
//  ACRootViewController.m
//  PracticeProject
//
//  Created by Anupam on 27/08/13.
//  Copyright (c) 2013 BantuLaLKiDukaan. All rights reserved.
//

#import "ACRootViewController.h"
#import "ACGemViewController.h"


@interface ACRootViewController ()<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>

@end

@implementation ACRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)letsGoButtonClicked:(id)sender {
 ACGemViewController *gemVC = [[ACGemViewController alloc] initWithNibName:nil
                                                                    bundle:nil];
  [self.navigationController pushViewController:gemVC
                                       animated:YES];
  
//  - (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//animationControllerForOperation:(UINavigationControllerOperation)operation
//fromViewController:(UIViewController *)fromVC
//toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);

  

//  [self.navigationController navigationController:self.navigationController
//                  animationControllerForOperation:UINavigationControllerOperationPush
//                               fromViewController:self
//                                 toViewController:gemVC];
}


- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
  return self;
}


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
  return 10.0;
  
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  NSLog(@"Transition....%@",transitionContext);
}
@end
