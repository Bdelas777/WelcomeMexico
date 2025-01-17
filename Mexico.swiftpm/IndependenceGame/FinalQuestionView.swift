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
        ZStack {
            // Fondo con opacidad para destacar la vista
            Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Título con mayor énfasis
                Text(question)
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .shadow(radius: 5)
                
                // Opciones de respuesta con estilo mejorado
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
                                    Color.blue.opacity(0.8)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .scaleEffect(selectedAnswer == nil ? 1.0 : 0.95) // Animación de reducción al seleccionar
                            .animation(.spring(), value: selectedAnswer) // Animación suave al seleccionar
                    }
                    .disabled(selectedAnswer != nil)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
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
