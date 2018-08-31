//
//  GameScene.swift
//  GameDemos
//
//  Created by Ma Xueyuan on 2018/08/31.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    var frogLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        frogLabel = childNode(withName: "frog") as! SKLabelNode
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        if frogLabel.frame.contains(touch.location(in: self)) {
            let frogScene = SKScene(fileNamed: "FrogScene")
            frogScene?.scaleMode = self.scaleMode
            view?.presentScene(frogScene)
        }
    }
}
