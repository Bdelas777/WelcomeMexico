//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct AllianceMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).edgesIgnoringSafeArea(.all)  // Fondo oscuro con mayor opacidad para mayor enfoque

            VStack(spacing: 30) {  // Más espacio entre los elementos para mayor claridad
                // Pregunta
                Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                    .font(.system(size: 30, weight: .bold, design: .rounded))  // Mayor tamaño y negrita para mayor impacto
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)  // Espaciado horizontal para mayor comodidad
                    .shadow(radius: 10)  // Sombra más pronunciada para el texto
                
                // Opciones de respuesta
                ForEach(viewModel.dialogOptions) { option in
                    Button(action: {
                        viewModel.handleSelection(option)
                    }) {
                        Text(option.text)
                            .font(.title2)  // Tamaño de fuente grande para las opciones
                            .fontWeight(.medium)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)  // Sombra más fuerte para los botones
                            .scaleEffect(viewModel.showDialog ? 1.05 : 1.0)
                            .animation(.spring(), value: viewModel.showDialog)
                    }
                    .padding(.horizontal, 40)  // Aseguramos que los botones tengan un buen espaciado
                }
                
                // Barra de progreso
                ProgressBarView(value: viewModel.progressBarValue)
                    .padding(.horizontal, 40)  // Espaciado horizontal para la barra de progreso
                
                // Mensaje de diálogo
                if viewModel.showDialog {
                    Text(viewModel.gameMessage)
                        .font(.title3)  // Tamaño moderado para el mensaje
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(15)
                        .shadow(radius: 10)  // Sombra para dar efecto de profundidad
                }
            }
            .padding()
        }
        .onAppear {
            if let route = viewModel.routes.first {
                viewModel.startGame(with: route)
            }
        }
    }
}

struct ProgressBarView: View {
    var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 12)  // Mayor altura para la barra
                    .foregroundColor(.gray.opacity(0.5))
                    .cornerRadius(6)  // Bordes más suaves

                Rectangle()
                    .frame(width: CGFloat(value) * geometry.size.width, height: 12)
                    .foregroundColor(.green)
                    .cornerRadius(6)  // Bordes redondeados
                    .shadow(radius: 10)  // Sombra más destacada
            }
        }
        .frame(height: 12)  // Aseguramos que la barra tenga altura
    }
}
