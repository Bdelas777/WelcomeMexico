//
//  File.swift
//  
//
//  Created by Alumno on 14/01/25.
//


import SwiftUI

struct CelebrationView: View {
    @Environment(\.dismiss) var dismiss
    let foundCount: Int
    let totalCount: Int
    let resetGame: () -> Void
    
    @State private var animateText = false
    @State private var animateButton = false
    
    var body: some View {
        ZStack {
          
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("¡Congratulations!")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.yellow)
                    .shadow(color: .white, radius: 10, x: 0, y: 0)
                    .scaleEffect(animateText ? 1.2 : 1.0)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            animateText.toggle()
                        }
                    }

                Text("You found \(foundCount) of \(totalCount) monumental stone heads")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Return to main menu")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .scaleEffect(animateButton ? 1.1 : 1.0)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) {
                                animateButton.toggle()
                            }
                        }
                }
                .padding(.top, 30)
            }
            .padding()
            .background(Color.black.opacity(0.6))
            .cornerRadius(20)
            .padding()
        }
    }
}

struct CelebrationView_Previews: PreviewProvider {
    static var previews: some View {
        CelebrationView(foundCount: 5, totalCount: 10, resetGame: {})
    }
}
