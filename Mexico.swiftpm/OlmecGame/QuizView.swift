//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 09/01/25.
//

import SwiftUI

struct QuizView: View {
    let question: String           // Pregunta
    let options: [String]          // Opciones de respuesta
    let correctAnswer: String      // Respuesta correcta
    @Binding var isVisible: Bool   // Controla la visibilidad del Quiz
    @Binding var isAnswered: Bool  // Controla si la pregunta fue respondida correctamente

    @State private var selectedOption: String? // Opción seleccionada
    @State private var showFeedback = false    // Mostrar retroalimentación

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
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            
            if showFeedback {
                Text(selectedOption == correctAnswer ? "Correct!" : "Wrong Answer!")
                    .font(.headline)
                    .foregroundColor(selectedOption == correctAnswer ? .green : .red)
            }

            Button("Close") {
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
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(
            question: "What material were the heads made of?",
            options: ["A) Clay", "B) Basalt", "C) Gold"],
            correctAnswer: "B) Basalt",
            isVisible: .constant(true),
            isAnswered: .constant(false)
        )
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
