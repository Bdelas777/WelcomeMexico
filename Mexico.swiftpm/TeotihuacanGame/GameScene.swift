//
//  File.swift
//  
//
//  Created by Alumno on 10/01/25.
//
import SpriteKit
import UIKit
import AVFoundation

class GameScene: SKScene {
    // Variables globales para rastrear el progreso del juego
    var timerLabel: SKLabelNode!
    var gameTimer: Timer?
    var timeRemaining = 60

    var materials: [String] = ["Obsidiana", "Adobe", "Piedra Volcánica", "Cal", "Arena", "Madera"]
    var selectedMaterials: [String] = []
    let correctMaterials = ["Obsidiana", "Adobe", "Piedra Volcánica", "Cal"]

    var materialImages: [String: SKSpriteNode] = [
        "Obsidiana": SKSpriteNode(imageNamed: "Obsidiana"),
        "Adobe": SKSpriteNode(imageNamed: "Adobe"),
        "Piedra Volcánica": SKSpriteNode(imageNamed: "Piedra"),
        "Cal": SKSpriteNode(imageNamed: "Cal"),
        "Arena": SKSpriteNode(imageNamed: "Arena"),
        "Madera": SKSpriteNode(imageNamed: "Madera")
    ]

    var pyramidBase: SKSpriteNode!
    var isBuildingPhase = false
    var playerVoice = AVAudioPlayer()

    override func didMove(to view: SKView) {
        backgroundColor = .white

        // Reproducir voz en off de introducción
        playIntroVoice()

        // Configurar temporizador
        timerLabel = SKLabelNode(text: "Time: 60")
        timerLabel.fontName = "AvenirNext-Bold"
        timerLabel.fontSize = 24
        timerLabel.position = CGPoint(x: size.width - 80, y: size.height - 50)
        addChild(timerLabel)

        // Configurar base de la pirámide
        pyramidBase = SKSpriteNode(color: .gray, size: CGSize(width: 200, height: 50))
        pyramidBase.position = CGPoint(x: size.width / 2, y: 100)
        addChild(pyramidBase)

        // Comenzar la fase de selección de materiales
        startMaterialSelectionPhase()
        startTimer()
    }

    func playIntroVoice() {
        guard let introSound = Bundle.main.path(forResource: "introVoice", ofType: "mp3") else { return }
        do {
            playerVoice = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: introSound))
            playerVoice.play()
        } catch {
            print("Error al reproducir la voz en off: \(error)")
        }

        // Mostrar mensaje de introducción en pantalla
        let introLabel = SKLabelNode(text: "Welcome to Teotihuacán! Your task is to gather the right materials and help build the Pyramid of the Sun. Let's go!")
        introLabel.fontName = "AvenirNext-Bold"
        introLabel.fontSize = 20
        introLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        introLabel.fontColor = .black
        addChild(introLabel)

        // Hacer que el mensaje desaparezca después de 5 segundos
        introLabel.run(SKAction.sequence([
            SKAction.fadeIn(withDuration: 0.5),
            SKAction.wait(forDuration: 5.0),
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.removeFromParent()
        ]))
    }

    func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        timeRemaining -= 1
        timerLabel.text = "Time: \(timeRemaining)"

        if timeRemaining == 30 && !isBuildingPhase {
            // Cambiar a la fase de construcción
            startBuildingPhase()
        }

        if timeRemaining <= 0 {
            gameTimer?.invalidate()
            endGame()
        }
    }

    func startMaterialSelectionPhase() {
        for (index, material) in materials.enumerated() {
            let materialNode = SKLabelNode(text: material)
            materialNode.name = material
            materialNode.fontName = "AvenirNext-Bold"
            materialNode.fontSize = 18
            materialNode.position = CGPoint(x: size.width / 2, y: size.height - CGFloat(100 + index * 30))
            materialNode.isUserInteractionEnabled = true
            addChild(materialNode)
        }
    }

    func startBuildingPhase() {
        isBuildingPhase = true
        removeAllChildren()

        backgroundColor = .cyan

        let buildLabel = SKLabelNode(text: "Place the blocks to build the pyramid!")
        buildLabel.fontName = "AvenirNext-Bold"
        buildLabel.fontSize = 20
        buildLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        addChild(buildLabel)

        addChild(timerLabel) // Re-agregar temporizador a la escena

        for _ in 0..<10 {
            let block = SKSpriteNode(color: .brown, size: CGSize(width: 50, height: 20))
            block.position = CGPoint(x: CGFloat.random(in: 50...(size.width - 50)), y: size.height - 50)
            block.name = "Block"
            addChild(block)
        }
    }

    func showMessage(_ text: String) {
        let messageLabel = SKLabelNode(text: text)
        messageLabel.fontName = "AvenirNext-Bold"
        messageLabel.fontSize = 18
        messageLabel.fontColor = .red
        messageLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(messageLabel)

        messageLabel.run(SKAction.sequence([
            SKAction.fadeIn(withDuration: 0.5),
            SKAction.wait(forDuration: 1.0),
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.removeFromParent()
        ]))
    }

    func showCuriosity(for material: String) {
        var curiosityText = ""

        switch material {
        case "Obsidiana":
            curiosityText = "Obsidiana: This volcanic glass was used to make sharp tools and weapons!"
        case "Adobe":
            curiosityText = "Adobe: Light and easy to transport, adobe was perfect for building in this vast city."
        case "Piedra Volcánica":
            curiosityText = "Piedra Volcánica: Strong volcanic stone helped the pyramid stand for centuries."
        case "Cal":
            curiosityText = "Cal: Mixed with water, cal helped bind the stones together securely."
        case "Arena":
            curiosityText = "Arena: Used to fill the gaps between the stones, sand was an essential material."
        case "Madera":
            curiosityText = "Madera: Wood was used for scaffolding and temporary structures during the building process."
        default:
            curiosityText = "This material has an interesting history!"
        }

        showMessage(curiosityText)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if let node = nodes(at: location).first(where: { materials.contains($0.name ?? "") }) {
            showCuriosity(for: node.name ?? "")
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if let node = nodes(at: location).first(where: { $0.name == "Block" || correctMaterials.contains($0.name ?? "") }) {
            node.position = location
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if let node = nodes(at: location).first(where: { $0.name == "Block" }) {
            if node.frame.intersects(pyramidBase.frame) {
                node.removeFromParent()
                showMessage("This layer represents a vital part of the structure!")
            } else {
                node.run(SKAction.sequence([
                    SKAction.scale(to: 0.5, duration: 0.1),
                    SKAction.scale(to: 1.0, duration: 0.1)
                ]))
                showMessage("Incorrect placement! Try again.")
            }
        }
    }

    func endGame() {
        removeAllChildren()

        let endLabel = SKLabelNode(text: "Great job! You’ve built the Pyramid of the Sun!")
        endLabel.fontName = "AvenirNext-Bold"
        endLabel.fontSize = 20
        endLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(endLabel)
    }
}

