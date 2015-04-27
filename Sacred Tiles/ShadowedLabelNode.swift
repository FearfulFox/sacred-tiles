//
//  ShadowedLabelNode.swift
//  Sacred Tiles
//
//  Created by Fox on 3/9/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

class ShadowedLabelNode: SKLabelNode {
    
    private var shadow = SKLabelNode(fontNamed:"AvenirNext-Bold");
    
    override init(){
        super.init();
    }
    
    override init(fontNamed fontName: String!) {
        super.init(fontNamed: fontName);
        shadow.fontName = fontName;
        shadow.fontColor = UIColor.blackColor();
        
        //addChild(shadow);
    }
    
    func setPosition(#x: CGFloat, y: CGFloat){
        let xPos = x * POINT_SIZE.width;
        let yPos = y * POINT_SIZE.height;
        let xPos2 = x * (POINT_SIZE.width+100);
        let yPos2 = y * (POINT_SIZE.height-100);
        self.position = CGPoint(x: xPos, y: yPos);
        shadow.position = CGPoint(x: xPos2, y: yPos2);
    }
    
    func setNewFontSize(size: CGFloat){
        self.fontSize = size;
        shadow.fontSize = size;
    }
    
    func setCustomText(text: String){
        self.text = text;
        shadow.text = text;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
