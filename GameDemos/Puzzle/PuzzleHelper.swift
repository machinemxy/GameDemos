//
//  PuzzleHelper.swift
//  GameDemos
//
//  Created by Ma Xueyuan on 2019/07/18.
//  Copyright © 2019 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class PuzzleHelper {
    static func getPosition(x: Int) -> CGFloat {
        return CGFloat(150 + x * 100)
    }
    
    static func getPosition(y: Int) -> CGFloat {
        return CGFloat(-200 + y * 100)
    }
}
