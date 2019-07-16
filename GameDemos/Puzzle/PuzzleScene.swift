//
//  PuzzleScene.swift
//  GameDemos
//
//  Created by Ma Xueyuan on 2019/07/16.
//  Copyright © 2019 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class PuzzleScene: SKScene {
    var matrix = [[Tile]]()
    override func didMove(to view: SKView) {
        for i in 0...4 {
            var row = [Tile]()
            for j in 0...4 {
                let tile = Tile(x: i, y: j, colorId: Int.random(in: 0...4))
                row.append(tile)
                addChild(tile)
            }
            matrix.append(row)
        }
    }
}
