//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct IntroductionView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var showInstructions = false
    
    var body: some View {
        ZStack {
            Image("citytlax")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 5)
            
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("The Tlaxcaltecs saw Cortés arrive and said, 'Freedom may be near.'")
                    .font(.custom("PressStart2P-Regular", size: 28))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                Text("They saw him as a chance to break free from Aztec rule.")
                    .font(.custom("PressStart2P-Regular", size: 28))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                // Instrucciones con un toque más cálido
                Text("Choose your allies to save the Tlaxcaltecas")
                    .font(.custom("PressStart2P-Regular", size: 24))
                    .foregroundColor(.yellow)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                Button("Start Game") {
                    self.showInstructions = true  
                }
                .font(.custom("PressStart2P-Regular", size: 20))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .scaleEffect(1.1)
                .animation(.easeInOut, value: 1)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.opacity)
        }
        if showInstructions {
            InstructionsModaltlax(showInstructions: $showInstructions) {
                viewModel.startGame()
            }
        }
    }
}


struct InstructionsModaltlax: View {
    @Binding var showInstructions: Bool
    var onClose: () -> Void  // Acción cuando se cierra el modal
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showInstructions = false  // Cierra el modal si se toca afuera
                    onClose()  // Llama la función para iniciar el juego
                }
            
            VStack(spacing: 20) {
                Text("Instrucciones")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                
                Text("Encuentra las papas cabezas colosales ocultas en la selva y responde las preguntas correctamente para ganar.")
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(20)
            .padding()
        }
    }
}

