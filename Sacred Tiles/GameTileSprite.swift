//
//  GameTileSprite.swift
//  Sacred Tiles
//
//  Created by Fox on 3/5/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

class GameTileSprite: TileSprite {

    private var pressClosure: (SKNode)->() = {(SKNode)->() in }
    var flipTouch = true;
    
    init(type: Tile.TYPE){
        super.init(type: type, isFlipped: false);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if(flipTouch){
            self.flipBack();
        }else{
            self.pressClosure(self);
        }
    }
    
    override func flipBack() {
        if(!isFlipping){
            //runAction(SKAction.playSoundFileNamed("flip_up.caf", waitForCompletion: false));
            SoundManager.playSound("flip_up.caf");
            self.isFlipped = false;
            self.isFlipping = true;
            self.runAction(TILE_RESOURCE.tileFlipBackActions[self.type.rawValue], completion: self.flipComplete);
        }
    }
    
    private func flipComplete(){
        self.isFlipping = false;
        self.pressClosure(self);
    }
    
    func onPress(closure:(selfNode: SKNode)->()){
        self.pressClosure = closure;
    }
    
}
