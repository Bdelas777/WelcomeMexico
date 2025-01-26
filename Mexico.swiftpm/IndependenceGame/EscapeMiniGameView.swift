//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct EscapeMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var playerPosition = CGSize(width: 0.1, height: 0.5)
    @State private var goalPosition = CGSize(width: 0.9, height: 0.5)
    @State private var enemyPositions: [CGSize] = [
        CGSize(width: CGFloat.random(in: 0.2...0.8), height: CGFloat.random(in: 0.2...0.8)),
        CGSize(width: CGFloat.random(in: 0.2...0.8), height: CGFloat.random(in: 0.2...0.8))
    ]
    @State private var playerImage = "player"
    @State private var enemyImage = "enemy"
    @State private var goalImage = "goal"
    @State private var moveTimer: Timer? = nil

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("Bosque")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                Image(goalImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .position(
                        x: goalPosition.width * geometry.size.width,
                        y: goalPosition.height * geometry.size.height
                    )
                    .shadow(radius: 10)
                    .padding(.trailing, 80)

                Image(playerImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
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
                    .shadow(radius: 10)
                    .padding(.leading, 40)

                ForEach(0..<enemyPositions.count, id: \.self) { index in
                    Image(enemyImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .position(
                            x: enemyPositions[index].width * geometry.size.width,
                            y: enemyPositions[index].height * geometry.size.height
                        )
                        .shadow(radius: 10)
                        .padding(.leading, 40)
                }

                VStack {
                    Spacer()
                    HStack {
                        Text("Score: \(viewModel.score)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
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

    private func movePlayer(to location: CGPoint, bounds: CGSize) {
        withAnimation(.easeInOut(duration: 0.1)) {
            playerPosition.width = min(max(location.x / bounds.width, 0.0), 1.0)
            playerPosition.height = min(max(location.y / bounds.height, 0.0), 1.0)
        }
    }

    private func startEnemyMovement() {
        moveTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            withAnimation {
                for index in enemyPositions.indices {
                    let enemy = enemyPositions[index]
                    let dx = playerPosition.width - enemy.width
                    let dy = playerPosition.height - enemy.height
                    let distance = sqrt(dx * dx + dy * dy)

                    let speed: CGFloat = 0.0025
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

    private func checkCollision() {
        for enemyPosition in enemyPositions {
            if abs(playerPosition.width - enemyPosition.width) < 0.05 &&
                abs(playerPosition.height - enemyPosition.height) < 0.05 {
                endGame()
                return
            }
        }
    }

    private func checkWin() {
        if abs(playerPosition.width - goalPosition.width) < 0.05 &&
            abs(playerPosition.height - goalPosition.height) < 0.05 {
            viewModel.score += 10
            endGame()
        }
    }

    private func endGame() {
        stopEnemyMovement()
        viewModel.gameState = .finalQuestion
    }
}
