//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct EscapeMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var playerPosition = CGSize(width: 0.1, height: 0.5) // Comienza en el lado izquierdo
    @State private var goalPosition = CGSize(width: 0.9, height: 0.5)   // Meta al lado derecho
    @State private var enemyPositions: [CGSize] = [
        CGSize(width: CGFloat.random(in: 0.2...0.8), height: CGFloat.random(in: 0.2...0.8)),
        CGSize(width: CGFloat.random(in: 0.2...0.8), height: CGFloat.random(in: 0.2...0.8))
    ]
    @State private var playerImage = "player" // Reemplaza con el asset del jugador
    @State private var enemyImage = "enemy"  // Reemplaza con el asset del enemigo
    @State private var goalImage = "goal"    // Reemplaza con el asset de la meta
    @State private var moveTimer: Timer? = nil

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fondo del juego
                Rectangle()
                    .fill(Color.green)
                    .edgesIgnoringSafeArea(.all)

                // Meta
                Image(goalImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .position(
                        x: goalPosition.width * geometry.size.width,
                        y: goalPosition.height * geometry.size.height
                    )

                // Jugador
                Image(playerImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .position(
                        x: playerPosition.width * geometry.size.width,
                        y: playerPosition.height * geometry.size.height
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                movePlayer(to: value.location, bounds: geometry.size)
                            }
                    )

                // Enemigos
                ForEach(0..<enemyPositions.count, id: \.self) { index in
                    Image(enemyImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .position(
                            x: enemyPositions[index].width * geometry.size.width,
                            y: enemyPositions[index].height * geometry.size.height
                        )
                }
            }
            .onAppear {
                startEnemyMovement()
            }
            .onDisappear {
                stopEnemyMovement()
            }
            .onReceive(Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()) { _ in
                checkCollision()
                checkWin()
            }
        }
    }

    // Mueve al jugador al arrastrar
    private func movePlayer(to location: CGPoint, bounds: CGSize) {
        playerPosition.width = min(max(location.x / bounds.width, 0.0), 1.0)
        playerPosition.height = min(max(location.y / bounds.height, 0.0), 1.0)
    }

    // Movimiento de enemigos hacia el jugador (más lento)
    private func startEnemyMovement() {
        moveTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            withAnimation {
                for index in enemyPositions.indices {
                    let enemy = enemyPositions[index]
                    let dx = playerPosition.width - enemy.width
                    let dy = playerPosition.height - enemy.height
                    let distance = sqrt(dx * dx + dy * dy)

                    // Movimiento más lento hacia el jugador
                    let speed: CGFloat = 0.0025 // Velocidad reducida
                    enemyPositions[index].width += (dx / distance) * speed
                    enemyPositions[index].height += (dy / distance) * speed
                }
            }
        }
    }

    private func stopEnemyMovement() {
        moveTimer?.invalidate()
        moveTimer = nil
    }

    // Detecta colisiones con enemigos
    private func checkCollision() {
        for enemyPosition in enemyPositions {
            if abs(playerPosition.width - enemyPosition.width) < 0.05 &&
                abs(playerPosition.height - enemyPosition.height) < 0.05 {
                endGame()
                return
            }
        }
    }

    // Detecta si el jugador llegó a la meta
    private func checkWin() {
        if abs(playerPosition.width - goalPosition.width) < 0.05 &&
            abs(playerPosition.height - goalPosition.height) < 0.05 {
            viewModel.score += 10
            endGame()
        }
    }

    // Finaliza el juego y pasa al estado final
    private func endGame() {
        stopEnemyMovement()
        viewModel.gameState = .finalQuestion
    }
}
