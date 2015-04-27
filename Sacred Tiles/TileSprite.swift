//
//  TileSprite.swift
//  Sacred Tiles
//
//  Created by Fox on 2/17/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

class TileSprite: SKSpriteNode {
    
    var type: Tile.TYPE = Tile.TYPE.GREEN;
    
    // false = Flipped Up, true = Flipped Down
    var isFlipped: Bool = false; // Flipped Up by default.
    
    // Whether or not the tile is in a flipping state
    var isFlipping: Bool = false; // Not flipping by default.
    
    convenience init(){
        self.init(type: Tile.TYPE.BLUE, isFlipped: false);
    }
    
    init(type: Tile.TYPE, isFlipped: Bool){
        self.type = type;
        self.isFlipped = isFlipped;
        
        let sp: Double = Double(POINT_SIZE_IPAD.height/POINT_SIZE.height);
        let reSize = CGSize(width: Double(90.0 * sp), height: Double(90.0 * sp));
        
        let texture = self.isFlipped ? TILE_RESOURCE.backTextures[0] : TILE_RESOURCE.tileTextures[self.type.rawValue][0];
        
        super.init(texture: texture, color: UIColor.whiteColor(), size: reSize);
        self.position = CGPoint(x: 0, y: 0);
    }
    
    // Sets the position based on a percentage.
    func setPosition(#x: CGFloat, y: CGFloat){
        let xPos = x * POINT_SIZE.width;
        let yPos = y * POINT_SIZE.height;
        self.position = CGPoint(x: xPos, y: yPos);
    }
    
    // Set the size
    func setSize(#width: CGFloat, height: CGFloat) {
        let reSize = CGSize(width: (width * POINT_SIZE.width), height: (height * POINT_SIZE.height));
        self.size = reSize;
    }
    
    // Gets the size of the sprite.
    func getSize() -> CGSize {
        return ( CGSize (width: (size.width / POINT_SIZE.width), height: (size.height / POINT_SIZE.height)))
    }
    
    // Flips the tile based on it's current flip state.
    func flip(){
        if(!self.isFlipped){
            self.flipOver();
        }else{
            self.flipBack();
        }
    }

    // Flips tile over
    func flipOver() {
        if(!isFlipping){
            self.isFlipped = true;
            self.isFlipping = true;
            self.runAction(TILE_RESOURCE.tileFlipOverActions[self.type.rawValue], completion: self.flipComplete);
        }
    }
    
    // Flips tile back
    func flipBack() {
        if(!isFlipping){
            self.isFlipped = false;
            self.isFlipping = true;
            self.runAction(TILE_RESOURCE.tileFlipBackActions[self.type.rawValue], completion: self.flipComplete);
        }
    }
    
    // Shows the top of the tile.
    func showTop(){
        self.texture = TILE_RESOURCE.tileTextures[self.type.rawValue][0];
        isFlipped = false;
    }
    
    // Shows the bottom of the tile.
    func showBottom(){
        self.texture = TILE_RESOURCE.backTextures[0];
        isFlipped = true;
    }
    
    // Completion function after a flip action completes.
    private func flipComplete(){
        self.isFlipping = false;
    }
    
    // Change the type of the tile.
    func setType(type: Tile.TYPE){
        self.type = type;
        if(!self.isFlipped){
            self.texture = TILE_RESOURCE.tileTextures[self.type.rawValue][0];
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}