//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import SwiftUI

class EstadoJuego: ObservableObject {
    @Published var fase: FaseJuego = .inicio
    @Published var tiempoRestante: Int = 60
    @Published var puntuacion: Int = 0
    @Published var materialesSeleccionados: Set<UUID> = []
    @Published var bloques: [BloquePiramide] = []
    
    let materiales = [
        Material(nombre: "Obsidiana", descripcion: "This volcanic glass was used to make sharp tools and weapons!", esCorrectoParaPiramide: true),
        Material(nombre: "Adobe", descripcion: "Light and easy to transport, adobe was perfect for building in this vast city.", esCorrectoParaPiramide: true),
        Material(nombre: "Piedra", descripcion: "Strong volcanic stone helped the pyramid stand for centuries.", esCorrectoParaPiramide: true),
        Material(nombre: "Cal", descripcion: "Mixed with water, cal helped bind the stones together securely.", esCorrectoParaPiramide: true),
        Material(nombre: "Madera", descripcion: "Not used in pyramid construction.", esCorrectoParaPiramide: false),
        Material(nombre: "Arena", descripcion: "Not suitable for pyramid building.", esCorrectoParaPiramide: false)
    ]
    
    var timer: Timer?
    
    func iniciarJuego() {
        fase = .seleccionMateriales
        tiempoRestante = 20
        iniciarTimer()
    }
    
    private func iniciarTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.actualizarTiempo()
        }
    }
    
    private func actualizarTiempo() {
        if tiempoRestante > 0 {
            tiempoRestante -= 1
        } else {
            if fase == .seleccionMateriales {
                iniciarFaseConstruccion()
            } else {
                finalizarJuego()
            }
        }
    }
    
    func iniciarFaseConstruccion() {
        // Lógica ajustada para verificar materiales correctos
        if materialesCorrectosSeleccionados() {
            tiempoRestante = 0
            fase = .construccion
            generarBloques()
        } else {
            // Si los materiales no son correctos, continuar con tiempo adicional
            fase = .construccion
            tiempoRestante = 40
            generarBloques()
        }
    }
    
    private func materialesCorrectosSeleccionados() -> Bool {
        // Obtener los materiales correctos
        let materialesCorrectos = materiales.filter { $0.esCorrectoParaPiramide }
        
        // Verificar que los seleccionados coincidan exactamente con los correctos
        return materialesSeleccionados.count == materialesCorrectos.count &&
               materialesCorrectos.allSatisfy { material in
                   materialesSeleccionados.contains(material.id)
               }
    }
    
    private func generarBloques() {
        // Generar 12 bloques con posiciones aleatorias
        bloques = (0..<12).map { _ in
            BloquePiramide(posicion: CGPoint(x: Int.random(in: 100...600), y: Int.random(in: 100...700)))
        }
    }
    
    func verificarFinConstruccion() {
        // Verificar si todos los bloques están colocados
        if bloques.allSatisfy({ $0.estaColocado }) {
            tiempoRestante = 0
        }
    }
    
    func finalizarJuego() {
        // Finalizar el juego y detener el temporizador
        fase = .finalizado
        timer?.invalidate()
    }
}
