//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct LibertadEnMarchaGame: View {
    @StateObject private var viewModel = GameViewModelIndependence()
    @State private var selectedRoute: Route?
    @State private var showMiniGame = false
    @State private var animateRoute = false
    
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
                    GameOverView(score: viewModel.score, isVictory: viewModel.score > 50)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .preferredColorScheme(.light)
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                viewModel.startGame(with: route)
                            }
                        }
                    }            }
        }
        .padding()
    }

    
    private var gamePlayView: some View {
        VStack {
            HStack {
                Text("Tiempo: \(viewModel.timeRemaining)s")
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
                Text("Puntos: \(viewModel.score)")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            
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
