/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  InputHandler.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ON - TOUCH
     * * * * * * * * * * * * * * * * * * * * */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node     = self.atPoint(location)
            
            if (node.name == "PauseButton") || (node.name == "PauseLabel") {
                if (playing) {
                    if (!isPaused) {
                        blurScene()
                        isPaused = true
                    }
                        
                    else {
                        unblurScene()
                        isPaused = false
                    }
                    
                    hud.update(state: isPaused, score: player.getScore())
                }
            }
            
            else {
                if !isPaused && playing { addChild(player.fireLaser()) }
                
                if isPaused {
                    isPaused = false
                    unblurScene()
                }
                
                if (!playing) { resetGame() }
            }
        }
    }
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ON - MOTION
     * * * * * * * * * * * * * * * * * * * * */
    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
        if let ship = childNode(withName: player.getName()) as? SKSpriteNode {
            if let data = motionManager.accelerometerData {
                if fabs(data.acceleration.x) > 0.06 {
                    ship.physicsBody!.applyForce(CGVector(dx: 90 * CGFloat(data.acceleration.x), dy: 0))
                }
            }
        }
    }
}