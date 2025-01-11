//
//  File.swift
//  
//
//  Created by Alumno on 10/01/25.
//
import SpriteKit
import UIKit

class GameScene: SKScene {
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

    override func didMove(to view: SKView) {
        // Configuración inicial de la vista
        view.isMultipleTouchEnabled = true
        view.preferredFramesPerSecond = 60
        isUserInteractionEnabled = true
        
        backgroundColor = .white

        // Agregar el fondo
        let background = SKSpriteNode(imageNamed: "teotihuacan")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = -1
        addChild(background)

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

        // Instrucciones iniciales
        showMessage("¡Bienvenido al juego! Selecciona los materiales correctos para construir la pirámide.")

        // Comenzar el juego
        startMaterialSelectionPhase()
        startTimer()
    }

    func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        timeRemaining -= 1
        timerLabel.text = "Time: \(timeRemaining)"

        if timeRemaining == 30 && !isBuildingPhase {
            startBuildingPhase()
        }

        if timeRemaining <= 0 {
            gameTimer?.invalidate()
            endGame()
        }
    }

    func startMaterialSelectionPhase() {
        for (index, material) in materials.enumerated() {
            if let materialNode = materialImages[material] {
                materialNode.name = material
                materialNode.size = CGSize(width: 100, height: 100)
                materialNode.position = CGPoint(x: CGFloat.random(in: 50...(size.width - 50)),
                                             y: size.height - CGFloat(100 + index * 130))
                
                // Hacer el nodo interactivo
                materialNode.isUserInteractionEnabled = true
                materialNode.zPosition = 1
                
                // Crear un botón transparente para mejorar la interacción
                let button = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
                button.fillColor = .clear
                button.strokeColor = .clear
                button.name = "\(material)_button"
                button.position = .zero
                materialNode.addChild(button)
                
                addChild(materialNode)
            }
        }
    }

    func startBuildingPhase() {
        isBuildingPhase = true
        removeAllChildren()

        backgroundColor = .cyan

        let buildLabel = SKLabelNode(text: "¡Coloca los bloques para construir la pirámide!")
        buildLabel.fontName = "AvenirNext-Bold"
        buildLabel.fontSize = 20
        buildLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        addChild(buildLabel)

        addChild(timerLabel)

        // Crear bloques
        for _ in 0..<10 {
            let block = SKSpriteNode(color: .brown, size: CGSize(width: 50, height: 20))
            block.position = CGPoint(x: CGFloat.random(in: 50...(size.width - 50)), y: size.height - 50)
            block.name = "Block"
            block.isUserInteractionEnabled = true
            addChild(block)
        }
    }

    func showMessage(_ text: String) {
        // Fondo de mensaje
        let background = SKSpriteNode(color: .white, size: CGSize(width: 400, height: 60))
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.alpha = 0.8
        background.zPosition = 100
        addChild(background)

        let messageLabel = SKLabelNode(text: text)
        messageLabel.fontName = "AvenirNext-Bold"
        messageLabel.fontSize = 18
        messageLabel.fontColor = .red
        messageLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        messageLabel.zPosition = 101
        addChild(messageLabel)

        let fadeSequence = SKAction.sequence([
            SKAction.fadeIn(withDuration: 0.5),
            SKAction.wait(forDuration: 1.0),
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.removeFromParent()
        ])
        
        background.run(fadeSequence)
        messageLabel.run(fadeSequence)
    }

    func showCuriosity(for material: String) {
        var curiosityText = ""

        switch material {
        case "Obsidiana":
            curiosityText = "Obsidiana: ¡Este vidrio volcánico se usaba para hacer herramientas y armas afiladas!"
        case "Adobe":
            curiosityText = "Adobe: Ligero y fácil de transportar, ¡el adobe era perfecto para construir en esta vasta ciudad!"
        case "Piedra Volcánica":
            curiosityText = "Piedra Volcánica: ¡La fuerte piedra volcánica ayudó a que la pirámide resistiera durante siglos!"
        case "Cal":
            curiosityText = "Cal: Al mezclarla con agua, la cal ayudaba a unir las piedras con firmeza."
        default:
            curiosityText = "¡Este material tiene una historia interesante!"
        }

        showMessage(curiosityText)
    }

    func validateMaterial(_ material: String) {
        if correctMaterials.contains(material) {
            showMessage("\(material) es un material válido. ¡Buen trabajo!")
        } else {
            showMessage("\(material) no es un material válido. ¡Intenta de nuevo!")
        }
    }

    func handleMaterialSelection(_ materialName: String, node: SKNode) {
        validateMaterial(materialName)
        showCuriosity(for: materialName)
        
        // Efecto visual
        if let materialNode = node.parent as? SKSpriteNode ?? node as? SKSpriteNode {
            let scaleUp = SKAction.scale(to: 1.2, duration: 0.1)
            let scaleDown = SKAction.scale(to: 1.0, duration: 0.1)
            let highlight = SKAction.sequence([scaleUp, scaleDown])
            materialNode.run(highlight)
        }
        
        // Actualizar selección
        if correctMaterials.contains(materialName) && !selectedMaterials.contains(materialName) {
            selectedMaterials.append(materialName)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        for node in touchedNodes {
            // Buscar el material en la jerarquía de nodos
            var currentNode: SKNode? = node
            while let nodeToCheck = currentNode {
                if let materialName = nodeToCheck.name?.replacingOccurrences(of: "_button", with: ""),
                   materials.contains(materialName) {
                    handleMaterialSelection(materialName, node: nodeToCheck)
                    return
                }
                currentNode = nodeToCheck.parent
            }
            
            // Manejar bloques en la fase de construcción
            if isBuildingPhase && node.name == "Block" {
                node.position = location
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isBuildingPhase, let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let block = nodes(at: location).first(where: { $0.name == "Block" }) {
            block.position = location
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isBuildingPhase, let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let block = nodes(at: location).first(where: { $0.name == "Block" }) {
            if block.frame.intersects(pyramidBase.frame) {
                block.removeFromParent()
                showMessage("¡Esta capa representa una parte vital de la estructura!")
            } else {
                block.position = CGPoint(x: CGFloat.random(in: 50...(size.width - 50)), y: size.height - 50)
                showMessage("¡Intenta de nuevo! Colócalo correctamente.")
            }
        }
    }

    func endGame() {
        let endMessage = SKLabelNode(text: "¡Buen trabajo! Has ayudado a construir una de las pirámides más grandes de Mesoamérica.")
        endMessage.fontName = "AvenirNext-Bold"
        endMessage.fontSize = 30
        endMessage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        endMessage.fontColor = .red
        addChild(endMessage)
    }
}
