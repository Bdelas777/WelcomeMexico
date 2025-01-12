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
            // Progress bar
            ProgressView(value: viewModel.timeRemaining, total: viewModel.gameDuration)
                .padding()
            
            Text(String(format: "Time: %.1f", viewModel.timeRemaining))
                .font(.headline)
                .padding(.bottom)
            
            ScoreView(viewModel: viewModel)
            
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
                                    viewModel.draggedCulture = culture
                                    viewModel.updateCulturePosition(culture.id, position: value.location)
                                }
                                .onEnded { value in
                                    let dropPoint = value.location
                                    // Check which zone it was dropped in
                                    if dropPoint.y > 400 { // Assuming zones are at bottom
                                        let isLeftZone = dropPoint.x < UIScreen.main.bounds.width / 2
                                        let zoneName = isLeftZone ? "Allies" : "Non-Allies"
                                        
                                        if viewModel.checkPlacement(culture.id, at: dropPoint, in: zoneName) {
                                            viewModel.score += 100
                                            if viewModel.score >= 300 { // Win condition
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
            
            HStack {
                DropZone(title: "Allies")
                DropZone(title: "Non-Allies")
            }
        }
    }
}
