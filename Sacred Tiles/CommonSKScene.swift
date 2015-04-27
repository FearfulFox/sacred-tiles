//
//  CommonSKScene.swift
//  Sacred Tiles
//
//  Created by Fox on 2/16/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

// May increase these, may not.
let POINT_SIZE_IPAD:CGSize = CGSize(width: 1024, height: 768); // 4:3
let POINT_SIZE_IPHONE:CGSize = CGSize(width: 1334, height: 750); // 16:9

// The iPad and iPhone have two different aspect ratios.
// Create a constant that stores the correct resolution based on the device.
// This constant is highly important for graphical scaling and positioning.
let POINT_SIZE = UIDevice.currentDevice().model .hasPrefix("iPhone") ? POINT_SIZE_IPHONE : POINT_SIZE_IPAD;

class CommonSKScene: SKScene {
    
    override init(){
        // Initalize all scenes with a positioning resolution of POINT_SIZE.
        super.init(size: POINT_SIZE);
        // The default background color is white.
        self.backgroundColor = UIColor.whiteColor();
        // The scaling will fill. Like how you fill a desktop wallpaper.
        self.scaleMode = SKSceneScaleMode.AspectFill;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}