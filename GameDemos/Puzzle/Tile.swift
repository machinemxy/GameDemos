//
//  Tile.swift
//  GameDemos
//
//  Created by Ma Xueyuan on 2019/07/16.
//  Copyright © 2019 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class Tile: SKSpriteNode {
    init(x: Int, y: Int, colorId: Int) {
        super.init(texture: nil, color: Tile.getColor(colorId: colorId), size: CGSize(width: 75, height: 75))
        self.position.x = CGFloat(150 + x * 100)
        self.position.y = CGFloat(200 - y * 100)
        self.name = "\(colorId)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getColor(colorId: Int) -> UIColor {
        switch colorId {
        case 0:
            return UIColor.red
        case 1:
            return UIColor.green
        case 2:
            return UIColor.yellow
        case 3:
            return UIColor.blue
        default:
            return UIColor.purple
        }
    }
}
