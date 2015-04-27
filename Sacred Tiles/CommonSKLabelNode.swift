//
//  CommonSKLabel.swift
//  Sacred Tiles
//
//  Created by Fox on 2/28/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit

class CommonSKLabelNode: SKLabelNode {
    
    enum TYPE: Int {
        case Paragraph=0, Header1=1, Header2=2, Small=3;
        
        static let allValues = [Paragraph,Header1,Header2,Small];
    }
    
    var type = CommonSKLabelNode.TYPE.Paragraph;
    
    override init(){
        super.init();
    }
    
    init(text: String, type: CommonSKLabelNode.TYPE){
        super.init();
        
        self.text = text;
        
        self.type = type;
        switch(self.type){
            
        case CommonSKLabelNode.TYPE.Small:
            self.fontName = "AvenirNext-Regular";
            self.fontSize = 14;
            self.fontColor = SKColor.blackColor();
            
        case CommonSKLabelNode.TYPE.Paragraph:
            self.fontName = "AvenirNext-Medium";
            self.fontSize = 24;
            self.fontColor = SKColor.blackColor();
            
        case CommonSKLabelNode.TYPE.Header1:
            self.fontName = "AvenirNextCondensed-Bold";
            self.fontSize = 42;
            self.fontColor = SKColor.blackColor();
        
        case CommonSKLabelNode.TYPE.Header2:
            self.fontName = "AvenirNextCondensed-Bold";
            self.fontSize = 48;
            self.fontColor = SKColor.blackColor();
            
        }
    }
    
    // Sets the position based on a percentage.
    func setPosition(#x: CGFloat, y: CGFloat){
        let xPos = x * POINT_SIZE.width;
        let yPos = y * POINT_SIZE.height;
        self.position = CGPoint(x: xPos, y: yPos);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
