//
//  GameOverScene.swift
//  Sacred Tiles
//
//  Created by Fox on 3/19/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

class GameOverScene: CommonSKScene {
    
    // Header labels
    let gameOverLabel = CommonSKLabelNode(text: "Game Over", type: CommonSKLabelNode.TYPE.Header1);
    let peakScoreLabel = CommonSKLabelNode(text: "Your Peak Score was...", type: CommonSKLabelNode.TYPE.Header1);
    let scoreLabel = CommonSKLabelNode(text: "", type: CommonSKLabelNode.TYPE.Header1);
    let tapToReturnLabel = CommonSKLabelNode(text: "Tap to return to the Main Menu", type: CommonSKLabelNode.TYPE.Header1);
    
    override init(){
        super.init();
    }
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor(red: 0.62, green: 0.52, blue: 0.36, alpha: 1.0);
        
        self.initObjects();
        
        // Label
        self.addChild(self.gameOverLabel);
        self.addChild(self.peakScoreLabel);
        self.addChild(self.scoreLabel);
        self.addChild(self.tapToReturnLabel);
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        VC_CACHE = [MainMenuVC(),AboutMenuVC()];
        NAV_CONTROLLER.rippleIn(VC_CACHE[0]);
    }
    
    private func initObjects(){
        // labels
        self.gameOverLabel.setPosition(x: 0.5, y: 0.83);
        self.gameOverLabel.fontSize = 120;
        
        self.peakScoreLabel.setPosition(x: 0.5, y: 0.65);
        self.peakScoreLabel.fontSize = 34;
        
        self.scoreLabel.setPosition(x: 0.5, y: 0.50);
        self.scoreLabel.fontSize = 94;
        self.scoreLabel.text = "\(TotalScore.peak)";
        
        self.tapToReturnLabel.setPosition(x: 0.5, y: 0.05);
        self.tapToReturnLabel.fontSize = 24;
        
        TotalScore.reset();
        BoardScore.reset();
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
};