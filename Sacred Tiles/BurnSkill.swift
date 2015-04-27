//
//  burnSkill.swift
//  Sacred Tiles
//
//  Created by Fox on 3/19/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import Foundation

class BurnSkill: ButtonSprite {
    
    init(){
        super.init(text: "", type: ButtonSprite.TYPE.Burn);
    }
    
    // A Passed function to TileBoard.swift instances
    func skillMode(tile: GameTileSprite){
        tile.showTop();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}