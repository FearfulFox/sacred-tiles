//
//  SoundManager.swift
//  Sacred Tiles
//
//  Created by Fox on 3/29/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit
import SpriteKit

struct SoundManager {
    
    static let SoundPlayer: SKNode = SKNode();
    
    static func playSound(fileName: String){
        if(Settings.sounds){
            SoundPlayer.runAction(SKAction.playSoundFileNamed(fileName, waitForCompletion: false));
        }
    }
    
}