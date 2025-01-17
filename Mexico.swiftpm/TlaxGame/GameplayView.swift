//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//
import SwiftUI

struct GameplayView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            // Fondo del mapa
            Image("mesoamerica_map")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea() // Asegura que cubra toda la pantalla
            
            VStack {
                // Barra de progreso
                ProgressView(value: viewModel.timeRemaining, total: viewModel.gameDuration)
                    .padding()
                
                Text(String(format: "Time: %.1f seconds", viewModel.timeRemaining))
                    .font(.headline)
                    .padding(.bottom)
                
                // Puntuación
                Text("Score: \(viewModel.score)")
                    .font(.title)
                    .bold()
                    .padding()
                
                ZStack {
                    // Íconos de culturas
                    ForEach(viewModel.cultures) { culture in
                        CultureIcon(culture: culture)
                            .position(viewModel.culturePositions[culture.id] ?? culture.position)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        viewModel.draggedCulture = culture
                                        viewModel.updateCulturePosition(culture.id, position: value.location)
                                    }
                                    .onEnded { value in
                                        let dropPoint = value.location
                                        let screenHeight = UIScreen.main.bounds.height
                                        let screenWidth = UIScreen.main.bounds.width
                                        
                                        if dropPoint.y > screenHeight * 0.6 {
                                            let isLeftZone = dropPoint.x < screenWidth / 2
                                            let zoneName = isLeftZone ? "Allies" : "Non-Allies"
                                            
                                            if viewModel.checkPlacement(culture.id, at: dropPoint, in: zoneName) {
                                                viewModel.score += 100
                                                if viewModel.score >= 300 {
                                                    viewModel.showVictory()
                                                }
                                            } else {
                                                viewModel.resetCulturePosition(culture.id)
                                            }
                                        } else {
                                            viewModel.resetCulturePosition(culture.id)
                                        }
                                        viewModel.draggedCulture = nil
                                    }
                            )
                    }
                }
                
                Spacer()
                
                // Zonas de aliados y enemigos
                HStack {
                    DropZone(title: "Allies")
                    DropZone(title: "Non-Allies")
                }
            }
        }
        .onAppear {
            viewModel.randomizeCulturePositions()
        }
    }
}
