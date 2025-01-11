//
//  File.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import SpriteKit

class MaterialSelection {
    private let scene: SKScene
    private var materials: [SKSpriteNode] = []

    init(scene: SKScene) {
        self.scene = scene
    }

    func start() {
        spawnMaterials()
    }

    private func spawnMaterials() {
        guard scene.size.width > 0 && scene.size.height > 0 else {
            print("Scene size is invalid: \(scene.size.width)x\(scene.size.height)")
            return
        }
        
        for material in GameConstants.allMaterials {
            let texture = SKTexture(imageNamed: material.imageName)
            let materialNode = SKSpriteNode(texture: texture)
            materialNode.size = CGSize(width: 100, height: 100)
            materialNode.name = material.name

            // Ajusta las posiciones aleatorias para evitar rangos inválidos
            let xRange = max(materialNode.size.width / 2, scene.size.width / 2)...(scene.size.width - materialNode.size.width / 2)
            let yRange = max(scene.size.height / 2, materialNode.size.height / 2)...(scene.size.height - materialNode.size.height / 2)

            materialNode.position = CGPoint(
                x: CGFloat.random(in: xRange),
                y: CGFloat.random(in: yRange)
            )

            scene.addChild(materialNode)
            materials.append(materialNode)
        }
    }


}

