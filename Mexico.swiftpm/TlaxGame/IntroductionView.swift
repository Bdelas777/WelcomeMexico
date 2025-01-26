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
                .scaleEffect(1.1)
                .animation(.easeInOut, value: 1)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.opacity)
        }
    }
}
