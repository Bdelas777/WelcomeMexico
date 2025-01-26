//
//  File.swift
//  
//
//  Created by Alumno on 16/01/25.
//

import SwiftUI

// Vista de introducción del juego
struct IndepeView: View {
    @State private var showMainGame = false
    @State private var animateText = false
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack {
                Spacer()
                
                Text("Welcome to Córdoba!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .scaleEffect(animateText ? 1 : 0.5) 
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(0.5), value: animateText)
                Text("In this game, you’ll step into the boots of Agustín de Iturbide, leading the Realists during the Mexican War of Independence.")
                                   .font(.title2)
                                   .foregroundColor(.white)
                                   .multilineTextAlignment(.center)
                                   .padding(.top, 20)
                                   .scaleEffect(animateText ? 1 : 0.5) // Scale animation
                                   .opacity(animateText ? 1 : 0)
                                   .animation(.easeOut(duration: 1).delay(1), value: animateText)
                
                Text("Your mission: choose one of three exciting mini-games to strategize, negotiate, or outsmart the insurgents! But be warned, surprises await at every turn.")
                    .font(.title2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .scaleEffect(animateText ? 1 : 0.5)
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(1), value: animateText)
                
                Text("At the end, you’ll face a tricky quiz to see if you’ve mastered the art of leadership. Will you secure your place in history?")
                    .font(.title3)
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .scaleEffect(animateText ? 1 : 0.5)
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(1.5), value: animateText)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        showMainGame = true
                    }
                }) {
                    Text("Start")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 50)
                .opacity(animateText ? 1 : 0)
                .animation(.easeOut(duration: 1).delay(2), value: animateText)
            }
            .padding()
            .onAppear {
                animateText = true
            }
  
            if showMainGame {
                LibertadEnMarchaGame()
            }
        }
    }
    
    private var backgroundView: some View {
        Image("Indepe")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .overlay(Color.black.opacity(0.5))
    }
}



