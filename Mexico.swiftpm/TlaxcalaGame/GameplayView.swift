//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct GameplayView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var feedbackMessage: String = ""
    @State private var showFeedback: Bool = false
    
    var body: some View {
        VStack {
            // Barra de progreso y tiempo como antes...
            ProgressView(value: viewModel.timeRemaining, total: viewModel.gameDuration)
                .padding()
            
            Text(String(format: "Time: %.1f", viewModel.timeRemaining))
                .font(.headline)
                .padding(.bottom)
            
            // Puntuación
            Text("Score: \(viewModel.score)")
                .font(.headline)
                .padding()
            
            ZStack {
                Image(systemName: "map")
                    .resizable()
                    .frame(width: 300, height: 200)
                
                ForEach(viewModel.cultures) { culture in
                    CultureIcon(culture: culture)
                        .position(viewModel.culturePositions[culture.id] ?? culture.position)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    viewModel.draggedCultureId = culture.id
                                    viewModel.updateCulturePosition(culture.id,
                                        position: value.location)
                                }
                                .onEnded { value in
                                    let dropPoint = value.location
                                    
                                    // Detectar zona de colocación
                                    if dropPoint.y > 400 { // Ajusta según tu layout
                                        let isLeftSide = dropPoint.x < UIScreen.main.bounds.width / 2
                                        let zone = isLeftSide ? "Allies" : "Non-Allies"
                                        
                                        if viewModel.checkPlacement(culture.id, at: dropPoint, in: zone) {
                                            // Colocación correcta
                                            viewModel.score += 100
                                            feedbackMessage = "¡Correcto!"
                                            // Animar a la posición final en la zona
                                            withAnimation {
                                                viewModel.updateCulturePosition(culture.id,
                                                    position: CGPoint(x: isLeftSide ? 100 : 300, y: 450))
                                            }
                                        } else {
                                            // Colocación incorrecta
                                            feedbackMessage = "Intenta de nuevo"
                                            withAnimation {
                                                viewModel.resetCulturePosition(culture.id)
                                            }
                                        }
                                        showFeedback = true
                                        
                                        // Ocultar feedback después de un momento
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                            showFeedback = false
                                        }
                                    } else {
                                        // Soltar fuera de las zonas
                                        viewModel.resetCulturePosition(culture.id)
                                    }
                                    
                                    viewModel.draggedCultureId = nil
                                }
                        )
                        .scaleEffect(viewModel.draggedCultureId == culture.id ? 1.2 : 1.0)
                        .animation(.spring(), value: viewModel.draggedCultureId == culture.id)
                }
            }
            
            HStack {
                DropZone(title: "Allies")
                DropZone(title: "Non-Allies")
            }
            
            // Mensaje de feedback
            if showFeedback {
                Text(feedbackMessage)
                    .font(.title2)
                    .foregroundColor(feedbackMessage == "¡Correcto!" ? .green : .red)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
}
