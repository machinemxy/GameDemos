//
//  FrogScene.swift
//  GameDemos
//
//  Created by Ma Xueyuan on 2018/08/31.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class FrogScene: SKScene {
    var leaves = [SKSpriteNode]()
    var distanceBetweenLeaf: CGFloat!
    var frogs = [Frog(kind: Kind.green, name: "green1"),
                   Frog(kind: Kind.green, name: "green2"),
                   Frog(kind: Kind.green, name: "green3"),
                   Frog(kind: Kind.none, name: ""),
                   Frog(kind: Kind.red, name: "red1"),
                   Frog(kind: Kind.red, name: "red2"),
                   Frog(kind: Kind.red, name: "red3")]
    var playable = true
    var reset: SKLabelNode!
    var menu: SKLabelNode!
    var victory: SKLabelNode!
    
    override func didMove(to view: SKView) {
        distanceBetweenLeaf = self.size.width/8
        
        for i in 0...6 {
            let leaf = SKSpriteNode(imageNamed: "leaf")
            leaf.position = CGPoint(x: distanceBetweenLeaf * CGFloat(i), y: 0)
            leaves.append(leaf)
            addChild(leaf)
            
            let frog = frogs[i]
            if frog.kind != .none {
                let frogSprite: SKSpriteNode
                if frog.kind == .green {
                    frogSprite = SKSpriteNode(imageNamed: "frog_green")
                } else {
                    frogSprite = SKSpriteNode(imageNamed: "frog_red")
                }
                frogSprite.name = frog.name
                frogSprite.position = CGPoint(x: distanceBetweenLeaf * CGFloat(i), y: 0)
                frogSprite.zPosition = 1
                addChild(frogSprite)
            }
        }
        
        reset = (childNode(withName: "reset") as! SKLabelNode)
        menu = (childNode(withName: "menu") as! SKLabelNode)
        victory = (childNode(withName: "victory") as! SKLabelNode)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        if menu.frame.contains(touch.location(in: self)) {
            let menuScene = SKScene(fileNamed: "MenuScene")!
            menuScene.scaleMode = self.scaleMode
            view?.presentScene(menuScene)
        }
        
        if reset.frame.contains(touch.location(in: self)) {
            let frogScene = SKScene(fileNamed: "FrogScene")!
            frogScene.scaleMode = self.scaleMode
            view?.presentScene(frogScene)
        }
        
        if !playable {
            return
        }
        
        for i in 0...6 {
            if leaves[i].frame.contains(touch.location(in: self)) {
                moveFrog(i: i)
            }
        }
    }
    
    private func moveFrog(i: Int) {
        let frog = frogs[i]
        switch frog.kind {
        case .none:
            return
        case .green:
            if i + 1 > 6 {
                return
            }else if frogs[i+1].kind == .none {
                frogs.swapAt(i, i+1)
                jump(frogName: frog.name, step: 1)
            } else if i + 2 > 6 {
                return
            } else if frogs[i+2].kind == .none {
                frogs.swapAt(i, i+2)
                jump(frogName: frog.name, step: 2)
            } else {
                return
            }
        case .red:
            if i - 1 < 0 {
                return
            }else if frogs[i-1].kind == .none {
                frogs.swapAt(i, i-1)
                jump(frogName: frog.name, step: -1)
            } else if i - 2 < 0 {
                return
            } else if frogs[i-2].kind == .none {
                frogs.swapAt(i, i-2)
                jump(frogName: frog.name, step: -2)
            } else {
                return
            }
        }
        
        //judge is won
        if isWon() {
            victory.isHidden = false
            playable = false
        }
    }
    
    private func jump(frogName: String, step: CGFloat) {
        guard let frog = childNode(withName: frogName) else {
            return
        }
        
        frog.run(SKAction.sequence([
            SKAction.move(by: CGVector(dx: distanceBetweenLeaf * step / 2 , dy: frog.frame.height), duration: 0.25),
            SKAction.move(by: CGVector(dx: distanceBetweenLeaf * step / 2 , dy: -frog.frame.height), duration: 0.25)
        ]))
    }
    
    private func isWon() -> Bool {
        for i in 0...2 {
            if frogs[i].kind != .red {
                return false
            }
        }
        
        for i in 4...6 {
            if frogs[i].kind != .green {
                return false
            }
        }
        
        return true
    }
}

struct Frog {
    var kind: Kind
    var name: String
}

enum Kind {
    case green
    case red
    case none
}
