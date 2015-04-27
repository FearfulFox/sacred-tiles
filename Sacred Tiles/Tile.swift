//
//  Tile.swift
//  Sacred Tiles
//
//  Created by Fox on 2/24/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

class Tile {
    var mainTexture = SKTexture(imageNamed: "TileSheet");
    var backTexture = SKTexture(imageNamed: "TileBack");
    var tileFrames: Int = 4;
    var tileTextures: [[SKTexture]] = [];
    var tileFlipOverActions: [SKAction] = [];
    var tileFlipBackActions: [SKAction] = [];
    
    var backFrames: Int = 5;
    var backTextures: [SKTexture] = [];
    
    var actSpeed: CGFloat = 0.05;
    
    enum TYPE:Int {
        case
        GREEN=0,
        BLUE=1,
        PURPLE=2,
        RED=3,
        YELLOW=4,
        BOMB=5,
        SBOMB=6,
        HUE=7;
        
        static let allValues = [GREEN,BLUE,PURPLE,RED,YELLOW,BOMB,SBOMB,HUE];
    }
    
    init(){
        self.initTextures();
        self.initActions();
    }
    
    private func initTextures(){
        // Front tile textures.
        for var i = (TYPE.allValues.count-1); i >= 0 ; i-- {
            
            var tileSet: [SKTexture] = [];
            
            var h:Double = 1.0 / Double(TYPE.allValues.count);
            var y:Double = h * Double(i);
            
            for var j = 0; j < self.tileFrames; j++ {
                var w:Double = 1.0 / Double(self.tileFrames);
                var x:Double = w * Double(j);
                tileSet.append(SKTexture(rect: CGRect(x: x, y: y, width: w, height: h), inTexture: self.mainTexture!));
            }
            
            self.tileTextures.append(tileSet);
        }
        // Back textures
        for var i = 0; i < self.backFrames; i++ {
            var w:Double = 1.0 / Double(self.backFrames);
            var x:Double = w * Double(i);
            
            self.backTextures.append(SKTexture(rect: CGRect(x: x, y: 0, width: w, height: 1.0), inTexture: self.backTexture!));
        }
    }
    
    private func initActions(){
        // Init flip over actions
        let flipBackOver = SKAction.animateWithTextures(self.backTextures.reverse(), timePerFrame: NSTimeInterval(self.actSpeed));
        for var i = 0; i < self.tileTextures.count; i++ {
            let flipFrontOver = SKAction.animateWithTextures(self.tileTextures[i], timePerFrame: NSTimeInterval(self.actSpeed));
            
            let flipOver = SKAction.sequence([flipFrontOver, flipBackOver]);
            
            self.tileFlipOverActions.append(flipOver);
        }
        
        // Init flip back actions
        let flipBackBack = SKAction.animateWithTextures(self.backTextures, timePerFrame: NSTimeInterval(self.actSpeed));
        for var i = 0; i < self.tileTextures.count; i++ {
            let flipFrontBack = SKAction.animateWithTextures(self.tileTextures[i].reverse(), timePerFrame: NSTimeInterval(self.actSpeed));
            
            let flipBack = SKAction.sequence([flipBackBack, flipFrontBack]);
            
            self.tileFlipBackActions.append(flipBack);
        }
    }
}

let TILE_RESOURCE = Tile();

