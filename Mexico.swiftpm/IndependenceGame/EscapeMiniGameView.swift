//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct EscapeMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var soldierPosition = CGFloat.random(in: 0.2...0.8)
    @State private var playerPosition = CGFloat(0.5)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Camino
                Rectangle()
                    .fill(Color.brown)
                    .frame(width: geometry.size.width, height: 100)
                    .position(x: geometry.size.width/2, y: geometry.size.height/2)
                
                // Jugador
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .position(
                        x: playerPosition * geometry.size.width,
                        y: geometry.size.height/2
                    )
                
                // Soldado
                Circle()
                    .fill(Color.red)
                    .frame(width: 30, height: 30)
                    .position(
                        x: soldierPosition * geometry.size.width,
                        y: geometry.size.height/2
                    )
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        playerPosition = value.location.x / geometry.size.width
                        checkCollision()
                    }
            )
        }
    }
    
    private func checkCollision() {
        if abs(playerPosition - soldierPosition) < 0.1 {
            viewModel.score -= 5
            soldierPosition = CGFloat.random(in: 0.2...0.8)
        }
    }
}
