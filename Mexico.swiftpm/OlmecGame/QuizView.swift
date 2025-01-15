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
    
    @State private var selectedOption: String?
    @State private var showFeedback = false
    @State private var shake = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(question)
                .font(.title2)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding()
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    handleAnswer(option: option)
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedOption == option ?
                            (selectedOption == correctAnswer ? Color.green : Color.red) :
                            Color.white
                        )
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .offset(x: selectedOption == option && selectedOption != correctAnswer && shake ? -5 : 0)
                        .animation(
                            shake ? Animation.default.repeatCount(5).speed(4) : .default,
                            value: shake
                        )
                }
            }
            
            if showFeedback {
                Text(selectedOption == correctAnswer ? "¡Correcto!" : "¡Respuesta Incorrecta!")
                    .font(.headline)
                    .foregroundColor(selectedOption == correctAnswer ? .green : .red)
            }
            
            Button("Cerrar") {
                isVisible = false
                if selectedOption == correctAnswer {
                    isAnswered = true
                }
            }
            .padding(.top, 10)
            .foregroundColor(.blue)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
    
    private func handleAnswer(option: String) {
        selectedOption = option
        showFeedback = true
        
        if option != correctAnswer {
            shake = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                shake = false
            }
        }
    }
}
