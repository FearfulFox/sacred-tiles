//
//  Extensions.swift
//  Sacred Tiles
//
//  Created by Fox on 3/5/15.
//  Copyright (c) 2015 eCrow. All rights reserved.
//


import Foundation;

// Shuffle extention to an array object.
extension Array {
    
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i;
            swap(&self[i], &self[j]);
        }
    }
    
    func shuffled() -> [T] {
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i;
            swap(&list[i], &list[j]);
        }
        return list
    }
    
}