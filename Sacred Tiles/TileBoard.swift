//
//  TileBoard.swift
//  Sacred Tiles
//
//  Created by Fox on 3/5/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

class TileBoard: SKNode {
    
    private var tilesCache: [GameTileSprite] = [GameTileSprite](count: Int(12*11), repeatedValue: GameTileSprite(type: Tile.TYPE.BLUE));
    // Game board tiles.
    internal var tiles: [GameTileSprite] = [];
    internal var tilePool: [Tile.TYPE] = [Tile.TYPE.BLUE, Tile.TYPE.GREEN];
    // Defines how many tiles to create on the grid.
    private var grid: CGSize = CGSize(width: 12, height: 11);
    // Maximum number of tiles
    private let tileMax: Int = 12*11;
    // Defines a boundry area for the tiles (percentages)
    private var area: CGSize = CGSize(width: 1.0, height: 1.0);
    
    // Stores selected tiles references.
    private var tilesQueue: [GameTileSprite] = [];
    // Fade out action for tile.
    private let tileFadeOut = SKAction.fadeAlphaTo(0.4, duration: 0.15);
    // Counts the number of matches made.
    private var matchCount: Int = 0;
    
    // Closures
    private var tilePressClosure = {(tile: GameTileSprite)->() in};
    private var matchClosure = {(tile1: GameTileSprite, tile2: GameTileSprite)->() in};
    private var missClosure = {(tile1: GameTileSprite, tile2: GameTileSprite)->() in};
    private var completeClosure = {()->() in};
    
    init(grid: CGSize, area: CGSize){
        super.init();
        
        self.area = area;
        
        self.setGrid(grid);
        
        //
        self.createTiles();
        self.setupTiles();
        self.positionTiles();
        self.renderTiles();
    }

    func setGrid(grid: CGSize){
        self.grid = grid;
        var tileNum: Int = Int(self.grid.width * self.grid.height);
        if(self.grid.width * self.grid.height % 2 != 0){
            self.grid.width += 1.0;
            tileNum = Int(self.grid.width * self.grid.height);
        }
        if(tileNum > self.tileMax){
            self.grid = CGSize(width: 12, height: 11);
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    private func createTiles(){
        var typeCount: [Int] = [0,0,0,0,0];
        for var i = 0; i < tileMax; i+=2 {
            let typeRand = Int(arc4random_uniform(UInt32(tilePool.count)));
            tilesCache[i] = GameTileSprite(type: tilePool[typeRand]);
            tilesCache[i+1] = GameTileSprite(type: tilePool[typeRand]);
            
            tilesCache[i].onPress(self.tilePressed);
            tilesCache[i+1].onPress(self.tilePressed);
        }
    }
    
    private func setupTiles(){
        tiles = [];
        for var i = 0; i < Int(grid.width * grid.height); i++ {
            tiles.append(tilesCache[i]);
        }
        tiles.shuffle();
    }
    
    private func positionTiles(){
        
        var margin: CGFloat = 0.05;
        
        var offsetX = (area.width / grid.width)/2 + (1 - area.width)/2;
        var offsetY = (area.height / grid.height)/2 + (1 - area.height)/2;
        
        var pos: CGPoint = CGPoint(x: offsetX, y: offsetY);
        
        let scale = self.yScale/self.xScale;
        let wRS = scale < 1 ? scale + offsetY : 1;
        let hRS = scale > 1 ? scale : 1;
        
        let s = CGSize(width: (area.width * wRS) / grid.width, height: area.width / grid.height);
        
        for var i = 0; i < Int(grid.width); i++ {
            for var j = 0; j <  Int(grid.height); j++ {
                let indx = i * Int(grid.height) + j;
                
                tiles[indx].setSize(width: s.width - margin*s.width, height: s.height - margin*s.height);
                tiles[indx].setPosition(x: pos.x, y: pos.y);
                pos.y += (area.height / grid.height);
            }
            pos.x += (area.width / grid.width);
            pos.y = offsetY;
        }
        
    }
    
    private func renderTiles(){
        for tile in tiles {
            self.addChild(tile);
        }
    }
    
    // Sets the closure to when a tile is pressed
    func onTilePressed(closure: (tile: GameTileSprite)->()){
        self.tilePressClosure = closure;
    }
    
    // When a tile is pressed
    func tilePressed(tileNode: SKNode){
        let tile = tileNode as! GameTileSprite;
        self.tilePressClosure(tile);
    }
    
    // Matching mode function
    func tileModeMatching(tile: GameTileSprite){
        tile.userInteractionEnabled = false;
        tilesQueue.append(tile);
        if(tilesQueue.count >= 2){
            if(tilesQueue[0].type.rawValue == tilesQueue[1].type.rawValue){
                SoundManager.playSound("match.caf");
                tilesQueue[0].userInteractionEnabled = false;
                tilesQueue[1].userInteractionEnabled = false;
                tilesQueue[0].runAction(tileFadeOut);
                tilesQueue[1].runAction(tileFadeOut);
                matchCount++;
                matchClosure(tilesQueue[0], tilesQueue[1]);
            } else {
                tilesQueue[0].flipOver();
                tilesQueue[1].flipOver();
                tilesQueue[0].userInteractionEnabled = true;
                tilesQueue[1].userInteractionEnabled = true;
                missClosure(tilesQueue[0], tilesQueue[1]);
            }
            tilesQueue = [];
        }
        
        if(matchCount >= tiles.count/2){
            matchCount = 0;
            completeClosure();
        }
    }
    
    // Regenerates random tiles.
    func regenerateTiles() {
        self.removeAllChildren();
        createTiles();
        setupTiles();
        positionTiles();
        for tile in tiles {
            tile.alpha = 1.0;
        }
        renderTiles();
    }
    
    // Flips all the tiles over.
    func flipBoardOver(){
        for tile in tiles {
            tile.flipOver();
        }
    }
    
    func enableInteraction(){
        for tile in tiles {
            tile.userInteractionEnabled = true;
        }
    }
    
    func disableInteraction(){
        for tile in tiles {
            tile.userInteractionEnabled = false;
        }
    }
    
    func disableFlipTouch(){
        for tile in tiles {
            tile.flipTouch = false;
        }
    }
    
    func enableFlipTouch(){
        for tile in tiles {
            tile.flipTouch = true;
        }
    }
    
    func onTileMatch(closure: (tile1: GameTileSprite, tile2: GameTileSprite)->()){
        self.matchClosure = closure;
    }
    
    func onTileMiss(closure: (tile1: GameTileSprite, tile2: GameTileSprite)->()){
        self.missClosure = closure;
    }
    
    func onBoardComplete(closure: ()->()){
        self.completeClosure = closure;
    }
    
}