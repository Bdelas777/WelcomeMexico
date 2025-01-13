//
//  SwiftUIView.swift
//  Mexico
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct MyPresentationView: View {
    let onDismiss: () -> Void // Acción cuando se cierra la introducción
    
    var body: some View {
        VStack {
            Text("¡Bienvenido a Libertad En Marcha!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Explora el contexto histórico de México y selecciona tu facción para participar en este emocionante viaje. Toma decisiones estratégicas y aprende mientras juegas.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button(action: onDismiss) {
                Text("Comenzar")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
        }
        .padding()
        /*.background(
            Image("backgroundImage") // Reemplaza con el nombre de tu imagen de fondo
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )*/
    }
}
