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
                                            
                                            // Verificar si la colocación es correcta
                                            if viewModel.checkPlacement(cultureID: culture.id, location: dropPoint, zoneName: zoneName) {
                                                viewModel.score += 100
                                                if viewModel.score >= 300 {
                                                    viewModel.showVictory()
                                                }
                                                
                                                // Mostrar la descripción de la cultura
                                                viewModel.showMessage(message: culture.description, isCorrect: true)
                                            } else {
                                                // Mensaje de "wrong side"
                                                viewModel.showMessage(message: "Wrong side!", isCorrect: false)
                                                
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
                
                // Mostrar mensaje
                if let message = viewModel.message {
                    Text(message)
                        .font(.title) // Aumenta el tamaño del texto
                        .padding()
                        .foregroundColor(viewModel.isCorrectPlacement ? .green : .red) // Cambiar color según la colocación
                        .background(Color.white)
                        .cornerRadius(10)
                        .transition(.opacity)
                }
            }
        }
        .onAppear {
            viewModel.randomizeCulturePositions()
        }
    }
}
