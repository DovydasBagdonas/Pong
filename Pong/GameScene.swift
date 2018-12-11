//
//  GameScene.swift
//  tictac
//
//  Created by Dovydas on 04/04/2018.
//  Copyright © 2018 Dovydas. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var score = [Int]()
    var mainScore = SKLabelNode()
    var enemyScore = SKLabelNode()
    var winner = SKLabelNode()
    var ballspeed = 0
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        mainScore = self.childNode(withName: "mainScore") as! SKLabelNode
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        winner = self.childNode(withName: "winner") as! SKLabelNode
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 1
        border.restitution = 1
        
        self.physicsBody = border
        
        
    }

    func startGame(){
        score = [0,0]
        mainScore.text = "\(score[0])"
        enemyScore.text = "\(score[1])"
        winner.text = ""
        winner.isHidden = true
    }
    
    func gameWin(){
        winner.isHidden = false
        winner.text = "LAIMĖJAI BLEEE"
        self.physicsWorld.speed = 0.0
        self.speed = 0.0
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -30))
        }
        if score[0] == 5 || score[1] == 5 {
            gameWin()
        }
        print("test1", score[0])
        print("test2", score[1])
        mainScore.text = "\(score[0])"
        enemyScore.text = "\(score[1])"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.physicsWorld.speed == 0.0 {
            startGame()
            self.physicsWorld.speed = 1.0
            self.speed = 1.0
        }
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0))
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0))
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        enemy.run(SKAction.moveTo(x: ball.position.x , duration: 0.1))
      //  ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: -50))
        if ball.position.y <= main.position.y - 70 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 70 {
            addScore(playerWhoWon: main)
            
        }
    }
    
}
