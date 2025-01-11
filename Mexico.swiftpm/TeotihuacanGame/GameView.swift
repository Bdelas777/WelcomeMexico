//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//
import SwiftUI
import SpriteKit

class GameView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Crear la escena de SpriteKit
        let scene = GameScene(size: view.bounds.size)
        let skView = SKView(frame: view.bounds)
        skView.showsFPS = true
        skView.showsNodeCount = true
        view.addSubview(skView)

        // Presentar la escena
        skView.presentScene(scene)
    }
}


