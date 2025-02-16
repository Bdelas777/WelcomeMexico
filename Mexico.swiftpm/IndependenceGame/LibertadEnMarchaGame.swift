import SwiftUI

struct LibertadEnMarchaGame: View {
    @StateObject private var viewModel = GameViewModelIndependence()
    @State private var selectedRoute: Route?
    @State private var showMiniGame = false
    @State private var animateRoute = false
    @State private var showInstructions = false
    @ObservedObject var musicManager: BackgroundMusicManager
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundView
                
                switch viewModel.gameState {
                case .selecting:
                    routeSelectionView
                case .playing:
                    gamePlayView
                case .miniGame:
                    if let route = viewModel.currentRoute {
                        switch route.type {
                        case .alliance:
                            AllianceMiniGameView(viewModel: viewModel)
                        case .escape:
                            EscapeMiniGameView(viewModel: viewModel)
                        case .tactical:
                            TacticalMiniGameView(viewModel: viewModel)
                        }
                    }
                case .finalQuestion:
                    FinalQuestionView(viewModel: viewModel)
                case .gameOver:
                    GameOverView(score: viewModel.score, isVictory: viewModel.score > -100)
                }
                
                if showInstructions {
                    InstructionsView(routeType: viewModel.currentRoute?.type ?? .alliance,
                                   showInstructions: $showInstructions) {
                        viewModel.startGame(with: selectedRoute!)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .preferredColorScheme(.light)
        .onAppear { musicManager.playMusic(named: "indepe") }
        .onDisappear { musicManager.stopMusic() }
    }
    
    private var backgroundView: some View {
        Image("Indepe")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            .overlay(Color.black.opacity(0.2))
    }
    
    private var routeSelectionView: some View {
            HStack(spacing: 20) {
                ForEach(viewModel.routes) { route in
                    RouteCardView(route: route, isSelected: selectedRoute == route)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedRoute = route
                                viewModel.currentRoute = route  // Set current route
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    showInstructions = true
                                }
                            }
                        }
                }
            }
            .padding()
        }

    private var gamePlayView: some View {
        VStack {
            HStack {
                Spacer()
                HStack(spacing: 20) {
                    Text("Time: \(viewModel.timeRemaining)s")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("Score: \(viewModel.score)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                }
                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.5))
            
            if let route = viewModel.currentRoute {
                switch route.type {
                case .alliance:
                    AllianceMiniGameView(viewModel: viewModel)
                case .escape:
                    EscapeMiniGameView(viewModel: viewModel)
                case .tactical:
                    TacticalMiniGameView(viewModel: viewModel)
                }
            }
        }
    }
}

struct InstructionsView: View {
    var routeType: RouteType
    @Binding var showInstructions: Bool
    var onClose: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showInstructions = false
                    onClose()
                }
            
            VStack(spacing: 30) {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showInstructions = false
                            onClose()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.7)))
                    }
                    .padding(2)
                                    }
                
                Text("Mission Briefing")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.yellow)
                    .shadow(color: .white, radius: 10)
                
                getInstructionsContent(for: routeType)
                    .font(.title2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(15)
                
                Button(action: {
                    showInstructions = false
                    onClose()
                }) {
                    Text("Begin Mission")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: 300)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                         startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                }
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 30)
            .background(Color.black.opacity(0.85))
            .cornerRadius(25)
            .frame(maxWidth: 700)
            .padding()
        }
    }
    
    @ViewBuilder
    private func getInstructionsContent(for routeType: RouteType) -> some View {
        VStack(spacing: 20) {
            switch routeType {
            case .alliance:
                Text("Shape Mexico's destiny through diplomatic decisions. Build alliances and influence the path to independence.")
            case .escape:
                Text("Navigate through the castle avoiding enemy patrols. Select your character to move it strategically and reach the castle safely to win!")
            case .tactical:
                VStack(spacing: 15) {
                    Text("Command your forces using tactical decisions:")
                    Text("• Attack: Launch an offensive\n• Defend: Protect your position\n• Recover: Restore forces\n• Wait: Observe enemy movements")
                }
            }
        }
    }
}

