//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//
import SwiftUI

struct SeleccionMaterialesView: View {
    @ObservedObject var estado: EstadoJuego
    @State private var mostrarDescripcion: String?
    
    var body: some View {
        VStack {
            Text("Selecciona los materiales correctos")
                .font(.title2)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(estado.materiales) { material in
                        MaterialCardView(material: material,
                                      estaSeleccionado: estado.materialesSeleccionados.contains(material.id),
                                      onTap: {
                            withAnimation {
                                if estado.materialesSeleccionados.contains(material.id) {
                                    estado.materialesSeleccionados.remove(material.id)
                                } else {
                                    estado.materialesSeleccionados.insert(material.id)
                                    mostrarDescripcion = material.descripcion
                                }
                            }
                        })
                    }
                }
            }
            
            if let descripcion = mostrarDescripcion {
                Text(descripcion)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .transition(.opacity)
            }
        }
        .padding()
    }
}
