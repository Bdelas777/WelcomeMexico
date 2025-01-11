//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import SwiftUI
import SpriteKit

struct GameViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameView {
        return GameView()
    }

    func updateUIViewController(_ uiViewController: GameView, context: Context) {}
}
