//
//  MenuVC.swift
//  Sacred Tiles
//
//  Created by Fox on 2/16/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit;
import SpriteKit;

class MainMenuVC: CommonUIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view = MainMenuView();
    }
    
}