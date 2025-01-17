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
                
                Text("¡Bienvenido a Córdoba!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .scaleEffect(animateText ? 1 : 0.5) // Animación de escala
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(0.5), value: animateText)
                
                Text("En este juego podrás elegir entre 3 mini juegos con el objetivo de conocer la independencia de México.")
                    .font(.title2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .scaleEffect(animateText ? 1 : 0.5) // Animación de escala
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(1), value: animateText)
                
                Text("Al final, se te hará una pregunta curiosa para ver si realmente lo has aprendido.")
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .scaleEffect(animateText ? 1 : 0.5) // Animación de escala
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(1.5), value: animateText)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        showMainGame = true
                    }
                }) {
                    Text("¡Comenzar el juego!")
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
                animateText = true // Activar animaciones cuando la vista aparezca
            }
            
            // Mostrar el juego cuando el botón es presionado
            if showMainGame {
                LibertadEnMarchaGame()
            }
        }
    }
    
    private var backgroundView: some View {
        Image("Indepe") // Asegúrate de que esta imagen exista
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .overlay(Color.black.opacity(0.5)) // Capa para mejorar la visibilidad del texto
    }
}



