//
//  GameScene.swift
//  Sacred Tiles
//
//  Created by Fox on 3/2/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

class GameScene: CommonSKScene {
    
    internal var tileBoard = TileBoard(grid: CGSize(width: 4, height: 3), area: CGSize(width: 0.72, height: 0.85));
    internal var timer = TimerNode(time: 5);
    
    // Skill Buttons
    internal var clairSkillButton = ClairSkill();
    internal var burnSkillButton = BurnSkill();
    
    // Score Label
    private var scoreLabel = ShadowedLabelNode(fontNamed: "AvenirNext-Bold");
    
    private var levelLabel = CommonSKLabelNode(text: "", type: CommonSKLabelNode.TYPE.Small);
    
    private var matchStreak: UInt = 0;
    private var missTotal: UInt = 0;
    
    private var round = 0;
    
    // level of the game
    private var level = 1;
    
    // Constructor
    override init(){
        super.init();
        // basic background color.
        self.backgroundColor = SKColor(red: 0.62, green: 0.52, blue: 0.36, alpha: 1.0);
        // Board Score
        BoardScore.scores.append(BoardScore.score());
        // add the timerDone() function to when the tier ends.
        self.timer.onFinish(self.timerDone);
        // Start the timer.
        self.timer.startTimer();
        // Set the score label
        self.scoreLabel.setCustomText("Score: \(BoardScore.scores[round].getTotal())");
        self.scoreLabel.setPosition(x: 0.5, y: 0.945);
        // Level Label
        self.levelLabel.text = "Level: \(level)";
        self.levelLabel.fontColor = UIColor.whiteColor();
        self.levelLabel.setPosition(x: 0.05, y: 0.945);
        self.levelLabel.fontSize = 24;
        // Setup the skillButtons
        self.initSkillButtons();
        
        // Get functions to tile board events
        self.tileBoard.onTilePressed(self.tileBoard.tileModeMatching);
        //self.tileBoard.disableFlipTouch();
        //self.tileBoard.onTilePressed(self.burnSkillButton.skillMode);
        self.tileBoard.onTileMatch(self.tileMached);
        self.tileBoard.onTileMiss(self.tileMissed);
        self.tileBoard.onBoardComplete(self.boardComplete);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // To do when the view loads in
    override func didMoveToView(view: SKView) {
        self.addChild(SoundManager.SoundPlayer);
        self.addChild(tileBoard);
        
        self.addChild(clairSkillButton);
        self.addChild(burnSkillButton);
        
        self.addChild(timer);
        self.addChild(scoreLabel);
        self.addChild(levelLabel);
    }
    
    // Set the score to a different value.
    private func updateScore(){
        if(BoardScore.scores[round].getTotal() < 0){
            NAV_CONTROLLER.switchTo(VC_CACHE[1]);
        }
        self.scoreLabel.setCustomText("Score: \(BoardScore.scores[round].getTotal())");
    }
    
    // Upon the timer finishing...
    private func timerDone(selfNode: SKNode){
        self.tileBoard.flipBoardOver();
        self.tileBoard.enableInteraction();
    }
    
    // When a tile is matched...
    private func tileMached(tile1: GameTileSprite, tile2: GameTileSprite) {
        let net = UInt(Double(Scoring.match) * (1 + Scoring.matchMod * Double(matchStreak)));
        matchStreak++;
        BoardScore.scores[round].match += net;
        TotalScore.match += net;
        if(TotalScore.getTotal() > Int64(TotalScore.peak)){
            TotalScore.peak = UInt(TotalScore.getTotal());
        }
        updateScore();
    }
    
    // When a tile is missed...
    private func tileMissed(tile1: GameTileSprite, tile2: GameTileSprite) {
        var net: UInt;
        if(Settings.mode == 0){
            net = UInt(Double(Scoring.miss) * (1 + Scoring.missMod * Double(missTotal)));
        }else{
            let p1 = Double(Scoring.miss*6);
            let p2 = (1 + Scoring.missMod*6 * Double(missTotal))
            net = UInt(p1 * p2);
        }
        matchStreak = 0;
        missTotal++;
        BoardScore.scores[round].miss += net;
        TotalScore.miss += net;
        updateScore();
    }
    
    // When the tile round is complete...
    private func boardComplete(){
        level++;
        setDifficulty(level);
        tileBoard.regenerateTiles();
        timer.startTimer();
        self.levelLabel.text = "Level: \(level)";
    }
    
    // Skill button actions
    private func initSkillButtons(){
        
        // Clairvoyance Skill Button
        clairSkillButton.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        clairSkillButton.setPosition(x: 0.048, y: 0.5);
        
        clairSkillButton.onPress({(selfNode: SKNode)->() in
            let button = selfNode as! ButtonSprite;
            button.setFrame(1);
        });
        
        clairSkillButton.onRelease({(selfNode: SKNode)->() in
            let button = selfNode as! ButtonSprite;
            button.setFrame(0);
        });
        
        // Burn Skill Button
        burnSkillButton.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        burnSkillButton.setPosition(x: 0.952, y: 0.5);
        
        burnSkillButton.onPress({(selfNode: SKNode)->() in
            let button = selfNode as! ButtonSprite;
            button.setFrame(1);
        });
        
        burnSkillButton.onRelease({(selfNode: SKNode)->() in
            let button = selfNode as! ButtonSprite;
            button.setFrame(0);
        });
    }
    
    // Sets the difficulty level for the game.
    func setDifficulty(level: Int){
        switch(level){
            case 1,2,3:
                tileBoard.tilePool = [Tile.TYPE.BLUE, Tile.TYPE.GREEN];
                if(level == 1){timer.changeCounter(5);}
                if(level == 2){timer.changeCounter(4);}
                if(level == 3){timer.changeCounter(4);}
                break;
            case 4,5,6:
                tileBoard.tilePool = [Tile.TYPE.BLUE, Tile.TYPE.GREEN, Tile.TYPE.PURPLE];
                if(level == 4){timer.changeCounter(3);}
                if(level == 5){timer.changeCounter(3);}
                if(level == 6){timer.changeCounter(2);}
            case 7,8,9:
                tileBoard.tilePool = [Tile.TYPE.BLUE, Tile.TYPE.GREEN, Tile.TYPE.PURPLE, Tile.TYPE.RED];
                if(level == 7){timer.changeCounter(3);}
                if(level == 8){timer.changeCounter(2);}
                if(level == 9){timer.changeCounter(2);}
            
            case 10:
                tileBoard.tilePool = [Tile.TYPE.BLUE, Tile.TYPE.GREEN, Tile.TYPE.PURPLE, Tile.TYPE.RED, Tile.TYPE.YELLOW];
                timer.changeCounter(3);
                tileBoard.setGrid(CGSize(width: 5, height: 4));
            case 11:
                timer.changeCounter(2);
            case 12:
                timer.changeCounter(2);
            default:
                tileBoard.setGrid(CGSize(width: 5, height: 4));
                tileBoard.tilePool = [Tile.TYPE.BLUE, Tile.TYPE.GREEN, Tile.TYPE.PURPLE, Tile.TYPE.RED, Tile.TYPE.YELLOW];
                timer.changeCounter(2);
        }
    }
}
