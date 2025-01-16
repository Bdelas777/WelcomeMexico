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
            tiempoRestante = 40
            fase = .construccion
            generarBloques()
        }
    }
    
    private func materialesCorrectosSeleccionados() -> Bool {
        // Obtener los IDs de los materiales correctos
        let idsCorrectos = materiales.filter { $0.esCorrectoParaPiramide }.map { $0.id }
        print("IDs correctos: \(idsCorrectos)")

        // Filtrar los materiales seleccionados que son correctos
        let materialesCorrectosSeleccionados = materialesSeleccionados.filter { idsCorrectos.contains($0) }
        
        print("Materiales correctos seleccionados: \(materialesCorrectosSeleccionados)")
        print("Cantidad de materiales correctos seleccionados: \(materialesCorrectosSeleccionados.count)")

        // Si los 4 materiales correctos están seleccionados, pasar
        return materialesCorrectosSeleccionados.count == 4
    }
    
    // Función para agregar o quitar materiales seleccionados
    func cambiarSeleccionDeMaterial(id: UUID) {
        if materialesSeleccionados.contains(id) {
            materialesSeleccionados.remove(id) // Si ya está seleccionado, lo deselecciona
        } else {
            materialesSeleccionados.insert(id) // Si no está seleccionado, lo agrega
        }
        
        // Llamamos a la función que verifica si los materiales correctos están seleccionados
        verificarFaseConstruccion() // Ahora verificamos la fase solo aquí
    }

    private func verificarFaseConstruccion() {
        if materialesCorrectosSeleccionados() {
            iniciarFaseConstruccion() // Cambia la fase si los materiales correctos son seleccionados
        }
    }

    private func generarBloques() {
        // Generar 12 bloques con posiciones aleatorias
        bloques = (0..<10).map { _ in
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

