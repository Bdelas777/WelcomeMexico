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
            Image("teotihua")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Time: \(estado.tiempoRestante)s")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 40)
                    Spacer()
                    Text("Points: \(estado.puntuacion)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.trailing, 40)
                }
                .padding(.top, 20)

                Spacer()

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
                
                Spacer()
                
            .padding()
        }
    }
}
