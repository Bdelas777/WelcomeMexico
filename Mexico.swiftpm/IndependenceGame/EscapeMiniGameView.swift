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
    @State private var goalImage = "castle"
    @State private var moveTimer: Timer? = nil

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("Bosque")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                // Aumentar el tamaño del castillo (4 veces más grande)
                Image(goalImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500) // Ajustado 4 veces más grande
                    .position(
                        x: goalPosition.width * geometry.size.width,
                        y: goalPosition.height * geometry.size.height
                    )
                    .shadow(radius: 10)
                    .padding(.trailing, 80)

                // Aumentar la altura del jugador (el doble de grande)
                Image(playerImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160) // Ajustado al doble de grande
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

                // Aumentar la altura de los enemigos (el doble de grande)
                ForEach(0..<enemyPositions.count, id: \.self) { index in
                    Image(enemyImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160) // Ajustado al doble de grande
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
                checkWin(geometrySize: geometry.size) // Pasar geometry.size
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

    private func checkWin(geometrySize: CGSize) {
        // Tamaño de la meta (ajustado al tamaño escalado)
        let goalWidth: CGFloat = 500 // El tamaño actualizado del castillo
        let goalHeight: CGFloat = 500

        // Ajustar la distancia en función del tamaño de la meta
        let distanceThreshold: CGFloat = goalWidth * 0.3 // 10% del tamaño de la meta como umbral

        // Comparar la distancia entre el jugador y la meta, considerando el tamaño
        if abs(playerPosition.width * geometrySize.width - goalPosition.width * geometrySize.width) < distanceThreshold &&
           abs(playerPosition.height * geometrySize.height - goalPosition.height * geometrySize.height) < distanceThreshold {
            viewModel.score += 10
            endGame()
        }
    }


    private func endGame() {
        stopEnemyMovement()
        viewModel.gameState = .finalQuestion
    }
}
