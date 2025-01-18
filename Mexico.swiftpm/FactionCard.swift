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
        VStack(spacing: 40) {
            // Imagen de la facción
            Image(faction.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 180) // Imagen más grande
                .padding(16)
                .background(Color.black.opacity(0.9)) // Fondo oscuro para el arte
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.yellow, lineWidth: 4) // Borde estilo videojuego
                )

            // Nombre de la facción
            Text(faction.name.uppercased())
                .font(.custom("PressStart2P-Regular", size: 24)) // Fuente retro más grande
                .foregroundColor(.yellow)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.black)
                .cornerRadius(12)
                .shadow(color: .yellow, radius: 10, x: 0, y: 0)

            // Descripción de la facción
            Text(faction.description)
                .font(.custom("PressStart2P-Regular", size: 18)) // Fuente retro más grande
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(16)
                .background(Color.black.opacity(0.95)) // Fondo más sólido
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 4)
                )

            // Botón de "Play"
            Button(action: {
                onPlay()
                isVisible = false
            }) {
                Text("PLAY")
                    .font(.custom("PressStart2P-Regular", size: 22)) // Texto más grande
                    .foregroundColor(.black)
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 3)
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
                    .font(.custom("PressStart2P-Regular", size: 18)) // Fuente más grande
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.red)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 3)
                    )
            }
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.black]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(24)
        .shadow(color: .black, radius: 15, x: 5, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.yellow, lineWidth: 6) // Borde general de la carta
        )
        .padding()
    }
}
