//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//
import SwiftUI

struct ConstruccionPiramideView: View {
    @ObservedObject var estado: EstadoJuego
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ForEach(0..<4) { fila in
                        HStack(spacing: 4) {
                            ForEach(0..<(fila + 1)) { columna in
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                            }
                        }
                    }
                }
                
                ForEach(estado.bloques.indices, id: \.self) { index in
                    if !estado.bloques[index].estaColocado {
                        Image("Piedra")
                            .resizable()
                            .frame(width: 118, height: 118)
                            .position(estado.bloques[index].posicion)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        // Actualiza la posición del bloque de forma eficiente
                                        estado.bloques[index].posicion = value.location
                                    }
                                    .onEnded { _ in
                                        // Verifica la validez de la colocación y actualiza el estado
                                        if esColocacionValida(posicion: estado.bloques[index].posicion) {
                                            withAnimation {
                                                estado.bloques[index].estaColocado = true
                                                estado.puntuacion += 10
                                                estado.verificarFinConstruccion()
                                            }
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
    
    private func esColocacionValida(posicion: CGPoint) -> Bool {
        let celdas = calcularCeldasPiramide()
        let celdasDisponibles = celdas.filter { celda in
            !estado.bloques.contains { bloque in
                bloque.estaColocado &&
                abs(bloque.posicion.x - celda.x) < 60 &&
                abs(bloque.posicion.y - celda.y) < 60
            }
        }
        
        return celdasDisponibles.contains { celda in
            abs(celda.x - posicion.x) < 60 && abs(celda.y - posicion.y) < 60
        }
    }
    
    private func calcularCeldasPiramide() -> [CGPoint] {
        var celdas: [CGPoint] = []
        let baseX = 300.0
        let baseY = 800.0
        let tamano = 120.0
        
        for fila in 0..<4 {
            for columna in 0..<(fila + 1) {
                let x = baseX + Double(columna) * tamano - Double(fila) * tamano / 2
                let y = baseY - Double(fila) * tamano
                celdas.append(CGPoint(x: x, y: y))
            }
        }
        return celdas
    }
}
