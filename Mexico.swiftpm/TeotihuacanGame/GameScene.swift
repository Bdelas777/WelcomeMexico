//
//  File.swift
//  
//
//  Created by Alumno on 10/01/25.
//
import SpriteKit
import SwiftUI

class GameScene: SKScene {
    var timer = 60
    var timerLabel: SKLabelNode!
    var phase = 1
    var score = 0

    override func didMove(to view: SKView) {
        guard size.width > 0 && size.height > 0 else {
            print("Scene size is invalid: \(size.width)x\(size.height)")
            return
        }

        setupBackground()
        setupTimerLabel()
        startTimer()

        if phase == 1 {
            displayIntroduction()
            startMaterialSelection()
        } else {
            startPyramidConstruction()
        }
    }

    private func setupBackground() {
        let background = SKSpriteNode(color: .cyan, size: size)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1 // Asegurar que el fondo esté detrás de otros nodos
        addChild(background)
    }

    private func setupTimerLabel() {
        timerLabel = SKLabelNode(text: "Time: \(timer)")
        timerLabel.fontSize = 24
        timerLabel.fontColor = .black
        timerLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        addChild(timerLabel)
    }

    private func startTimer() {
        let wait = SKAction.wait(forDuration: 1.0)
        let updateTimer = SKAction.run {
            self.timer -= 1
            self.timerLabel.text = "Time: \(self.timer)"
            if self.timer == 0 {
                self.timerEnded()
            }
        }
        run(SKAction.repeatForever(SKAction.sequence([wait, updateTimer])))
    }

    private func displayIntroduction() {
        let label = SKLabelNode(text: GameConstants.introductionMessage)
        label.fontSize = 24
        label.fontColor = .black
        label.numberOfLines = 0
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)

        let wait = SKAction.wait(forDuration: 3.0)
        let remove = SKAction.removeFromParent()
        label.run(SKAction.sequence([wait, remove]))
    }

    private func timerEnded() {
        removeAllActions()
        if phase == 1 {
            phase = 2
            timer = 30
            removeAllChildren()
            didMove(to: view!)
        } else {
            endGame()
        }
    }

    private func endGame() {
        removeAllChildren()
        let endLabel = SKLabelNode(text: GameConstants.completionMessage)
        endLabel.fontSize = 32
        endLabel.fontColor = .black
        endLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(endLabel)
    }

    private func startMaterialSelection() {
        let materialSelection = MaterialSelection(scene: self)
        materialSelection.start()
    }

    private func startPyramidConstruction() {
        let pyramidConstruction = PyramidConstruction(scene: self)
        pyramidConstruction.start()
    }
}

