//
//  GameOverView.swift
//  Sacred Tiles
//
//  Created by Fox on 3/19/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//


import UIKit;
import SpriteKit;

class GameOverView: CommonSKView {
    var gameOverScene: SKScene! = GameOverScene();
    
    // View Constructor
    override init(){
        super.init();
        
        // Display Debug
        //self.showDebug();
        
        self.presentScene(self.gameOverScene);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
