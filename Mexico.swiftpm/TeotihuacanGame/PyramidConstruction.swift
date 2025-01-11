//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import SpriteKit

class PyramidConstruction {
    private let scene: SKScene
    private var pyramidLayers: [SKSpriteNode] = []
    private var currentLayer = 0

    init(scene: SKScene) {
        self.scene = scene
    }

    func start() {
        setupPyramidLayers()
        dropBlocks()
    }

    private func setupPyramidLayers() {
        for i in 0..<5 {
            let layer = SKSpriteNode(color: .gray, size: CGSize(width: scene.size.width - CGFloat(i * 50), height: 50))
            layer.position = CGPoint(x: scene.size.width / 2, y: CGFloat(100 + (i * 50)))
            scene.addChild(layer)
            pyramidLayers.append(layer)
        }
    }

    private func dropBlocks() {
        let wait = SKAction.wait(forDuration: 1.0)
        let dropAction = SKAction.run {
            let block = SKSpriteNode(color: .brown, size: CGSize(width: 50, height: 50))
            block.position = CGPoint(x: CGFloat.random(in: 50...(self.scene.size.width - 50)), y: self.scene.size.height - 50)
            self.scene.addChild(block)

            let moveDown = SKAction.moveTo(y: 100, duration: 3.0)
            let checkPlacement = SKAction.run {
                self.currentLayer += 1
                if self.currentLayer >= self.pyramidLayers.count {
                    self.endPhase()
                }
            }
            block.run(SKAction.sequence([moveDown, checkPlacement]))
        }
        scene.run(SKAction.repeatForever(SKAction.sequence([wait, dropAction])))
    }

    private func endPhase() {
        scene.removeAllActions()
        let successLabel = SKLabelNode(text: GameConstants.layerMessage)
        successLabel.fontSize = 24
        successLabel.fontColor = .black
        successLabel.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        scene.addChild(successLabel)
    }
}
