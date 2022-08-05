//
//  AppDelegate.m
//  shunLiuTools
//
//  Created by shun on 2022/7/6.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *mainTab = [[ViewController alloc] init];
    self.window.rootViewController = mainTab;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
