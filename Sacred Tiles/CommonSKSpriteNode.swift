//
//  CommonSKSpriteNode.swift
//  Sacred Tiles
//
//  Created by Fox on 2/17/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import SpriteKit;

// Sprite frames are intended to all in one image.
class CommonSKSpriteNode: SKSpriteNode {
    
    // The number of frames in this sprite.
    // Important for defining the textures we need.
    internal var frames: Int = 1;
    // Texture frames
    internal var textures: [SKTexture] = [SKTexture]();
    // Percentage locations
    var pPosition = CGPoint(x: 0.0, y: 0.0);
    
    init(texture: SKTexture, size: CGSize, frames: Int){
        let reSize = CGSize(width: (size.width * POINT_SIZE.width), height: (size.height * POINT_SIZE.height));
        super.init(texture: texture, color: UIColor.whiteColor(), size: reSize);
        if(frames > 0){
            self.frames = frames;
        }
        self.position = self.pPosition;
        self.generateFrameTextures();
        //self.xScale = 1.0;
        //self.yScale = 1.0;
    }
    
    convenience init(imageNamed: NSString, size: CGSize, frames: Int){
        self.init(texture: SKTexture(imageNamed: imageNamed as String), size: size, frames: frames);
        
    }
    
    convenience init(imageNamed: NSString, size: CGSize){
        self.init(imageNamed: imageNamed, size: size, frames: 1);
    }
    
    // Generates the textures that belong to this sprite
    private func generateFrameTextures(){
        // Top Tile Frames
        for var i = 0; i <= self.frames; i++ {
            let xSize:Double = 1.0 / Double(self.frames);
            let xShift:Double = xSize * Double(i);
            let frame:SKTexture = SKTexture(rect: CGRect(x: xShift, y: 0, width: xSize, height: 1.0), inTexture: self.texture!);
            self.textures.append(frame);
        }
        self.texture = self.textures[0];
    }
    
    // Set the frame of the sprite.
    func setFrame(index: Int){
        if(index >= 0 && index < self.frames){
            self.texture = self.textures[index];
        }
    }
    
    // Centers the sprite on the scene.
    func center(area: CGRect){
        self.setPosition(x: 0.5, y: 0.5);
    }
    
    // Sets the position based on a percentage.
    func setPosition(#x: CGFloat, y: CGFloat){
        let xPos = x * POINT_SIZE.width;
        let yPos = y * POINT_SIZE.height;
        self.position = CGPoint(x: xPos, y: yPos);
    }
    
    // Get the percentile position of the sprite.
    func getPosition() -> CGPoint {
        return ( CGPoint(x: (self.position.x / POINT_SIZE.width), y: (self.position.y / POINT_SIZE.height)) );
    }
    
    // Set the size
    func setSize(#width: CGFloat, height: CGFloat) {
        let reSize = CGSize(width: (width * POINT_SIZE.width), height: (height * POINT_SIZE.height));
        self.size = reSize;
    }
    
    // Gets the size of the sprite.
    func getSize() -> CGSize {
        return ( CGSize (width: (size.width / POINT_SIZE.width), height: (size.height / POINT_SIZE.height)))
    }
    
    // Returns the x percentage value from a pixel size in 4:3 ratio.
    class func iPadXAspect(x: CGFloat) -> CGFloat {
        let percent = x / POINT_SIZE_IPAD.width;
        return (percent * POINT_SIZE.width);
    }
    
    // Returns the y percentage value from a pixel size in 4:3 ratio.
    class func iPadYAspect(y: CGFloat) -> CGFloat {
        let percent = y / POINT_SIZE_IPAD.height;
        return (percent * POINT_SIZE.height);
    }
    
    // Returns the x percentage value from a pixel size in 16:9 ratio.
    class func iPhoneXAspect(x: CGFloat) -> CGFloat {
        let percent = x / POINT_SIZE_IPHONE.width;
        return (percent * POINT_SIZE.width);
    }
    
    // Returns the y percentage value from a pixel size in 16:9 ratio.
    class func iPhoneYAspect(y: CGFloat) -> CGFloat {
        let percent = y / POINT_SIZE_IPHONE.height;
        return (percent * POINT_SIZE.height);
    }
    
    class func makePosition(x:CGFloat, y:CGFloat) -> CGPoint {
        let xPos = x * POINT_SIZE.width;
        let yPos = y * POINT_SIZE.height;
        return CGPoint(x: xPos, y: yPos);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
