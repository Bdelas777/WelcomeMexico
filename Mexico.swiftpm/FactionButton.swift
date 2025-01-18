//
//  SwiftUIView.swift
//  Mexico
//
//  Created by Alumno on 09/01/25.
//

import SwiftUI

struct FactionButton: View {
    let faction: Faction
    let selectFaction: () -> Void
    let isSelected: Bool
    let isLocked: Bool
    @Binding var animateIcon: Bool

    var body: some View {
        Button(action: {
            if !isLocked { selectFaction() }
        }) {
            VStack {
                Image(faction.imageName)
                
                    .resizable()
                    .frame(width: 130, height: 130)
                    .shadow(radius: 5)
                    .scaleEffect(isSelected && animateIcon ? 1.2 : 1) // Escala de animación
                    .rotationEffect(isSelected && animateIcon ? .degrees(10) : .degrees(0)) // Giro suave
                    .animation(.easeInOut(duration: 0.3), value: animateIcon)
                    .opacity(isLocked ? 0.5 : 1.0)
                

                Text(faction.name)
                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.black.opacity(0.6)) // Fondo oscuro semitransparente
                                    .cornerRadius(5)
                    .foregroundColor(isLocked ? .gray : .primary)
            }
        }
        .disabled(isLocked)
    }
}
