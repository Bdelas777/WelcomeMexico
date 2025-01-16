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
            Text("Selecciona los materiales correctos")
                .font(.title2)
                .padding(.bottom, 10)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(materialesBarajados) { material in
                        MaterialCardView(
                            material: material,
                            estaSeleccionado: estado.materialesSeleccionados.contains(material.id),
                            onTap: {
                                withAnimation {
                                    if estado.materialesSeleccionados.contains(material.id) {
                                        estado.materialesSeleccionados.remove(material.id)
                                    } else {
                                        estado.materialesSeleccionados.insert(material.id)
                                        mostrarDescripcion = material.descripcion
                                        verificarSeleccionCorrecta()
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
            }
        }
        .onAppear {
            materialesBarajados = estado.materiales.mezclado()
        }
    }
    
    private func verificarSeleccionCorrecta() {
        if estado.materialesSeleccionados.count == estado.materiales.filter({ $0.esCorrectoParaPiramide }).count {
            estado.iniciarFaseConstruccion()
        }
    }
}
