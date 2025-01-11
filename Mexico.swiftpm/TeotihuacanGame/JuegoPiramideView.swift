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
            Color.orange.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Tiempo: \(estado.tiempoRestante)s")
                    Spacer()
                    Text("Puntos: \(estado.puntuacion)")
                }
                .padding()
                
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
            }
        }
    }
}
