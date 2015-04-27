//
//  ButtonSprite.swift
//  Sacred Tiles
//
//  Created by Fox on 2/23/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

class ButtonSprite: CommonSKSpriteNode {
    
     enum TYPE:String {
        case Large = "ButtonLarge";
        case Small = "ButtonSmall";
        case Square = "ButtonSquare";
        case Clairvoyance = "SkillClairvoyance";
        case Burn = "SkillBurn";
    }
    
    internal var label:SKLabelNode = SKLabelNode(fontNamed:"AvenirNextCondensed-Bold");
    internal var fontColor:SKColor = SKColor.blackColor();
    internal var hoverFontColor:SKColor = SKColor(red: 0.992, green: 0.804, blue: 0.404, alpha: 1.0);
    internal var fontSize:CGFloat = 45;
    
    internal var text:String = "";
    internal var clickClosure:(SKNode)->() = {(selfNode: SKNode) -> () in };
    internal var pressClosure:(SKNode)->() = {(selfNode: SKNode) -> () in };
    internal var releaseClosure:(SKNode)->() = {(selfNode: SKNode) -> () in };
    internal var isOver = false;
    
    init(text:String, type:ButtonSprite.TYPE){
        var ButtonType:ButtonSprite.TYPE = ButtonSprite.TYPE.Square;
        var ButtonSize:CGSize = CGSize(width: 0.203, height: 0.113);
        
        switch(type){
            case ButtonSprite.TYPE.Large:
                ButtonType = ButtonSprite.TYPE.Large;
                ButtonSize = CGSize(width: 0.199, height: 0.143);
                self.label.position = CGPoint(x: 0, y: -4);
                self.fontSize = 55;
            case ButtonSprite.TYPE.Small:
                ButtonType = ButtonSprite.TYPE.Small;
                ButtonSize = CGSize(width: 0.137, height: 0.105);
                self.label.position = CGPoint(x: 0, y: -4);
                self.fontSize = 30;
            case ButtonSprite.TYPE.Clairvoyance:
                ButtonType = ButtonSprite.TYPE.Clairvoyance;
                ButtonSize = CGSize(width: 0.121, height: 0.555);
                self.label.position = CGPoint(x: 0, y: -4);
                self.fontSize = 0;
            case ButtonSprite.TYPE.Burn:
                ButtonType = ButtonSprite.TYPE.Burn;
                ButtonSize = CGSize(width: 0.121, height: 0.555);
                self.label.position = CGPoint(x: 0, y: -4);
                self.fontSize = 0;
            default:
                ButtonType = ButtonSprite.TYPE.Square;
        }
        super.init(texture: SKTexture(imageNamed: ButtonType.rawValue), size: ButtonSize, frames: 2);
        self.setPosition(x: 0, y: 0);
        self.userInteractionEnabled = true;
        
        self.label.text = text;
        self.label.fontSize = self.fontSize;
        self.label.fontColor = self.fontColor;
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center;
        // 253, 205, 103
        self.addChild(self.label);
    }
    
    func onClick(closure:(selfNode: SKNode)->()){
        self.clickClosure = closure;
    }
    
    func onPress(closure:(selfNode: SKNode)->()){
        self.pressClosure = closure;
    }
    
    func onRelease(closure:(selfNode: SKNode)->()){
        self.releaseClosure = closure;
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.isOver = true;
        self.pressClosure(self);
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if(isOver){
            self.clickClosure(self);
            self.releaseClosure(self);
            self.isOver = false;
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch:UITouch = event.allTouches()?.first as! UITouch;
        let loc:CGPoint = touch.locationInView(touch.view);
        let wBounds = touch.view.bounds;
        let pLoc:CGPoint = CGPoint(x: Double(loc.x/wBounds.width), y: 1.0-Double(loc.y/wBounds.height));
        let p:CGPoint = self.getPosition();
        let s:CGSize = self.getSize();
        
        if(self.isOver){
            if(pLoc.x < (p.x - (s.width*self.anchorPoint.x))){
                self.isOver = false;
            }
            if(pLoc.x > (p.x + (s.width*self.anchorPoint.x))){
                self.isOver = false;
            }
            if(pLoc.y < (p.y - (s.height*self.anchorPoint.y))){
                self.isOver = false;
            }
            if(pLoc.y > (p.y + (s.height*self.anchorPoint.y))){
                self.isOver = false;
            }
            if(!isOver){
                self.releaseClosure(self);
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
