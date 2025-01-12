//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct GameOverView: View {
    let score: Int
    let isVictory: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            Text(isVictory ? "¡Victoria!" : "¡Fin del Juego!")
                .font(.largeTitle)
                .bold()
            
            Text("Puntuación Final: \(score)")
                .font(.title)
            
            Text("El Tratado de Córdoba en 1821 marcó el fin de la Guerra de Independencia de México. ¡México se hizo libre tras un largo conflicto!")
                .multilineTextAlignment(.center)
                .padding()
            
            if isVictory {
                Text("Agustín de Iturbide, un líder realista, cambió de bando y se unió a los insurgentes para lograr la independencia. ¡Finalmente se convirtió en el primer emperador de México!")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Button("Volver a Jugar") {
                // Lógica para reiniciar el juego
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(20)
        .padding()
    }
}
