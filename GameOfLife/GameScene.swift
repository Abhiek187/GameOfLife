//
//  GameScene.swift
//  GameOfLife
//
//  Created by Basanta Chaudhuri on 7/6/17.
//  Copyright © 2017 Abhishek Chaudhuri. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    /* UI objects */
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    var stepButton: MSButtonNode!
    var populationLabel: SKLabelNode!
    var generationLabel: SKLabelNode!
    
    /* Game objects */
    var gridNode: Grid!

    override func didMove(to view: SKView) {
        /* Set up scene here */
        
        /* Connect UI scene objects */
        playButton = self.childNode(withName: "playButton") as! MSButtonNode
        pauseButton = self.childNode(withName: "pauseButton") as! MSButtonNode
        stepButton = self.childNode(withName: "stepButton") as! MSButtonNode
        populationLabel = self.childNode(withName: "populationLabel") as! SKLabelNode
        generationLabel = self.childNode(withName: "generationLabel") as! SKLabelNode
        
        gridNode = self.childNode(withName: "gridNode") as! Grid
        
        /* Setup testing button selected handler */
        stepButton.selectedHandler = {
            self.stepSimulation()
        }
        
        /* Create an SKAction based counter, 0.5 second delay */
        let delay = SKAction.wait(forDuration: 0.5)
        
        /* Call the stepSimulation() method to advance the simulation */
        let callMethod = SKAction.perform(#selector(stepSimulation), onTarget: self)
        
        /* Create the delay, step cycle */
        let stepSequence = SKAction.sequence([delay, callMethod])
        
        /* Create an infinite simulation loop */
        let simulation = SKAction.repeatForever(stepSequence)
        
        /* Run simulation action */
        self.run(simulation)
        
        /* Default simulation to pause state */
        self.isPaused = true
        
        /* Setup play button selected handler */
        playButton.selectedHandler = { [unowned self] in
            self.isPaused = false
        }
        
        /* Setup pause button selected handler */
        pauseButton.selectedHandler = { [unowned self] in
            self.isPaused = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func stepSimulation() {
        /* Step simulation */
        
        /* Run next step in simulation */
        gridNode.evolve()
        
        /* Update UI label objects */
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
    }
}
