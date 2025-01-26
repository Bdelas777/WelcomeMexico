//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI


struct VictoryView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var animateStars = false
    
    var body: some View {
        ZStack {
            Image("citytlax")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Victory!")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.yellow)
                    .shadow(color: .white, radius: 10, x: 0, y: 0)
                    .padding()
                    .scaleEffect(animateStars ? 1.2 : 1.0)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            animateStars.toggle()
                        }
                    }
                
                // Descripción de victoria con fondo y borde
                Text("Thanks to your alliance, the Aztec Empire falls, and the Tlaxcaltecas secure their future!")
                    .font(.custom("PressStart2P-Regular", size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                
                // Efectos de celebración con animación
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.yellow)
                        .scaleEffect(animateStars ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animateStars)
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.yellow)
                        .scaleEffect(animateStars ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animateStars)
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.yellow)
                        .scaleEffect(animateStars ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animateStars)
                }
                .padding(.top)
                
                Button(action: {
                    dismiss() 
                }) {
                    Text("Return to main menu")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .scaleEffect(animateStars ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: animateStars)
                }
                .padding()
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
                animateStars.toggle()
            }
        }
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView(viewModel: GameViewModel())
    }
}
