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
        VStack(spacing: 20) {
            Text("Welcome to Teotihuacán!")
                .font(.title)
            Text("Your task is to gather the right materials and help build the Pyramid of the Sun. Let's go!")
                .multilineTextAlignment(.center)
            
            Button("¡Comenzar!") {
                estado.iniciarJuego()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
