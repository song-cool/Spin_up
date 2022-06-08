//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/23.
//

import Foundation
import SpriteKit

class SpinnerNode: SKSpriteNode {
  
    
    init() {
        let texture = SKTexture(imageNamed: "test")
        let textureSize = texture.size()
        
        super.init(texture: texture, color: .white, size: textureSize)

        size.width = size.width / 2
        size.height = size.height / 2
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.allowsRotation = true
        physicsBody?.restitution = 0.2
        physicsBody?.friction = 0
        physicsBody?.mass = 0.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
