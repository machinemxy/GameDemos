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
        
        while true {
            let bestKill = kill()
            if bestKill.killCount == 0 {
                break
            }
            dropDown()
        }
    }
    
    func kill() -> BestKill {
        var bestKill = BestKill(killCount: 0, killColorId: 0)
        
        // find yokoKill
        for y in 0..<n {
            for x in 0..<n-2 {
                guard let tile = matrix[y][x] else { continue }
                if tile.killStatus == .yokoKill {
                    continue
                }
                
                var count = 1
                for i in x+1..<n {
                    if tile.colorId != matrix[y][i]!.colorId {
                        break
                    }
                    count += 1
                }
                
                if count >= 3 {
                    for i in x..<x+count {
                        matrix[y][i]!.killStatus = .yokoKill
                    }
                    if count > bestKill.killCount {
                        bestKill = BestKill(killCount: min(count, 5), killColorId: tile.colorId)
                    }
                }
            }
        }
        
        // find tateKill
        for x in 0..<n {
            for y in 0..<n-2 {
                guard let tile = matrix[y][x] else { continue }
                if tile.killStatus == .tateKill {
                    continue
                }
                
                var count = 1
                for i in y+1..<n {
                    if tile.colorId != matrix[i][x]!.colorId {
                        break
                    }
                    count += 1
                }
                
                if count >= 3 {
                    let ceiling = y + count
                    for i in y..<ceiling {
                        if matrix[i][x]!.killStatus == .yokoKill {
                            count = 5
                        }
                        matrix[i][x]!.killStatus = .tateKill
                    }
                    if count > bestKill.killCount {
                        bestKill = BestKill(killCount: min(count, 5), killColorId: tile.colorId)
                    }
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
        
        return bestKill
    }
    
    func dropDown() {
        // perform drop down
        for x in 0..<n {
            var bottom: Int? = nil
            for y in 0..<n*2 {
                // already filled
                if let wrappedBottom = bottom {
                    if wrappedBottom >= n {
                        break
                    }
                }
                
                if let tile = matrix[y][x] {
                    // drop to the bottom
                    if let wrappedBottom = bottom {
                        matrix[y][x] = nil
                        matrix[wrappedBottom][x] = tile
                        tile.y = wrappedBottom
                        bottom = wrappedBottom + 1
                        
                        tile.run(SKAction.sequence([
                            SKAction.wait(forDuration: 0.5),
                            SKAction.moveTo(y: PuzzleHelper.getPosition(y: wrappedBottom), duration: 0.5)
                        ]))
                    }
                } else {
                    // find the bottom
                    if bottom == nil && y < n {
                        bottom = y
                    }
                }
            }
        }
        
        // fill the substitution tiles
        for y in n..<n*2 {
            for x in 0..<n {
                if matrix[y][x] == nil {
                    let tile = Tile(x: x, y: y)
                    matrix[y][x] = tile
                    addChild(tile)
                }
            }
        }
    }
}
