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
    @State private var showInstructions = false // Estado para mostrar las instrucciones
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
                
                // Si se debe mostrar las instrucciones, lo hacemos en el modal
                if showInstructions {
                    InstructionsModalFinal(routeType: viewModel.currentRoute?.type ?? .alliance, showInstructions: $showInstructions) {
                        viewModel.startGame(with: selectedRoute!) // Inicia el juego después de cerrar el modal
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .preferredColorScheme(.light)
        .onAppear {
            musicManager.playMusic(named: "indepe")
        }
        .onDisappear {
            musicManager.stopMusic()
        }
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
                                showInstructions = true // Muestra el modal de instrucciones
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
                
                HStack {
                    Text("Tiempo: \(viewModel.timeRemaining)s")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("Puntos: \(viewModel.score)")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                }
                
                Spacer()
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

struct InstructionsModalFinal: View {
    var routeType: RouteType
    @Binding var showInstructions: Bool
    var onClose: () -> Void  // Acción cuando se cierra el modal
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showInstructions = false  // Cierra el modal si se toca afuera
                    onClose()  // Llama la función para iniciar el juego
                }
            
            VStack(spacing: 20) {
                Text("Instrucciones")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                
                Text(instructionsText(for: routeType))  // Texto según el tipo de ruta
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(20)
            .padding()
        }
    }
    
    private func instructionsText(for routeType: RouteType) -> String {
        switch routeType {
        case .alliance:
            return "Únete con tus aliados para tomar el control del territorio."
        case .escape:
            return "Escapa de los enemigos resolviendo acertijos y tomando decisiones rápidas."
        case .tactical:
            return "Planifica tus movimientos y toma decisiones estratégicas para ganar."
        }
    }
}
