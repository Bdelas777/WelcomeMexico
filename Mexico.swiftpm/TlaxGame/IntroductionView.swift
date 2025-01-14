//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct IntroductionView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Image("pixelBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("The Tlaxcaltecs saw Cortés arrive and said, 'Freedom may be near.'")
                    .font(.custom("PressStart2P-Regular", size: 28)) // Fuente pixelada
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("They saw him as a chance to break free from Aztec rule.")
                    .font(.custom("PressStart2P-Regular", size: 28)) // Fuente pixelada
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Texto de instrucción
                Text("Choose your allies to rewrite history!")
                    .font(.custom("PressStart2P-Regular", size: 24)) // Fuente pixelada
                    .foregroundColor(.yellow)
                    .padding()
                
                // Botón para iniciar el juego
                Button("Start Game") {
                    withAnimation {
                        viewModel.startGame()
                    }
                }
                .font(.custom("PressStart2P-Regular", size: 20)) // Fuente pixelada
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.opacity)
        }
    }
}
