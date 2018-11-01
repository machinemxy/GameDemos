//
//  GameScene.swift
//  GameDemos
//
//  Created by Ma Xueyuan on 2018/08/31.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene, ButtonPressedDelegate {
    override func didMove(to view: SKView) {
        let frogLabel = SKLabelButtonNode(normalColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), pressedColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), buttonId: "Frog")
        frogLabel.text = "Frog"
        frogLabel.fontSize = 64
        frogLabel.position = CGPoint(x: 0, y: 0)
        frogLabel.buttonPressedDelegate = self
        self.addChild(frogLabel)
    }
    
    func buttonPressed(buttonId: String) {
        let frogScene = SKScene(fileNamed: "FrogScene")
        frogScene?.scaleMode = self.scaleMode
        view?.presentScene(frogScene)
    }
    
    /*override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        if frogLabel.frame.contains(touch.location(in: self)) {
            let frogScene = SKScene(fileNamed: "FrogScene")
            frogScene?.scaleMode = self.scaleMode
            view?.presentScene(frogScene)
        }
    }*/
}
