import SwiftUI
import Foundation
import CoreGraphics


struct ConstruccionPiramideView: View {
    @ObservedObject var estado: EstadoJuego
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let zonasDeArrastre = calcularZonasDeArrastre(geometry: geometry)
                
                ForEach(zonasDeArrastre.indices, id: \.self) { index in
                    let zona = zonasDeArrastre[index]
                    Rectangle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 120, height: 120)
                        .position(zona)
                        .border(Color.blue, width: 2)
                }
                
                ForEach(estado.bloques.indices, id: \.self) { index in
                    if !estado.bloques[index].estaColocado {
                        Image("pyramid")
                            .resizable()
                            .frame(width: 118, height: 118)
                            .position(estado.bloques[index].posicion)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        estado.bloques[index].posicion = value.location
                                    }
                                    .onEnded { _ in
                                        if let (zonaIndex, zonaValida) = encontrarZonaMasCercana(
                                            posicion: estado.bloques[index].posicion,
                                            zonas: zonasDeArrastre,
                                            bloquesColocados: estado.bloques.filter { $0.estaColocado }
                                        ) {
                                            withAnimation {
                                                estado.bloques[index].posicion = zonaValida
                                                estado.bloques[index].estaColocado = true
                                                estado.bloques[index].indiceZona = zonaIndex
                                                estado.puntuacion += 10
                                                estado.verificarFinConstruccion()
                                            }
                                        } else {
                                            estado.bloques[index].posicion = CGPoint(x: 300, y: 800)
                                        }
                                    }
                            )
                    } else {
                        Image("pyramid")
                            .resizable()
                            .frame(width: 118, height: 118)
                            .position(estado.bloques[index].posicion)
                    }
                }

                VStack {
                    Text("Blocks placed: \(estado.bloques.filter { $0.estaColocado }.count)/\(estado.bloques.count)")
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
    
    private func encontrarZonaMasCercana(
        posicion: CGPoint,
        zonas: [CGPoint],
        bloquesColocados: [BloquePiramide]
    ) -> (Int, CGPoint)? {
        let zonasOcupadas = Set(bloquesColocados.compactMap { $0.indiceZona })
        
        var zonasDisponibles: [(index: Int, punto: CGPoint)] = []
        var nivel = 3
        var bloquesEnNivel = 4
        var indiceInicial = 0
        
        while nivel >= 0 {
            for i in 0..<bloquesEnNivel {
                let indiceZona = indiceInicial + i
                if !zonasOcupadas.contains(indiceZona) {
                    zonasDisponibles.append((indiceZona, zonas[indiceZona]))
                }
            }
            indiceInicial += bloquesEnNivel
            bloquesEnNivel -= 1
            nivel -= 1
        }
        
        if zonasDisponibles.isEmpty {
            return nil
        }
        
        let zonasCercanas = zonasDisponibles.sorted { (zona1, zona2) -> Bool in
            let distancia1 = distanciaEntrePuntos(posicion, zona1.punto)
            let distancia2 = distanciaEntrePuntos(posicion, zona2.punto)
            return distancia1 < distancia2
        }
        
        if let zonaMasCercana = zonasCercanas.first,
           distanciaEntrePuntos(posicion, zonaMasCercana.punto) < 120 {
            return (zonaMasCercana.index, zonaMasCercana.punto)
        }
        
        return nil
    }
    
    private func distanciaEntrePuntos(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
        let dx = p1.x - p2.x
        let dy = p1.y - p2.y
        return sqrt(dx * dx + dy * dy)
    }

    private func calcularZonasDeArrastre(geometry: GeometryProxy) -> [CGPoint] {
        var zonas: [CGPoint] = []
        let tamano = 120.0
        
        let piramideWidth = CGFloat(4) * tamano + CGFloat(3) * 4
        let centerX = geometry.size.width / 2
        let startX = centerX - piramideWidth / 2 + tamano / 2
        let baseY = geometry.size.height / 2 - 100

        for fila in 0..<4 {
            let bloquesEnFila = fila + 1
            let piramideWidthFila = CGFloat(bloquesEnFila) * tamano + CGFloat(bloquesEnFila - 1)
            let startXFila = centerX - piramideWidthFila / 2 + tamano / 2

            for columna in 0..<bloquesEnFila {
                let x = startXFila + Double(columna) * (tamano)
                let y = baseY + Double(fila) * tamano
                zonas.append(CGPoint(x: x, y: y))
            }
        }
        return zonas
    }
}
