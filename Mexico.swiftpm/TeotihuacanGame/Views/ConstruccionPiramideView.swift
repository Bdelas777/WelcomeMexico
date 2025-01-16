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
                                    .frame(width: 80, height: 80) // Tamaño ajustado para tablets
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
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: 78, height: 78)
                            .position(estado.bloques[index].posicion)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        withAnimation {
                                            estado.bloques[index].posicion = value.location
                                        }
                                    }
                                    .onEnded { _ in
                                        if esColocacionValida(posicion: estado.bloques[index].posicion) {
                                            estado.bloques[index].estaColocado = true
                                            estado.puntuacion += 10
                                            estado.verificarFinConstruccion()
                                        }
                                    }
                            )
                    }
                }
            }
        }
    }
    
    private func esColocacionValida(posicion: CGPoint) -> Bool {
        let celdas = calcularCeldasPiramide()
        return celdas.contains { celda in
            abs(celda.x - posicion.x) < 40 && abs(celda.y - posicion.y) < 40
        }
    }
    
    private func calcularCeldasPiramide() -> [CGPoint] {
        var celdas: [CGPoint] = []
        let baseX = 300.0
        let baseY = 800.0
        let tamano = 80.0
        
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
