//
//  NavController.swift
//  Sacred Tiles
//
//  Created by Fox on 3/3/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit;

class NavController: UINavigationController {
    
    private var transitionFade = CATransition();
    private var transitionRipple = CATransition();
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.initTransitions();
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        // This is a game application. Hide the nav bar.
        self.navigationBarHidden = true;
    }
    
    private func initTransitions(){
        transitionFade.duration = 0.5;
        transitionFade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        transitionFade.type = kCATransitionFade;
        transitionFade.subtype = kCATransitionFromLeft;
        //transitionFade.removedOnCompletion = false;
        
        transitionRipple.duration = 1;
        transitionRipple.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        transitionRipple.type = "rippleEffect";
        //transitionRipple.subtype = kCATra;
    }
    
    func pushWithFade(vc: UIViewController, direction: String!){
        transitionFade.subtype = direction;
        self.view.layer.addAnimation(transitionFade, forKey: nil);
        self.pushViewController(vc, animated: true);
    }
    
    func popWithFade(){
        self.view.layer.addAnimation(transitionFade, forKey: nil);
        self.popViewControllerAnimated(true);
    }
    
    func popToRootWithFade(){
        self.view.layer.addAnimation(transitionFade, forKey: nil);
        self.popToRootViewControllerAnimated(true);
    }
    
    func rippleIn(vc: UIViewController){
        self.view.layer.addAnimation(transitionRipple, forKey: nil);
        self.setViewControllers([vc], animated: true);
    }
    
    func switchTo(vc: UIViewController){
        self.setViewControllers([vc], animated: false);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Keeps the view oriented in landscape.
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.LandscapeLeft // or Right of course
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue);
    }
    
}
