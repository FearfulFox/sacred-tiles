//
//  CommonSKView.swift
//  Sacred Tiles
//
//  Created by Fox on 2/16/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

class CommonSKView: SKView {
    
    init(){
        // The view is going to match the device's screen size.
        super.init(frame: UIScreen.mainScreen().bounds);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    // Shows debugging information.
    func showDebug(){
        self.showsFPS = true;
        self.showsNodeCount = true;
    }
    
}
