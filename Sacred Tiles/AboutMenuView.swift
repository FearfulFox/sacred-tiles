//
//  AboutMenuView.swift
//  Sacred Tiles
//
//  Created by Fox on 2/25/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit;
import SpriteKit;

class AboutMenuView: CommonSKView {
    
    // /*============================================================
    //    Main Menu Scene
    class MyScene: CommonSKScene {
        
        // Background Image
        let backgroundSprite = CommonSKSpriteNode(imageNamed: "AboutMenuOne", size: CGSize(width: 1.0, height: 1.0));
        
        // Header labels
        let regularTileLabel = CommonSKLabelNode(text: "Regular Tiles", type: CommonSKLabelNode.TYPE.Header1);
        let hueRingTileLabel = CommonSKLabelNode(text: "Hue Ring Tile", type: CommonSKLabelNode.TYPE.Header1);
        let bombTileLabel = CommonSKLabelNode(text: "Bomb Tile", type: CommonSKLabelNode.TYPE.Header1);
        
        // Buttons
        let mainMenuButton = ButtonSprite(text: "Main Menu", type: ButtonSprite.TYPE.Small);
        
        override init(){
            super.init();
        }
        
        override func didMoveToView(view: SKView) {
            self.backgroundColor = SKColor(red: 0.62, green: 0.52, blue: 0.36, alpha: 1.0);

            self.initObjects();
            self.initClosures();
            
            // Background
            self.addChild(self.backgroundSprite);
            
            // Labels
            self.addChild(self.regularTileLabel);
            self.addChild(self.hueRingTileLabel);
            self.addChild(self.bombTileLabel);
            
            // Buttons
            self.addChild(self.mainMenuButton);
        }
        
        private func initObjects(){
            // The background image
            self.backgroundSprite.anchorPoint = CGPoint(x: 0.0, y: 0.0);
            self.backgroundSprite.setPosition(x: 0.0, y: 0.0);
            
            // Header labels
            self.regularTileLabel.setPosition(x: 0.16, y: 0.53);
            self.hueRingTileLabel.setPosition(x: 0.5, y: 0.53);
            self.bombTileLabel.setPosition(x: 0.84, y: 0.53);
            
            // Buttons
            self.mainMenuButton.setPosition(x: 0.5, y: 0.04);
            self.mainMenuButton.setSize(width: 0.167, height: 0.105);
        }
        
        private func initClosures(){
            self.mainMenuButton.onClick({(selfNode: SKNode)->() in
                NAV_CONTROLLER.popToRootWithFade();
            });
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented");
        }
    };
    
    var myScene: SKScene! = MyScene();
    
    // View Constructor
    override init(){
        super.init();
        
        // Display Debug
        //self.showDebug();
        
        self.presentScene(self.myScene);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
