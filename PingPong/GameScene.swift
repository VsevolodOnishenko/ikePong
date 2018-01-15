//
//  GameScene.swift
//  PingPong
//
//  Created by Vsevolod Onishchenko on 12.01.2018.
//  Copyright © 2018 Vsevolod Onishchenko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ikeBall = SKSpriteNode()
    var enemy = SKSpriteNode()
    var player = SKSpriteNode()
    
    var playerLabel = SKLabelNode()
    var enemyLabel = SKLabelNode()
        
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        ikeBall = self.childNode(withName: "ike") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        player.position.y = (-self.frame.height / 2) + 50
        
        playerLabel = self.childNode(withName: "playerLabel") as! SKLabelNode
        enemyLabel = self.childNode(withName: "enemyLabel") as! SKLabelNode
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        playerLabel.text = "\(score[0])"
        enemyLabel.text = "\(score[1])"
        ikeBall.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
    }
    
    func addScore(winner: SKSpriteNode) {
        ikeBall.position = CGPoint(x: 0, y: 0)
        ikeBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if winner == player {
            score[0] += 1
            ikeBall.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        }
        else if winner == enemy {
            score[1] += 1
            ikeBall.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -30))
        }
        playerLabel.text = "\(score[0])"
        enemyLabel.text = "\(score[1])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameType == .twoPlayers {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameType == .twoPlayers {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                   player.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
       
        switch currentGameType {
        case  .easy:
            enemy.run(SKAction.moveTo(x: ikeBall.position.x, duration: 1.3))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ikeBall.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ikeBall.position.x, duration: 0.5))
            break
        case .twoPlayers:
            break
        }
        
        if ikeBall.position.y <= player.position.y - 10 {
            addScore(winner: enemy)
        }
        else if ikeBall.position.y >= enemy.position.y + 10 {
            addScore(winner: player)
        }
    }
}
