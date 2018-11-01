//
//  SKLabelButtonNode.swift
//  GameDemos
//
//  Created by Ma Xueyuan on 2018/11/01.
//  Copyright © 2018 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class SKLabelButtonNode: SKLabelNode {
    weak var buttonPressedDelegate: ButtonPressedDelegate!
    var normalColor: UIColor!
    var pressedColor: UIColor!
    var buttonId: String!
    
    internal init(normalColor: UIColor, pressedColor: UIColor, buttonId: String) {
        super.init()
        self.normalColor = normalColor
        self.pressedColor = pressedColor
        self.buttonId = buttonId
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fontColor = pressedColor
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fontColor = normalColor
        if let touch = touches.first {
            let location = touch.location(in: self)
            if self.frame.contains(location) {
                buttonPressedDelegate.buttonPressed(buttonId: buttonId)
            }
        }
    }
}
