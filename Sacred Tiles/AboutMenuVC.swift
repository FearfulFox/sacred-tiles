//
//  AboutMenuVC.swift
//  Sacred Tiles
//
//  Created by Fox on 2/25/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit;
import SpriteKit;

class AboutMenuVC: CommonUIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view = AboutMenuView();
    }
    
}
