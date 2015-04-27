//
//  Particle.swift
//  Sacred Tiles
//
//  Created by Fox on 2/25/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit

struct Particle {
    
    static func getParticle(fileName: NSString) -> SKEmitterNode {
        let pathStr: String = NSBundle.mainBundle().pathForResource(fileName as String, ofType: "sks")!;
        let node: SKEmitterNode = NSKeyedUnarchiver.unarchiveObjectWithFile(pathStr) as! SKEmitterNode;
        return node;
    }
    
}
