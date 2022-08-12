//
//  AboutViewController.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "AboutViewController.h"
#import "WebKit/WebKit.h"
#import "Configs.h"
#import "UIViewController+Extensions.h"
@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *wkWebView;

@end

@implementation AboutViewController

#pragma mark - Lifecycle;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"About";
    [self configLeftBarItemButtons];
    [self setup];
    
}


#pragma mark - Helper
-(void) setup{
    [self loadWebView];
}
-(void) loadWebView{
    NSURL *aboutURL = [NSURL URLWithString:AboutURL];
    NSURLRequest *request = [NSURLRequest requestWithURL: aboutURL];
    [self.wkWebView loadRequest:request];
    
}





@end
