//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 09/01/25.
//

import SwiftUI

struct QuizView: View {
    let question: String
    let options: [String]
    let correctAnswer: String
    @Binding var isVisible: Bool
    @Binding var isAnswered: Bool
    let onCorrectAnswer: () -> Void
    
    @State private var selectedOption: String?
    @State private var showFeedback = false
    @State private var feedbackMessage: String = ""
    @State private var shake = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Pregunta con estilo pixel art
            Text(question)
                .font(.custom("PressStart2P-Regular", size: 14)) // Fuente tipo pixel art
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.white, lineWidth: 2)
                )
            
            // Opciones estilo pixel art
            ForEach(options, id: \.self) { option in
                Button(action: {
                    handleAnswer(option: option)
                }) {
                    Text(option)
                        .font(.custom("PressStart2P-Regular", size: 12)) // Fuente tipo pixel art
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedOption == option ?
                            (selectedOption == correctAnswer ? Color.green : Color.red) :
                            Color.gray
                        )
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(x: selectedOption == option && selectedOption != correctAnswer && shake ? -5 : 0)
                        .animation(
                            shake ? Animation.default.repeatCount(5).speed(4) : .default,
                            value: shake
                        )
                }
            }
            
            // Feedback de respuesta correcta o incorrecta
            if showFeedback {
                Text(feedbackMessage)
                    .font(.custom("PressStart2P-Regular", size: 14))
                    .foregroundColor(feedbackMessage == "¡Correcto!" ? .green : .red)
                    .padding(8)
                    .background(Color.black)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 3)
        )
        .shadow(color: .gray, radius: 5, x: 2, y: 2)
    }
    
    private func handleAnswer(option: String) {
        selectedOption = option
        showFeedback = true
        feedbackMessage = option == correctAnswer ? "¡Correcto!" : "¡Incorrecto!"
        
        if option == correctAnswer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isVisible = false
                isAnswered = true
                onCorrectAnswer()
            }
        } else {
            // Animación de shake para respuesta incorrecta
            shake = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                shake = false
            }
        }
    }
}
