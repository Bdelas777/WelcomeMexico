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
    
    var body: some View {
        VStack(spacing: 20) {
            Text("¡Felicitaciones!")
                .font(.title)
            
            Text("Great job! You've helped build one of the largest pyramids in Mesoamerica.")
                .multilineTextAlignment(.center)
            
            Text("Puntuación final: \(estado.puntuacion)")
                .font(.headline)
            
            Button(action: {
                dismiss()
            }) {
                Text("Return to main menu")
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
