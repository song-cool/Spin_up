//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import SwiftUI
import SpriteKit
import CoreMotion


class GameScene: SKScene { //An object that organizes all of the active SpriteKit content.
    
    //MARK: - Properties
    let gameManager = GameManager.shared
    var motionManager: CMMotionManager?
    var timer = Timer()
    
    let testNode = SpinnerNode()

    //MARK: - Initializer
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    override func update(_ currentTime: TimeInterval) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
//        let testAnimation = SKAction.sequence([SKAction.applyAngularImpulse(10, duration: 0.1)])
//        testNode.run(testAnimation)
    }
    
    //Tells you when the scene is presented by a view.
    override func didMove(to view: SKView) {
        // 외부 프레임에 물리적 테두리 부여를 해야 화면 밖으로 안날라감.
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0)))
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
//        let background = SKSpriteNode(imageNamed: "background")
        backgroundColor = .white

        testNode.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(testNode)
        
        let testAnimation = SKAction.sequence([SKAction.applyAngularImpulse(10, duration: 0.5)])
        testNode.run(testAnimation)
    
//        let logoNode = SKSpriteNode(imageNamed: "Logo")
//        logoNode.size = CGSize(width: 600, height: 400)
//        logoNode.position = CGPoint(x: frame.midX, y: frame.maxY - 200)
//        logoNode.zPosition = -100
//        self.addChild(logoNode)
    }
}

//MARK: - SKPhysicsContactDelegate
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //접촉이 시작되었을 때 해당 메서드 실행됨

    }
}
