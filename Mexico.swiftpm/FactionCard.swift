//
//  File.swift
//  Mexico
//
//  Created by Alumno on 09/01/25.
//

import SwiftUI

struct FactionCard: View {
    let faction: Faction
    @Binding var isVisible: Bool
    let onPlay: () -> Void // Acción para iniciar el juego
    
    var body: some View {
        VStack(spacing: 20) {
            // Imagen del facción
            Image(faction.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .padding(8)
                .background(Color.black.opacity(0.8)) // Fondo oscuro para el arte
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.yellow, lineWidth: 3) // Borde estilo videojuego
                )
            
            // Nombre de la facción
            Text(faction.name.uppercased())
                .font(.custom("PressStart2P-Regular", size: 18)) // Fuente retro
                .foregroundColor(.yellow)
                .padding(.horizontal, 8)
                .background(Color.black)
                .cornerRadius(8)
                .shadow(color: .yellow, radius: 5, x: 0, y: 0)
            
            // Descripción de la facción
            Text(faction.description)
                .font(.custom("PressStart2P-Regular", size: 12)) // Fuente retro
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2)
                )
            
            // Botón de "Play"
            Button(action: {
                onPlay()
                isVisible = false
            }) {
                Text("PLAY")
                    .font(.custom("PressStart2P-Regular", size: 16))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
            .padding(.horizontal)
            
            // Botón de "Close"
            Button(action: {
                withAnimation {
                    isVisible = false
                }
            }) {
                Text("CLOSE")
                    .font(.custom("PressStart2P-Regular", size: 12))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.red)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.black]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(16)
        .shadow(color: .black, radius: 10, x: 5, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.yellow, lineWidth: 4) // Borde general de la carta
        )
        .padding()
    }
}
