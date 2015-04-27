//
//  Timer.swift
//  Sacred Tiles
//
//  Created by Fox on 3/8/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit

class TimerNode: SKNode {
    
    var startTime: Int = 0;
    var currentTime: Int = 0;
    var counterLabel: SKLabelNode = SKLabelNode(fontNamed:"AvenirNext-Bold");
    var counterLabelShadow: SKLabelNode = SKLabelNode(fontNamed:"AvenirNext-Bold");
    var timeShape: SKShapeNode = SKShapeNode();
    
    var timer = NSTimer();
    var counter: Int = 0;
    var interval: Double = 0.05;
    
    private var finishClosure:(SKNode)->() = {(selfNode: SKNode) -> () in };
    private let counterFadeOut = SKAction.fadeAlphaTo(0.0, duration: 0.5);
    
    init(time: Int){
        super.init();
        
        self.startTime = time;
        self.currentTime = time;
        
        self.setupShape();
        self.setupCounterLabel();
        addChild(timeShape);
        addChild(counterLabelShadow);
        addChild(counterLabel);
    }
    
    private func setupShape(){
        let s = CGSize(width: (1.0 * POINT_SIZE.width), height: (0.025 * POINT_SIZE.height));
        timeShape = SKShapeNode(rect: CGRect(x: 0, y: POINT_SIZE.height*0.035, width: s.width, height: s.height), cornerRadius: 0);
        timeShape.fillColor = UIColor(red: (217/255), green: (176/255), blue: (109/255), alpha: 1.0);
    }
    
    private func setupCounterLabel(){
        let txt = String(startTime);
        let fontSize: CGFloat = 58;
        var p = CGPoint(x: (0.05 * POINT_SIZE.width), y: (0.04 * POINT_SIZE.height));
        
        counterLabel.text = txt;
        counterLabel.fontSize = fontSize;
        counterLabel.fontColor = UIColor.whiteColor();
        counterLabel.position = p;
        
        counterLabelShadow.text = txt;
        counterLabelShadow.fontSize = fontSize;
        counterLabelShadow.fontColor = UIColor.blackColor();
        p.y -= 5.0;
        p.x += 5.0;
        counterLabelShadow.position = p;
    }
    
    func changeCounter(number: Int){
        startTime = number;
        currentTime = number;
        let txt = String(startTime);
        counterLabel.text = txt;
        counterLabelShadow.text = txt;
    }
    
    private func countDown(){
        currentTime--;
        let txt = String(currentTime);
        counterLabel.text = txt;
        counterLabelShadow.text = txt;
    }
    
    func startTimer(){
        counterLabel.alpha = 1.0;
        timeShape.xScale = 1.0;
        counter = 0;
        changeCounter(startTime);
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("update"), userInfo: nil, repeats: true);
    }
    
    func update(){
        if(currentTime == 0){
            timer.invalidate();
            timer = NSTimer();
            counterLabel.runAction(counterFadeOut);
            counterLabelShadow.runAction(counterFadeOut);
            finishClosure(self);
        }
        counter++;
        if(counter % Int(1/interval) == 0){
            countDown();
        }
        
        let v = Int(1/interval) * startTime;
        let scaler = CGFloat( CGFloat(v - counter) / CGFloat(v) );
        timeShape.xScale = scaler;
    }
    
    func onFinish(closure:(SKNode)->()){
        finishClosure = closure;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}