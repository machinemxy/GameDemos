//
//  GameScene.swift
//  GameDemos
//
//  Created by Ma Xueyuan on 2018/08/31.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene, ButtonPressedDelegate {
    var gameScene: SKScene?
    
    override func didMove(to view: SKView) {
        let frogLabel = SKLabelButtonNode(normalColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), pressedColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), buttonId: "Frog")
        frogLabel.text = "Frog"
        frogLabel.fontSize = 64
        frogLabel.position = CGPoint(x: 0, y: 50)
        frogLabel.buttonPressedDelegate = self
        self.addChild(frogLabel)
        
        let puzzleLabel = SKLabelButtonNode(normalColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), pressedColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), buttonId: "Puzzle")
        puzzleLabel.text = "Puzzle"
        puzzleLabel.fontSize = 64
        puzzleLabel.position = CGPoint(x: 0, y: -50)
        puzzleLabel.buttonPressedDelegate = self
        self.addChild(puzzleLabel)
    }
    
    func buttonPressed(buttonId: String) {
        gameScene = SKScene(fileNamed: buttonId + "Scene")
        if let gameScene = gameScene {
            gameScene.scaleMode = self.scaleMode
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
            view?.presentScene(gameScene, transition: transition)
        }
    }
}
