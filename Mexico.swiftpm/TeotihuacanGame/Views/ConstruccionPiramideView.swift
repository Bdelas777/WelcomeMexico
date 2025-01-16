import SwiftUI

struct ConstruccionPiramideView: View {
    @ObservedObject var estado: EstadoJuego
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Cálculo y visualización de las zonas de arrastre
                let zonasDeArrastre = calcularZonasDeArrastre(geometry: geometry)
                
                // Mostrar zonas de arrastre sobre la pirámide
                ForEach(zonasDeArrastre.indices, id: \.self) { index in
                    let zona = zonasDeArrastre[index]
                    Rectangle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 120, height: 120)
                        .position(zona)
                        .border(Color.blue, width: 2)
                }
                
                // Bloques en movimiento
                ForEach(estado.bloques.indices, id: \.self) { index in
                    if !estado.bloques[index].estaColocado {
                        Image("Piedra")
                            .resizable()
                            .frame(width: 118, height: 118)
                            .position(estado.bloques[index].posicion)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        estado.bloques[index].posicion = value.location
                                    }
                                    .onEnded { _ in
                                        if let zonaValida = zonasDeArrastre.first(where: { zona in
                                            abs(zona.x - estado.bloques[index].posicion.x) < 60 &&
                                                abs(zona.y - estado.bloques[index].posicion.y) < 60
                                        }) {
                                            withAnimation {
                                                estado.bloques[index].estaColocado = true
                                                estado.puntuacion += 10
                                                estado.verificarFinConstruccion()
                                            }
                                        } else {
                                            estado.bloques[index].posicion = CGPoint(x: 300, y: 800)
                                        }
                                    }
                            )
                    } else {
                        Image("Piedra")
                            .resizable()
                            .frame(width: 118, height: 118)
                            .position(estado.bloques[index].posicion)
                    }
                }

                // Contador de bloques colocados
                VStack {
                    Text("Bloques colocados: \(estado.bloques.filter { $0.estaColocado }.count)/\(estado.bloques.count)")
                        .font(.title2)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.top)
                    Spacer()
                }
            }
        }
    }

    // Calcula las posiciones de las zonas de arrastre con la pirámide volteada
    private func calcularZonasDeArrastre(geometry: GeometryProxy) -> [CGPoint] {
        var zonas: [CGPoint] = []
        let tamano = 120.0
        
        // Calcula el ancho total de la pirámide
        let piramideWidth = CGFloat(4) * tamano + CGFloat(3) * 4 // 4 rectángulos en la base, 3 espacios entre ellos

        // Calcula el punto central horizontal
        let centerX = geometry.size.width / 2
        
        // Calcula la posición inicial X para la primera fila
        let startX = centerX - piramideWidth / 2 + tamano / 2

        let baseY = geometry.size.height / 2 - 100 // Ajuste vertical invertido para voltear la pirámide

        // Ahora calculamos las posiciones para las zonas de arrastre en forma piramidal invertida
        for fila in 0..<4 {
            let bloquesEnFila = fila + 1
            let piramideWidthFila = CGFloat(bloquesEnFila) * tamano + CGFloat(bloquesEnFila - 1)
            let startXFila = centerX - piramideWidthFila / 2 + tamano / 2 // Calcula el inicio X para cada fila

            for columna in 0..<bloquesEnFila {
                let x = startXFila + Double(columna) * (tamano)
                let y = baseY + Double(fila) * tamano // Invertimos la dirección del eje Y
                zonas.append(CGPoint(x: x, y: y))
            }
        }
        return zonas
    }
}
