
import SwiftUI

class EstadoJuego: ObservableObject {
    @Published var fase: FaseJuego = .inicio
    @Published var tiempoRestante: Int = 60
    @Published var puntuacion: Int = 0
    @Published var materialesSeleccionados: Set<UUID> = []
    @Published var bloques: [BloquePiramide] = []
    
    let materiales = [
        Material(nombre: "Obsidian", descripcion: "This volcanic glass was used to make sharp tools and weapons!", esCorrectoParaPiramide: true),
        Material(nombre: "Adobe", descripcion: "Light and easy to transport, adobe was perfect for building in this vast city.", esCorrectoParaPiramide: true),
        Material(nombre: "VolcanicStone", descripcion: "Strong volcanic stone helped the pyramid stand for centuries.", esCorrectoParaPiramide: true),
        Material(nombre: "Lime", descripcion: "Mixed with water, cal helped bind the stones together securely.", esCorrectoParaPiramide: true),
        Material(nombre: "Wood", descripcion: "Not used in pyramid construction.", esCorrectoParaPiramide: false),
        Material(nombre: "Sand", descripcion: "Not suitable for pyramid building.", esCorrectoParaPiramide: false)
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
            if fase == .seleccionMateriales   && tiempoRestante == 0{
                tiempoRestante = 40
                fase = .construccion
                generarBloques()
            }
        } else {
            if fase == .seleccionMateriales  {
                iniciarFaseConstruccion()
            }
            else {
                finalizarJuego()
            }
        }
    }
    
    func iniciarFaseConstruccion() {
        if materialesCorrectosSeleccionados() {
            tiempoRestante = 40
            fase = .construccion
            generarBloques()
        }
    }
    
    private func materialesCorrectosSeleccionados() -> Bool {
        let idsCorrectos = materiales.filter { $0.esCorrectoParaPiramide }.map { $0.id }
        let materialesCorrectosSeleccionados = materialesSeleccionados.filter { idsCorrectos.contains($0) }
        return materialesCorrectosSeleccionados.count == 4
    }
    
    func cambiarSeleccionDeMaterial(id: UUID) {
        if materialesSeleccionados.contains(id) {
            materialesSeleccionados.remove(id)
        } else {
            materialesSeleccionados.insert(id)
        }
        verificarFaseConstruccion()
    }

    private func verificarFaseConstruccion() {
        if materialesCorrectosSeleccionados()   {
            iniciarFaseConstruccion()
        }
    }

    private func generarBloques() {
        bloques = (0..<10).map { _ in
            BloquePiramide(posicion: CGPoint(x: Int.random(in: 50...300), y: Int.random(in: 50...500)))
        }
    }
    
    func verificarFinConstruccion() {
        let todosColocados = bloques.allSatisfy { $0.estaColocado }
        if todosColocados {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.finalizarJuego()
            }
        }
    }
    
    func finalizarJuego() {
        fase = .finalizado
        timer?.invalidate()
    }
}


