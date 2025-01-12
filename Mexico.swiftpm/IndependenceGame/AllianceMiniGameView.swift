//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct AllianceMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    
    var body: some View {
        VStack(spacing: 20) {
            Text("¿Qué propuesta harías para sellar la alianza?")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            /*
            ForEach($viewModel.dialogOptions) { option in
                Button(action: {
                    handleSelection(option)
                }) {
                    Text(option.text)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }*/
        }
        .padding()
    }
    
    private func handleSelection(_ option: DialogOption) {
        if option.isCorrect {
            viewModel.score += 20
            viewModel.gameMessage = "¡Correcto! \(option.explanation)"
        } else {
            viewModel.gameMessage = option.explanation
        }
        viewModel.showDialog = true
    }
}
