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
            // Fondo de códice
            Image("citytlax")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 5) // Desenfoque sutil para el fondo
            
            Color.black.opacity(0.6) // Opacidad para mejorar la legibilidad
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Mensaje principal con un borde para mayor visibilidad
                Text("The Tlaxcaltecs saw Cortés arrive and said, 'Freedom may be near.'")
                    .font(.custom("PressStart2P-Regular", size: 28))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black.opacity(0.5)) // Fondo semitransparente para el texto
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
                Text("Choose your allies to rewrite history!")
                    .font(.custom("PressStart2P-Regular", size: 24))
                    .foregroundColor(.yellow)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                // Botón con efecto de animación
                Button("Start Game") {
                    withAnimation {
                        viewModel.startGame()
                    }
                }
                .font(.custom("PressStart2P-Regular", size: 20))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .scaleEffect(1.1) // Efecto de escala al pulsar
                .animation(.easeInOut, value: 1) // Animación de botón al presionar
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.opacity)
        }
    }
}
