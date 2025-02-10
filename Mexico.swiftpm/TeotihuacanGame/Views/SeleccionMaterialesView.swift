
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
            Text("Select the all correct materials and avoid choosing the wrong ones.")
                .font(.title)
                .padding(.bottom,5)
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
                                        mostrarDescripcion = nil
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
                    .font(.title2)
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



