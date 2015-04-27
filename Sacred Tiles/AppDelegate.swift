//
//  AppDelegate.swift
//  Sacred Tiles
//
//  Created by Fox on 2/16/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit;

// I should really make a more functional and safe solution to my
// view controller management, but... eh.
let NAV_CONTROLLER = NavController();
var VC_CACHE: [UIViewController] = [];

// Application Main class
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?;
    
    // Window Class (for possibly overriding some methods).
    class Window: UIWindow {
        
        init(rootNC: UINavigationController){
            // The window's frame matches the device's screen size.
            super.init(frame: UIScreen.mainScreen().bounds);
            // Background color defaults to white.
            self.backgroundColor = UIColor.whiteColor();
            // Make the root view controller the passed UINavigationController.
            self.rootViewController = rootNC;
            // Make this the key window and show it.
            self.makeKeyAndVisible();
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented");
        }
    };
    
    // Application function.
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // We want to hide the status bar for our game. Take the entire screen.
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None);
        
        NAV_CONTROLLER.navigationBarHidden = true;
        
        VC_CACHE = [MainMenuVC(), AboutMenuVC()];
        //VC_CACHE = [GameVC(),GameOverVC()];
        
        NAV_CONTROLLER.setViewControllers([VC_CACHE[0]], animated: true);
        
        // Create the default Window, Nav Controller, and View Controller.
        self.window = Window(rootNC: NAV_CONTROLLER);
        
        return true;
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

