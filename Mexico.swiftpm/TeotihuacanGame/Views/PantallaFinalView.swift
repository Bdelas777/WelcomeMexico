//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import SwiftUI

struct PantallaFinalView: View {
    @ObservedObject var estado: EstadoJuego
    @Environment(\.dismiss) var dismiss
    
    @State private var isAppearing = false // Estado para las animaciones
    
    var body: some View {
        ZStack {
            // Fondo con la imagen de la pirámide
          
            
            VStack(spacing: 20) {
                Text("¡Felicitaciones!")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .scaleEffect(isAppearing ? 1 : 0.5) // Animación de escala
                    .opacity(isAppearing ? 1 : 0) // Animación de opacidad
                    .animation(.easeOut(duration: 0.7), value: isAppearing) // Animación de entrada
                
                Text("Great job! You've helped build one of the largest pyramids in Mesoamerica.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .scaleEffect(isAppearing ? 1 : 0.5) // Animación de escala
                    .opacity(isAppearing ? 1 : 0) // Animación de opacidad
                    .animation(.easeOut(duration: 0.7).delay(0.2), value: isAppearing) // Animación con retraso
                
                Text("Puntuación final: \(estado.puntuacion)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .scaleEffect(isAppearing ? 1 : 0.5) // Animación de escala
                    .opacity(isAppearing ? 1 : 0) // Animación de opacidad
                    .animation(.easeOut(duration: 0.7).delay(0.4), value: isAppearing) // Animación con retraso
                
                Button(action: {
                    dismiss() // Regresar al menú principal
                }) {
                    Text("Return to main menu")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5) // Sombra para hacer el botón más visible
                        .scaleEffect(isAppearing ? 1 : 0.5) // Animación de escala
                        .opacity(isAppearing ? 1 : 0) // Animación de opacidad
                        .animation(.easeOut(duration: 0.7).delay(0.6), value: isAppearing) // Animación con retraso
                }
            }
            .padding()
        }
        .onAppear {
            isAppearing = true // Al aparecer la vista, activa las animaciones
        }
    }
}
