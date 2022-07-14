//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import CoreMotion
import SpriteKit
import SwiftUI


class GameScene: SKScene { //An object that organizes all of the active SpriteKit content.
    
    //MARK: - Properties
    let gameManager = GameManager.shared
    var motionManager: CMMotionManager?
    var timer = Timer()
    var velocityDelegate: ContentView?
    
    let testNode = SpinnerNode()
    let subNode = SpinnerNode()
    let subNode2 = SpinnerNode()
    let subNode3 = SpinnerNode()
    let subNode4 = SpinnerNode()

    //MARK: - Initializer
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override init() {
        super.init()

        
        let motionManager = CMMotionManager()
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.gyroUpdateInterval = 0.1
        self.motionManager = motionManager
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    override func update(_ currentTime: TimeInterval) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
//        let testAnimation = SKAction.sequence([SKAction.applyAngularImpulse(10, duration: 0.1)])
//        testNode.run(testAnimation)
//        print(testNode.physicsBody?.angularVelocity)
        
        
        velocityDelegate?.velocityChanged(velocity: Double(testNode.physicsBody!.angularVelocity))
        
        
        
    }
    
    //Tells you when the scene is presented by a view.
    override func didMove(to view: SKView) {
        // 외부 프레임에 물리적 테두리 부여를 해야 화면 밖으로 안날라감.
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0)))
        physicsWorld.contactDelegate = self
        
 
        
        backgroundColor = .white

        testNode.position = CGPoint(x: frame.midX, y: frame.midY)
        testNode.physicsBody?.collisionBitMask = 0
        testNode.physicsBody?.contactTestBitMask = 0
        testNode.physicsBody?.categoryBitMask = 0
        
        
        subNode.position = CGPoint(x: frame.midX, y: frame.midY)
        subNode.alpha = 0.2
        subNode.physicsBody?.collisionBitMask = 1
        subNode.physicsBody?.contactTestBitMask = 1
        subNode.physicsBody?.categoryBitMask = 1
        
        
        
        subNode2.position = CGPoint(x: frame.midX, y: frame.midY)
        subNode2.alpha = 0.1
        subNode2.physicsBody?.collisionBitMask = 2
        subNode2.physicsBody?.contactTestBitMask = 2
        subNode2.physicsBody?.categoryBitMask = 2
        
        
        
        subNode3.position = CGPoint(x: frame.midX, y: frame.midY)
        subNode3.alpha = 0.1
        subNode3.physicsBody?.collisionBitMask = 4
        subNode3.physicsBody?.contactTestBitMask = 4
        subNode3.physicsBody?.categoryBitMask = 4
        
        
        
        subNode4.position = CGPoint(x: frame.midX, y: frame.midY)
        subNode4.alpha = 0.1
        subNode4.physicsBody?.collisionBitMask = 8
        subNode4.physicsBody?.contactTestBitMask = 8
        subNode4.physicsBody?.categoryBitMask = 8
        
        
        
        self.addChild(subNode4)
        self.addChild(subNode3)
        self.addChild(subNode2)
        self.addChild(subNode)
        self.addChild(testNode)
        
        
        

        
        let swipeRight : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(GameScene.swipedRight))
        view.addGestureRecognizer(swipeRight)

    }
    
    
    //MARK: - Helpers
    @objc func swipedRight(sender: UIPanGestureRecognizer) {

        let velocity = sender.velocity(in: self.view)
        
        print("swipe gesture x : \(velocity.x)")
        

        let testAnimation = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 10000, duration: 0.1)])
       
        
        
        
//        let subAnimation = SKAction.sequence([SKAction.wait(forDuration: 0.02) ,SKAction.applyAngularImpulse(velocity.x / 100000, duration: 0.1)])
//        let subAnimation2 = SKAction.sequence([SKAction.wait(forDuration: 0.038) ,SKAction.applyAngularImpulse(velocity.x / 100000, duration: 0.1)])
//        let subAnimation3 = SKAction.sequence([SKAction.wait(forDuration: 0.054) ,SKAction.applyAngularImpulse(velocity.x / 100000, duration: 0.1)])
//        let subAnimation4 = SKAction.sequence([SKAction.wait(forDuration: 0.068) ,SKAction.applyAngularImpulse(velocity.x / 100000, duration: 0.1)])
        
        let subAnimation = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 10000, duration: 0.12)])
        let subAnimation2 = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 10000, duration: 0.18)])
        let subAnimation3 = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 10000, duration: 0.24)])
        let subAnimation4 = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 10000, duration: 0.3)])


        
        testNode.run(testAnimation)
        self.subNode.run(subAnimation)
        self.subNode2.run(subAnimation2)
        self.subNode3.run(subAnimation3)
        self.subNode4.run(subAnimation4)
        
        
        

    }
    
    func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
     {
       let touch = touches.first as! UITouch
       let location = touch.location(in: self)

       if testNode.frame.contains(location) {
        print("Swipe has started")
       }
     }
    
    func operateHaptic(intensity: Int) {
        
    }
}

//MARK: - SKPhysicsContactDelegate
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //접촉이 시작되었을 때 해당 메서드 실행됨

    }
}
