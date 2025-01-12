//
//  File.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import Foundation
import SwiftUI

class GameViewModelIndependence: ObservableObject {
    @Published var gameState: GameState = .selecting
    @Published var timeRemaining: Int = 60
    @Published var score: Int = 0
    @Published var currentRoute: Route?
    @Published var showDialog = false
    @Published var gameMessage = ""
    @Published var currentQuestionIndex: Int = 0
    @Published var dialogOptions: [DialogOption] = []
    @Published var progressBarValue: Float = 0.0
    
    let routes = [
        Route(name: "La Alianza", description: "Ruta segura: Negocia con Vicente Guerrero", difficulty: .safe, type: .alliance),
        Route(name: "Escape Nocturno", description: "Ruta peligrosa: Esquiva patrullas realistas", difficulty: .dangerous, type: .escape),
        Route(name: "Estrategia Militar", description: "Ruta peligrosa: Usa tácticas de distracción", difficulty: .dangerous, type: .tactical)
    ]
    
    var timer: Timer?
    
    // Más preguntas agregadas
    let questions: [Question] = [
        Question(text: "¿Cómo empezarías la lucha por la independencia?", options: [
            DialogOption(text: "Iniciar con una alianza con Vicente Guerrero", nextQuestion: 1, result: "La alianza fortalece la causa, pero requiere negociación constante."),
            DialogOption(text: "Luchar sin aliados, solo con los insurgentes", nextQuestion: 2, result: "La falta de recursos y apoyo externo hace que los insurgentes tengan muchas bajas."),
            DialogOption(text: "Buscar apoyo en el extranjero, por ejemplo, en Estados Unidos", nextQuestion: 3, result: "El apoyo externo llega con algunos recursos, pero también genera desconfianza entre los locales."),
            DialogOption(text: "Apostar por la resistencia pacífica", nextQuestion: 4, result: "La resistencia pacífica crece, pero la falta de acción militar lleva a un lento avance.")
        ]),
        
        // Nueva pregunta
        Question(text: "Tus soldados tienen hambre y el suministro es limitado. ¿Qué haces?", options: [
            DialogOption(text: "Distribuir los alimentos equitativamente entre todos", nextQuestion: 5, result: "La distribución justa mantiene la moral, pero las reservas se agotan rápidamente."),
            DialogOption(text: "Dar más alimentos a los soldados más fuertes", nextQuestion: 6, result: "Esto genera resentimiento, pero los más fuertes siguen en pie para la lucha."),
            DialogOption(text: "Racionar estrictamente para que todos sobrevivan más tiempo", nextQuestion: 7, result: "La ración estricta ayuda a que todos sobrevivan más tiempo, pero afecta la moral de algunos."),
            DialogOption(text: "Enfrentar la falta de suministros con una ofensiva sorpresa", nextQuestion: 8, result: "La ofensiva tiene éxito, pero las bajas son altas y los suministros siguen siendo escasos.")
        ]),
        
        Question(text: "El ejército realista ataca. ¿Cuál es tu plan?", options: [
            DialogOption(text: "Organizar una defensa sólida en las montañas", nextQuestion: 9, result: "La defensa en las montañas es exitosa, pero las fuerzas insurgentes sufren bajas."),
            DialogOption(text: "Atacar por sorpresa al ejército realista", nextQuestion: 10, result: "La sorpresa permite una victoria, pero las bajas son grandes."),
            DialogOption(text: "Retirarse y reagruparse en un lugar más seguro", nextQuestion: 11, result: "La retirada crea confusión, pero algunos soldados prefieren huir."),
            DialogOption(text: "Pedir una tregua con los realistas", nextQuestion: 12, result: "La tregua se firma, pero muchos insurgentes no la apoyan y se sienten traicionados.")
        ]),
        
        // Nueva pregunta
        Question(text: "El clima ha empeorado y se avecina una tormenta. ¿Qué haces?", options: [
            DialogOption(text: "Esperar a que pase la tormenta y seguir adelante", nextQuestion: 13, result: "La espera es larga, pero la moral se mantiene alta al sobrevivir al mal clima."),
            DialogOption(text: "Buscar refugio y reorganizar a las tropas", nextQuestion: 14, result: "El refugio es seguro, pero algunos soldados pierden el enfoque y la estrategia se retrasa."),
            DialogOption(text: "Seguir marchando bajo la tormenta para llegar rápido a la próxima ciudad", nextQuestion: 15, result: "El avance rápido es efectivo, pero algunos soldados se enferman por la exposición."),
            DialogOption(text: "Detenerse completamente hasta que el clima mejore", nextQuestion: 16, result: "La parada crea incertidumbre, pero se evitan más bajas debido al mal tiempo.")
        ]),
        
        Question(text: "Un traidor ha infiltrado tus filas. ¿Cómo actuarías?", options: [
            DialogOption(text: "Ejecutarlo para dar ejemplo", nextQuestion: 17, result: "La ejecución fortalece el control, pero la moral del ejército se ve afectada."),
            DialogOption(text: "Tratar de convencerlo de unirse a la causa", nextQuestion: 18, result: "Algunos lo ven como una oportunidad, pero otros lo perciben como una debilidad."),
            DialogOption(text: "Destituirlo y mantenerlo prisionero", nextQuestion: 19, result: "La destitución crea desconfianza, pero la situación no empeora."),
            DialogOption(text: "Ignorarlo y continuar con la lucha", nextQuestion: 20, result: "Ignorar al traidor provoca más deserciones dentro del ejército.")
        ]),
        
        // Nueva pregunta
        Question(text: "Un aliado importante ha muerto en combate. ¿Cómo reaccionas?", options: [
            DialogOption(text: "Llamar a una pausa para honrar su memoria", nextQuestion: 21, result: "La pausa es respetuosa, pero la moral del ejército disminuye por la pérdida."),
            DialogOption(text: "No perder tiempo y continuar con la misión", nextQuestion: 22, result: "La misión continúa, pero algunos soldados sienten que no se les da espacio para el luto."),
            DialogOption(text: "Convocar a todos los líderes para tomar decisiones sobre el futuro", nextQuestion: 23, result: "La reunión crea incertidumbre, pero permite tomar decisiones estratégicas claras."),
            DialogOption(text: "Reemplazar rápidamente su puesto con un nuevo líder", nextQuestion: 24, result: "El nuevo líder tiene la fuerza para continuar, pero algunos dudan de su capacidad.")
        ]),
        
        Question(text: "Finalmente, ¿cómo evaluarías tu estrategia?", options: [
            DialogOption(text: "Logré la independencia de México, aunque con grandes sacrificios", nextQuestion: -1, result: "La independencia se logra a costa de muchas vidas, pero el país es libre."),
            DialogOption(text: "La lucha por la independencia fue fallida, pero valió la pena", nextQuestion: -1, result: "Aunque no alcanzaron la independencia, los ideales persisten y la lucha sigue viva."),
            DialogOption(text: "Mi estrategia causó más divisiones que avances", nextQuestion: -1, result: "Las divisiones internas retrasaron la independencia, pero la causa aún está viva."),
            DialogOption(text: "La paz nunca llegó, pero finalmente la independencia fue alcanzada", nextQuestion: -1, result: "La lucha no fue fácil, pero la victoria trajo consigo una independencia costosa.")
        ])
    ]
    
    func startGame(with route: Route) {
        currentRoute = route
        gameState = .playing
        currentQuestionIndex = 0
        score = 0
        timeRemaining = 60 // Reset timer for the game duration
        progressBarValue = 0.0
        startTimer()
        loadNextQuestion()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            progressBarValue = Float(timeRemaining) / 60.0
        } else {
            endGame()
        }
    }
    
    func endGame() {
        timer?.invalidate()
        gameState = .finalQuestion
    }
    
    func loadNextQuestion() {
        guard currentQuestionIndex < questions.count else {
            endGame()  // No more questions, end the game
            return
        }
        let question = questions[currentQuestionIndex]
        dialogOptions = question.options
    }
    
    func handleSelection(_ option: DialogOption) {
        // Avanzar a la siguiente pregunta según la opción seleccionada
        if option.nextQuestion >= 0 {
            gameMessage = option.result
            score += 20
            currentQuestionIndex = option.nextQuestion
            loadNextQuestion()
        } else {
            score += 10 
            gameMessage = option.result
            endGame()  // Fin del juego
        }
        
        showDialog = true
    }
}








