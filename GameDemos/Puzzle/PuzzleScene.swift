//
//  PuzzleScene.swift
//  GameDemos
//
//  Created by Ma Xueyuan on 2019/07/16.
//  Copyright © 2019 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class PuzzleScene: SKScene {
    let n = 5
    var matrix = [[Tile?]]()
    var swipable = false
    
    override func didMove(to view: SKView) {
        for y in 0..<n*2 {
            var row = [Tile?]()
            for x in 0..<n {
                let tile = Tile(x: x, y: y)
                row.append(tile)
                addChild(tile)
            }
            matrix.append(row)
        }
        
        kill()
    }
    
    func kill() {
        // find yokoKill
        for y in 0..<n {
            for x in 0..<n-2 {
                guard let tile = matrix[y][x] else { continue }
                if tile.killStatus != .notKill {
                    continue
                }
                if tile.colorId == matrix[y][x+1]?.colorId && matrix[y][x+1]?.colorId == matrix[y][x+2]?.colorId {
                    tile.killStatus = .yokoKill
                    matrix[y][x+1]?.killStatus = .yokoKill
                    matrix[y][x+2]?.killStatus = .yokoKill
                }
            }
        }
        
        // execute kill
        for y in 0..<n {
            for x in 0..<n {
                guard let tile = matrix[y][x] else { continue }
                if tile.killStatus == .notKill {
                    continue
                }
                matrix[y][x] = nil
                tile.run(SKAction.sequence([
                    SKAction.resize(toWidth: 0, height: 0, duration: 0.5),
                    SKAction.removeFromParent()
                ]))
            }
        }
    }
}
