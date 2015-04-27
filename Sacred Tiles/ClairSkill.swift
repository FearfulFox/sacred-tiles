//
//  clairSkill.swift
//  Sacred Tiles
//
//  Created by Fox on 3/19/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import Foundation

class ClairSkill: ButtonSprite {
    
    private var selectedTiles: [GameTileSprite] = [];
    
    init(){
        super.init(text: "", type: ButtonSprite.TYPE.Clairvoyance);
    }

    // A Passed function to TileBoard.swift instances
    func skillMode(tile: GameTileSprite){
        if(selectedTiles.count < 4){
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
