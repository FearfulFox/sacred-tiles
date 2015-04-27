//
//  GameVC.swift
//  Sacred Tiles
//
//  Created by Fox on 3/2/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//


import UIKit;
import SpriteKit;

class GameVC: CommonUIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view = GameView();
    }
    
}
