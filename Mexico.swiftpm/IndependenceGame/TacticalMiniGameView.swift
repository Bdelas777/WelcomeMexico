//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct TacticalMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var currentDecision: String?
    
    let decisions = [
        ("Usar el terreno montañoso", "Cruzar por el valle"),
        ("Viajar de noche", "Avanzar durante el día"),
        ("Dividir las fuerzas", "Mantener el grupo unido")
    ]
    
    var body: some View {
        VStack(spacing: 30) {
            Text("¡Toma una decisión táctica!")
                .font(.title)
                .multilineTextAlignment(.center)
            
            ForEach(decisions, id: \.0) { decision in
                HStack(spacing: 20) {
                    tacticalButton(decision.0)
                    tacticalButton(decision.1)
                }
            }
        }
        .padding()
    }
    
    private func tacticalButton(_ text: String) -> some View {
        Button(action: {
            handleDecision(text)
        }) {
            Text(text)
                .padding()
                .frame(width: 150)
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    private func handleDecision(_ decision: String) {
        currentDecision = decision
        // Lógica para evaluar la decisión táctica
        viewModel.score += 10
    }
}
