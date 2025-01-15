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
        tiempoRestante = 30
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
        fase = .construccion
        tiempoRestante = 30
        generarBloques()
    }
    
    private func generarBloques() {
        bloques = (0..<12).map { _ in
            BloquePiramide(posicion: CGPoint(x: Int.random(in: 50...300), y: Int.random(in: 50...500)))
        }
    }
    
    func finalizarJuego() {
        fase = .finalizado
        timer?.invalidate()
    }
}
