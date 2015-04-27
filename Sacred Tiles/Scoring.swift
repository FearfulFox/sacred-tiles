//
//  Scoring.swift
//  Sacred Tiles
//
//  Created by Fox on 3/9/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//

import Foundation;

struct BoardScore {
    
    struct score {
        var match: UInt = 0;
        var miss: UInt = 0;
        var skill: UInt = 0;
        
        func getTotal()->Int64{
            let net: Int64 = Int64(match) - Int64(miss + skill);
            return net;
        }
    }
    
    static var scores: [score] = [];
    
    static func reset(){
        BoardScore.scores = [];
    }
    
}

struct TotalScore {

    static var match: UInt = 0;
    static var miss: UInt = 0;
    static var skill: UInt = 0;
    
    static var peak: UInt = 0;
    
    static func getTotal()->Int64{
        let net: Int64 = Int64(match) - Int64(miss + skill);
        return net;
    }
    
    static func reset(){
        TotalScore.match = 0;
        TotalScore.miss = 0;
        TotalScore.skill = 0;
        
        TotalScore.peak = 0;
    }
    
}

struct Scoring {
    
    // Base points for a matching two tiles.
    static let match: UInt = 99;
    // Tile matching streak modifier.
    static let matchMod: Double = 0.05;
    // Base points for miss-matching a tile.
    static let miss: UInt = 40;
    // Modifier for every time a tile is miss-matched.
    static let missMod: Double = 0.15;
    
}