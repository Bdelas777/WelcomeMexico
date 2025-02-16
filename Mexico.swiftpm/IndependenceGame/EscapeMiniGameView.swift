import SwiftUI

struct EscapeMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var playerPosition = CGSize(width: 0.1, height: 0.5)
    @State private var goalPosition = CGSize(width: 0.9, height: 0.5)
    @State private var enemyPositions: [CGSize] = [
        CGSize(width: CGFloat.random(in: 0.4...0.8), height: CGFloat.random(in: 0.2...0.8)),
        CGSize(width: CGFloat.random(in: 0.4...0.8), height: CGFloat.random(in: 0.2...0.8))
    ]
    @State private var moveTimer: Timer? = nil
    
    // Animation states
    @State private var currentPlayerFrame = 0
    @State private var currentEnemyFrame = 0
    @State private var isPlayerMoving = false
    @State private var isMovingLeft = false
    @State private var lastX: CGFloat = 0
    
    // Animation frames
    let playerFrames = ["char_walk1", "char_walk2", "char_walk3", "char_walk4"]
    let enemyFrames = ["enemy_walk1", "enemy_walk2", "enemy_walk3", "enemy_walk4"]
    let goalImage = "castle"
    
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
                    .frame(width: 500, height: 500)
                    .position(
                        x: goalPosition.width * geometry.size.width,
                        y: goalPosition.height * geometry.size.height
                    )
                    .shadow(radius: 10)
                    .padding(.trailing, 80)

                // Animated player with flipping
                Image(isPlayerMoving ? playerFrames[currentPlayerFrame] : playerFrames[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .scaleEffect(x: isMovingLeft ? -1 : 1, y: 1)
                    .position(
                        x: playerPosition.width * geometry.size.width,
                        y: playerPosition.height * geometry.size.height
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                isPlayerMoving = true
                                if lastX == 0 {
                                    lastX = value.location.x
                                } else {
                                    isMovingLeft = value.location.x < lastX
                                    lastX = value.location.x
                                }
                                movePlayer(to: value.location, bounds: geometry.size)
                            }
                            .onEnded { _ in
                                isPlayerMoving = false
                                currentPlayerFrame = 0
                                lastX = 0
                            }
                    )
                    .shadow(radius: 10)
                    .padding(.leading, 40)

                ForEach(0..<enemyPositions.count, id: \.self) { index in
                    Image(enemyFrames[currentEnemyFrame])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 700, height: 700)
                        .scaleEffect(x: playerPosition.width < enemyPositions[index].width ? -1 : 1, y: 1)
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
                startAnimations()
            }
            .onDisappear {
                stopEnemyMovement()
            }
            .onReceive(Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()) { _ in
                checkCollision()
                checkWin(geometrySize: geometry.size)
            }
        }
    }
    
    private func startAnimations() {
        Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { _ in
            if isPlayerMoving {
                currentPlayerFrame = (currentPlayerFrame + 1) % playerFrames.count
            }
            currentEnemyFrame = (currentEnemyFrame + 1) % enemyFrames.count
        }
    }

    private func movePlayer(to location: CGPoint, bounds: CGSize) {
        withAnimation(.easeInOut(duration: 0.1)) {
            playerPosition.width = min(max(location.x / bounds.width, 0.0), 1.0)
            playerPosition.height = min(max(location.y / bounds.height, 0.0), 1.0)
        }
    }

    private func startEnemyMovement() {
        moveTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            for index in enemyPositions.indices {
                var enemy = enemyPositions[index]

                let dx = playerPosition.width - enemy.width
                let dy = playerPosition.height - enemy.height
                let distance = sqrt(dx * dx + dy * dy)

                let randomSpeed: CGFloat = CGFloat.random(in: 0.001...0.004)

                if distance > 0.01 {
                    // Asegurarse de que el enemigo siempre se mueva, incluso si el jugador está cerca
                    enemy.width += (dx / distance) * randomSpeed
                    enemy.height += (dy / distance) * randomSpeed
                }

                enemyPositions[index] = enemy
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
        let goalWidth: CGFloat = 800
        let goalHeight: CGFloat = 800
        let distanceThreshold: CGFloat = goalWidth * 0.3

        // Usar distancia entre las posiciones en vez de comparar las posiciones absolutas
        let playerX = playerPosition.width * geometrySize.width
        let playerY = playerPosition.height * geometrySize.height
        let goalX = goalPosition.width * geometrySize.width
        let goalY = goalPosition.height * geometrySize.height

        let distance = sqrt(pow(playerX - goalX, 2) + pow(playerY - goalY, 2))

        if distance < distanceThreshold {
            viewModel.score += 10
            endGame()
        }
    }

   
    private func endGame() {
        stopEnemyMovement()
        viewModel.gameState = .finalQuestion
    }
}
