//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct FinalQuestionView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var selectedAnswer: String?
    
    let question = "¿Qué documento marcó el fin de la Guerra de Independencia de México?"
    let options = [
        "Tratado de Versalles",
        "Tratado de Córdoba",
        "Declaración de Independencia"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text(question)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    handleAnswer(option)
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedAnswer == option ?
                                (option == "Tratado de Córdoba" ? Color.green : Color.red) :
                                Color.blue
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(selectedAnswer != nil)
            }
        }
        .padding()
    }
    
    private func handleAnswer(_ answer: String) {
        selectedAnswer = answer
        if answer == "Tratado de Córdoba" {
            viewModel.score += 30
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            viewModel.gameState = .gameOver
        }
    }
}
