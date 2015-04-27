//
//  CommonUIViewController.swift
//  Sacred Tiles
//
//  Created by Fox on 3/3/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit;

class CommonUIViewController: UIViewController {
    
    override func shouldAutorotate() -> Bool {
        return false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
}

