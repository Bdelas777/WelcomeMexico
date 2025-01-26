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
    
    @State private var isAppearing = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Congratulations!")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .scaleEffect(isAppearing ? 1 : 0.5)
                    .opacity(isAppearing ? 1 : 0)
                    .animation(.easeOut(duration: 0.7), value: isAppearing)
                
                Text("Amazing work! You've contributed to the creation of one of the grandest pyramids in all of Mesoamerica—a true marvel of ancient ingenuity!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .scaleEffect(isAppearing ? 1 : 0.5)
                    .opacity(isAppearing ? 1 : 0)
                    .animation(.easeOut(duration: 0.7).delay(0.2), value: isAppearing)
                
                Text("Final score: \(estado.puntuacion)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .scaleEffect(isAppearing ? 1 : 0.5)
                    .opacity(isAppearing ? 1 : 0)
                    .animation(.easeOut(duration: 0.7).delay(0.4), value: isAppearing)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Return to main menu")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .scaleEffect(isAppearing ? 1 : 0.5)
                        .opacity(isAppearing ? 1 : 0)
                        .animation(.easeOut(duration: 0.7).delay(0.6), value: isAppearing)
                }
            }
            .padding()
        }
        .onAppear {
            isAppearing = true 
        }
    }
}
