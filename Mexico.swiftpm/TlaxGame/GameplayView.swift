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
        VStack {
            // Barra de progreso corregida
            ProgressView(value: viewModel.timeRemaining, total: viewModel.gameDuration)
                .padding()
            
            Text(String(format: "Time: %.1f", viewModel.timeRemaining))
                .font(.headline)
                .padding(.bottom)
            
            ZStack {
                Image(systemName: "map")
                    .resizable()
                    .frame(width: 300, height: 200)
                
                ForEach(viewModel.cultures) { culture in
                    CultureIcon(culture: culture)
                        .position(culture.position)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Implementar lógica de arrastre
                                }
                                .onEnded { value in
                                    // Implementar lógica de colocación
                                }
                        )
                }
            }
            
            HStack {
                DropZone(title: "Allies")
                DropZone(title: "Non-Allies")
            }
        }
    }
}
