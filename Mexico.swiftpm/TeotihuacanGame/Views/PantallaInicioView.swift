//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import SwiftUI

struct PantallaInicioView: View {
    @ObservedObject var estado: EstadoJuego
    
    var body: some View {
        ZStack {
            // Fondo con imagen de la pirámide
            Image("teotihua") // Asegúrate de tener la imagen en el proyecto con este nombre
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Hace que la imagen cubra toda la pantalla
            
            // Capa semitransparente para mejorar la visibilidad del contenido
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Welcome to Teotihuacán!")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Text("Your task is to gather the right materials and help build the Pyramid of the Sun. Let's go!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .font(.title2)
                
                Button("¡Comenzar!") {
                    estado.iniciarJuego()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5) // Agrega sombra al botón para destacarlo
                
            }
            .padding()
        }
    }
}
