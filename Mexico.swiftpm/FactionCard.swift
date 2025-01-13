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
            Image(faction.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .cornerRadius(12)
            
            Text(faction.name)
                .font(.title)
                .bold()
                .foregroundColor(.primary)
            
            Text(faction.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                onPlay()
                isVisible = false
            }) {
                Text("Play")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Button(action: {
                withAnimation {
                    isVisible = false
                }
            }) {
                Text("Close")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}
