//
//  MainMenuView.swift
//  Sacred Tiles
//
//  Created by Fox on 2/16/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import UIKit;
import SpriteKit;

class MainMenuView: CommonSKView {
    
    // /*============================================================
    //    Main Menu Scene
    class MyScene: CommonSKScene {
        // SPRITES -----
        // monk
        var monkSprite: CommonSKSpriteNode = CommonSKSpriteNode(imageNamed: "Monk", size: CGSize(width:0.285, height: 0.522));
        // Symbols
        var symbolSprites: [CommonSKSpriteNode] = [CommonSKSpriteNode]();
        // background
        var backgroundSprite: CommonSKSpriteNode = CommonSKSpriteNode(imageNamed: "MainMenuLayer", size: CGSize(width: 1.0, height: 1.0));
        // Play BUTTON
        var playButton: ButtonSprite = ButtonSprite(text: "Play", type: ButtonSprite.TYPE.Large);
        var optionsButton: ButtonSprite = ButtonSprite(text: "Options", type: ButtonSprite.TYPE.Small);
        var aboutButton: ButtonSprite = ButtonSprite(text: "About", type: ButtonSprite.TYPE.Small);
        var standardModeButton: ButtonSprite = ButtonSprite(text: "Standard", type: ButtonSprite.TYPE.Square);
        var hardcoreModeButton: ButtonSprite = ButtonSprite(text: "Hardcore", type: ButtonSprite.TYPE.Square);
        
        // Mode switching state
        var isModeSwitching:Bool = false;
        
        // Common button closures
        var pressClosure: (SKNode)->() = ({(selfNode: SKNode)->() in });
        var releaseClosure: (SKNode)->() = ({(selfNode: SKNode)->() in });
        
        // Tiles
        var tiles: [TileSprite] = [TileSprite]();
        
        // Particle Test
        var dustEmitter: SKEmitterNode = Particle.getParticle("MyParticle");
        
        // ACTIONS
        var floatUp: SKAction;
        var floatDown: SKAction;
        var floatingAction: SKAction;
        
        override init(){
            // Init the actions
            self.floatUp = SKAction.moveByX(0, y: CommonSKSpriteNode.iPadYAspect(20.0), duration: 3.5);
            self.floatUp.timingMode = SKActionTimingMode.EaseInEaseOut;
            self.floatDown = SKAction.moveByX(0, y: CommonSKSpriteNode.iPadYAspect(-20.0), duration: 3.5);
            self.floatDown.timingMode = SKActionTimingMode.EaseInEaseOut;
            self.floatingAction = SKAction.sequence([floatUp, floatDown]);
            
            let symbolNames = ["SymbolBlue","SymbolGreen","SymbolPurple","SymbolRed","SymbolYellow"];
            
            for name in symbolNames {
                self.symbolSprites.append(CommonSKSpriteNode(imageNamed: name, size: CGSize(width:0.05, height: 0.095)));
            }
            
            super.init();
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func didMoveToView(view: SKView) {
            self.backgroundColor = SKColor(red: 0.62, green: 0.52, blue: 0.36, alpha: 1.0);
            self.dustEmitter.position = CommonSKSpriteNode.makePosition(0.5, y: 0.36);
            self.dustEmitter.particlePositionRange.dx = POINT_SIZE.width;
            
            // Initial normal properties for each object.
            self.initObjects();
            //
            self.initClosures();
            // Add all sprites the the scene.
            self.addChild(self.dustEmitter);
            self.addChild(self.monkSprite);
            for symbol in self.symbolSprites {
                self.addChild(symbol);
            }
            self.addChild(self.backgroundSprite);
            self.addChild(self.playButton);
            self.addChild(self.optionsButton);
            self.addChild(self.aboutButton);
            self.addChild(self.standardModeButton);
            self.addChild(self.hardcoreModeButton);
            for tile in self.tiles {
                self.addChild(tile);
            }
            
        }
        
        func initObjects(){
            // Monk Sprite
            self.monkSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            self.monkSprite.setPosition(x: 0.5, y: 0.63);
            self.monkSprite.runAction(SKAction.repeatActionForever(self.floatingAction));
            
            // Symbols
            self.symbolSprites[0].setPosition(x: 0.6, y: 0.8);
            self.symbolSprites[1].setPosition(x: 0.57, y: 0.92);
            self.symbolSprites[2].setPosition(x: 0.5, y: 0.97);
            self.symbolSprites[3].setPosition(x: 0.43, y: 0.92);
            self.symbolSprites[4].setPosition(x: 0.40, y: 0.8);
            let symbolAction: SKAction = SKAction.sequence([SKAction.waitForDuration(2.0, withRange: 4.0), SKAction.group([SKAction.fadeInWithDuration(2.0), SKAction.repeatActionForever(self.floatingAction)])]);
            for symbol in self.symbolSprites {
                symbol.alpha = 0.0;
                symbol.runAction(symbolAction);
            }
            
            // Background Sprite
            self.backgroundSprite.anchorPoint = CGPoint(x: 0.0, y: 0.0);
            self.backgroundSprite.position = CGPoint(x: 0, y: 0);
            
            // Play Button
            self.playButton.setPosition(x: 0.5, y: 0.40);
            // Options Button
            self.optionsButton.setPosition(x: 0.2, y: 0.39);
            self.optionsButton.label.fontSize = 26;
            self.optionsButton.label.position = CGPoint(x: 0, y: -7);
            // About Button
            self.aboutButton.setPosition(x: 0.8, y: 0.39);
            // Mode buttons
            self.standardModeButton.setPosition(x: 0.5, y: 0.24);
            self.standardModeButton.setFrame(1);
            self.standardModeButton.label.fontColor = self.standardModeButton.hoverFontColor;
            self.hardcoreModeButton.setPosition(x: 0.5, y: 0.09);

            
            // Tiles
            //self.tileTest.setPosition(x: 0.05, y: 0.26);
            // initialize
            for index in 1...16 {
                if(index <= 8){
                    self.tiles.append(TileSprite(type: Tile.TYPE(rawValue: Int(arc4random_uniform(UInt32(Tile.TYPE.allValues.count)-3)))!, isFlipped: false));
                }else{
                    self.tiles.append(TileSprite(type: Tile.TYPE.BOMB, isFlipped: true));
                }
            }
            // position
            for var i = 0; i < self.tiles.count; i++ {
                var mult = i;
                var x: CGFloat = 0.0;
                var y: CGFloat = 0.24;
                if(i >= 8){
                    y = 0.09;
                    mult = (i - 8);
                }
                if(i < 4){
                    x = 0.1 * CGFloat(mult) + 0.05;
                } else if(i < 8){
                    x = 0.1 * CGFloat(mult) + 0.25;
                } else if(i < 12){
                    x = 0.1 * CGFloat(mult) + 0.05;
                } else if(i < 16){
                    x = 0.1 * CGFloat(mult) + 0.25;
                }
                self.tiles[i].setPosition(x: x, y: y);
                if(i >= 8){
                    self.tiles[i].alpha = 0.5;
                }
            }
        }
        
        // Initialize closure functions.
        private func initClosures(){
            // COMMON CLOSURES
            self.pressClosure = ({(selfNode: SKNode)->() in
                if(selfNode is ButtonSprite){
                    let button: ButtonSprite = selfNode as! ButtonSprite;
                    button.setFrame(1);
                    button.label.fontColor = button.hoverFontColor;
                }
            });
            self.releaseClosure = ({(selfNode: SKNode)->() in
                if(selfNode is ButtonSprite){
                    let button: ButtonSprite = selfNode as! ButtonSprite;
                    button.setFrame(0);
                    button.label.fontColor = button.fontColor;
                }
            });
            
            // Actions
            var standardActions: [SKAction] = [];
            for var i = 4; i < 8; i++ {
                let delayAct = SKAction.waitForDuration(0.05);
                let flipAct1 = SKAction.runBlock(self.tiles[7-i].flip);
                let flipAct2 = SKAction.runBlock(self.tiles[i].flip);
                standardActions.append(SKAction.group([flipAct1,flipAct2]));
                standardActions.append(delayAct);
            }
            var harcoreActions: [SKAction] = [];
            for var i = 12; i < 16; i++ {
                let delayAct = SKAction.waitForDuration(0.05);
                let flipAct1 = SKAction.runBlock(self.tiles[23-i].flip);
                let flipAct2 = SKAction.runBlock(self.tiles[i].flip);
                harcoreActions.append(SKAction.group([flipAct1,flipAct2]));
                harcoreActions.append(delayAct);
            }

            let modeSwitchComplete:()->() = {()->() in
                self.isModeSwitching = false;
                if(Settings.mode == 1){
                    for i in 0...7 {
                        self.tiles[i].setType(Tile.TYPE(rawValue: Int(arc4random_uniform(UInt32(Tile.TYPE.allValues.count)-3)))!);
                    }
                }else{
                    for i in 8...15 {
                        self.tiles[i].setType(Tile.TYPE.BOMB);
                    }
                }
            };
            let standardFlipDownAction = SKAction.sequence(standardActions.reverse());
            let standardFlipUpAction = SKAction.sequence(standardActions);
            let hardcoreFlipDownAction = SKAction.sequence(harcoreActions.reverse());
            let hardcoreFlipUpAction = SKAction.sequence(harcoreActions);
            
            // MODE SELECTION CLOSURES
            let standardClick:(SKNode)->() = {(selfNode: SKNode)->() in
                if(Settings.mode == 1 && self.isModeSwitching == false){
                    Settings.mode = 0;
                    self.isModeSwitching = true;
                    
                    self.standardModeButton.setFrame(1);
                    self.standardModeButton.label.fontColor = self.standardModeButton.hoverFontColor;
                    
                    self.hardcoreModeButton.setFrame(0);
                    self.hardcoreModeButton.label.fontColor = self.hardcoreModeButton.fontColor;
                    
                    for i in 0...15 {
                        if(i < 8){ self.tiles[i].alpha = 1.0; }
                        else{ self.tiles[i].alpha = 0.5; }
                    }
                    
                    self.runAction(SKAction.group([standardFlipUpAction,hardcoreFlipDownAction]));
                    self.runAction(SKAction.waitForDuration(0.8), completion: modeSwitchComplete);
                }
            };
            let hardcoreClick:(SKNode)->() = {(selfNode: SKNode)->() in
                if(Settings.mode == 0 && self.isModeSwitching == false){
                    Settings.mode = 1;
                    self.isModeSwitching = true;
                    
                    self.standardModeButton.setFrame(0);
                    self.standardModeButton.label.fontColor = self.standardModeButton.fontColor;
                    
                    self.hardcoreModeButton.setFrame(1);
                    self.hardcoreModeButton.label.fontColor = self.hardcoreModeButton.hoverFontColor;
                    
                    for i in 0...15 {
                        if(i < 8){ self.tiles[i].alpha = 0.5; }
                        else{ self.tiles[i].alpha = 1.0; }
                    }
                    
                    self.runAction(SKAction.group([hardcoreFlipUpAction,standardFlipDownAction]));
                    self.runAction(SKAction.waitForDuration(0.8), completion: modeSwitchComplete);
                }
            };
            
            // Add closures to objets
            self.playButton.onPress(self.pressClosure);
            self.playButton.onRelease(self.releaseClosure);
            self.playButton.onClick({(selfNode: SKNode)->() in
                // Recache the view controller elements so we don't have to handle the main
                // menu stuff anymore.
                VC_CACHE = [GameVC(),GameOverVC()];
                NAV_CONTROLLER.rippleIn(VC_CACHE[0]);
            });
            
            self.optionsButton.onPress(self.pressClosure);
            self.optionsButton.onRelease(self.releaseClosure);
            
            self.aboutButton.onPress(self.pressClosure);
            self.aboutButton.onRelease(self.releaseClosure);
            self.aboutButton.onClick({(selfNode: SKNode)->() in
                NAV_CONTROLLER.pushWithFade(VC_CACHE[1], direction: kCATransitionFromLeft);
            });
            
            // Mode buttons
            self.standardModeButton.onClick(standardClick);
            self.hardcoreModeButton.onClick(hardcoreClick);
        }
    }
    // ============================================================*/
    let myScene: SKScene = MyScene();
    
    override init(){
        super.init();
        
        //super.showDebug();
        self.presentScene(self.myScene);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
