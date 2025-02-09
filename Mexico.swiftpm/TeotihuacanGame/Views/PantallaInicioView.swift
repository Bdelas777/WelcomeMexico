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
            Image("teotihua")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
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
                
                Button("Start") {
                    estado.iniciarJuego()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
            }
            .padding()
        }
    }
}
