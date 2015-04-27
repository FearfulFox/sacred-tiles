//
//  GameOverVC.swift
//  Sacred Tiles
//
//  Created by Fox on 3/19/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit;
import SpriteKit;

class GameOverVC: CommonUIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view = GameOverView();
    }
    
}