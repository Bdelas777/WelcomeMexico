//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//
import SwiftUI

extension Array {
    func mezclado() -> [Element] {
        return self.shuffled()
    }
}

struct SeleccionMaterialesView: View {
    @ObservedObject var estado: EstadoJuego
    @State private var mostrarDescripcion: String?
    @State private var materialesBarajados: [Material] = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Selecciona los materiales correctos y evita seleccionar los materiales incorrectos")
                .font(.title2)
                .padding(.bottom, 10)
                .foregroundColor(.white)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(materialesBarajados) { material in
                        MaterialCardView(
                            material: material,
                            estaSeleccionado: estado.materialesSeleccionados.contains(material.id),
                            onTap: {
                                withAnimation {
                                    if estado.materialesSeleccionados.contains(material.id) {
                                        estado.cambiarSeleccionDeMaterial(id: material.id)
                                        mostrarDescripcion = nil // Limpiar descripción si se deselecciona
                                    } else {
                                        estado.cambiarSeleccionDeMaterial(id: material.id)
                                        mostrarDescripcion = material.descripcion
                                    }
                                }
                            }
                        )
                        .frame(height: 400)
                    }
                }
                .padding(.horizontal)
            }
            
            if let descripcion = mostrarDescripcion {
                Text(descripcion)
                    .font(.body)
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            materialesBarajados = estado.materiales.mezclado()
        }
    }
}
