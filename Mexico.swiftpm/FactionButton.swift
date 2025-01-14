//
//  SwiftUIView.swift
//  Mexico
//
//  Created by Alumno on 09/01/25.
//

import SwiftUI

struct FactionButton: View {
    let faction: Faction
    let selectFaction: (Faction) -> Void
    let isSelected: Bool
    @Binding var animateIcon: Bool
    
    var body: some View {
        Button(action: {
            selectFaction(faction)
        }) {
            VStack {
                Image(faction.imageName)
                    .resizable()
                    .frame(width: 130, height: 130)
                    .shadow(radius: 5)
                    .scaleEffect(isSelected && animateIcon ? 1.2 : 1) // Escala de animación
                    .rotationEffect(isSelected && animateIcon ? .degrees(10) : .degrees(0)) // Giro suave
                    .animation(.easeInOut(duration: 0.3), value: animateIcon)
                
                Text(faction.name)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.black.opacity(0.6)) // Fondo oscuro semitransparente
                    .cornerRadius(5)

            }
        }
    }
}
