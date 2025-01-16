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
    
    // Grid layout para tablet
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
                        .frame(height: 400) // Altura fija para las cartas
                    }
                }
                .padding(.horizontal)
            }
            
            if let descripcion = mostrarDescripcion {
                Text(descripcion)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .transition(.opacity)
            }
        }
        .padding()
        .onAppear {
            materialesBarajados = estado.materiales.mezclado()
        }
    }
    
    private func verificarSeleccionCorrecta() {
        let materialesCorrectos = estado.materiales.filter { $0.esCorrectoParaPiramide }
        let idsCorrectos = Set(materialesCorrectos.map { $0.id })
        
        if estado.materialesSeleccionados == idsCorrectos {
            // Esperar 2 segundos y pasar a la siguiente fase
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                estado.iniciarFaseConstruccion()
            }
        }
    }
}

