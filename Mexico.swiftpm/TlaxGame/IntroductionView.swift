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
        VStack {
            Text("The Tlaxcaltecs saw Cortés arrive and said, 'Freedom may be near.' They saw him as a chance to break free from Aztec rule.")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Choose your allies to rewrite history!")
                .font(.title2)
                .padding()
            
            Button("Start Game") {
                withAnimation {
                    viewModel.startGame()
                }
            }
            .font(.title)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .transition(.opacity)
    }
}
