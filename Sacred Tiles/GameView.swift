//
//  GameView.swift
//  Sacred Tiles
//
//  Created by Fox on 3/2/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit;
import SpriteKit;

class GameView: CommonSKView {
    var gameScene: SKScene! = GameScene();
    
    // View Constructor
    override init(){
        super.init();
        
        // Display Debug
        //self.showDebug();
        
        self.presentScene(self.gameScene);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}