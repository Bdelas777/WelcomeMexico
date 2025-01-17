//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import SwiftUI

struct JuegoPiramideView: View {
    @StateObject private var estado = EstadoJuego()
    
    var body: some View {
        ZStack {
            // Fondo con una imagen personalizada
            Image("teotihua") // Asegúrate de tener la imagen en el proyecto con este nombre
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Hace que la imagen cubra toda la pantalla
            
            // Capa con opacidad para mejorar la legibilidad del contenido
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Barra superior con tiempo y puntos
                HStack {
                    Text("Tiempo: \(estado.tiempoRestante)s")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 40) // Espaciado a la izquierda
                    Spacer()
                    Text("Puntos: \(estado.puntuacion)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.trailing, 40) // Espaciado a la derecha
                }
                .padding(.top, 20) // Añadir un poco de espacio en la parte superior

                Spacer() // Esto empuja el contenido hacia la parte superior

                // Switch entre las diferentes fases del juego
                switch estado.fase {
                case .inicio:
                    PantallaInicioView(estado: estado)
                case .seleccionMateriales:
                    SeleccionMaterialesView(estado: estado)
                case .construccion:
                    ConstruccionPiramideView(estado: estado)
                case .finalizado:
                    PantallaFinalView(estado: estado)
                }
                
                Spacer() // Esto empuja el contenido hacia la parte inferior
            }
            .padding()
        }
    }
}
