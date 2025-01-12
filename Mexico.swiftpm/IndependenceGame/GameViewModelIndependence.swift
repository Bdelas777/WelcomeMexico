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
            // Question 1
            Question(text: "¿Cómo prefieres comenzar la negociación para la consumación de la independencia?", options: [
                DialogOption(text: "Buscar el apoyo de los insurgentes", nextQuestion: 1),
                DialogOption(text: "Negociar directamente con la Corona española", nextQuestion: 2),
                DialogOption(text: "Declarar la independencia unilateralmente", nextQuestion: 3)
            ]),

            // Question 2
            Question(text: "¿Cómo planeas obtener el apoyo de los insurgentes?", options: [
                DialogOption(text: "Prometerles poder en el nuevo gobierno", nextQuestion: 4),
                DialogOption(text: "Ofrecerles respeto a sus derechos y autonomía", nextQuestion: 5)
            ]),

            // Question 3
            Question(text: "¿Qué acción tomarías si la Corona española rechaza la negociación?", options: [
                DialogOption(text: "Buscar apoyo de otras naciones", nextQuestion: 6),
                DialogOption(text: "Intentar un acuerdo con los Estados Unidos", nextQuestion: 7)
            ]),

            // Question 4
            Question(text: "¿Cómo enfrentarás la reacción de España ante tu declaración de independencia?", options: [
                DialogOption(text: "Resistir con la fuerza militar", nextQuestion: 8),
                DialogOption(text: "Intentar negociar un tratado de paz", nextQuestion: 9)
            ]),

            // Question 5
            Question(text: "Si prometes poder en el gobierno a los insurgentes, ¿quién sería el líder de la nueva nación?", options: [
                DialogOption(text: "Yo mismo, como emperador", nextQuestion: 10),
                DialogOption(text: "Un líder insurgente reconocido", nextQuestion: 11)
            ]),

            // Question 6
            Question(text: "Si aseguras respeto a los derechos de los insurgentes, ¿cómo manejarás la distribución de tierras?", options: [
                DialogOption(text: "Distribuir tierras de manera equitativa entre todos", nextQuestion: 12),
                DialogOption(text: "Concentrar tierras en las zonas estratégicas", nextQuestion: 12)
            ]),

            // Question 7
            Question(text: "Si buscas apoyo de otras naciones, ¿a quién contactarías primero?", options: [
                DialogOption(text: "Francia", nextQuestion: 14),
                DialogOption(text: "Estados Unidos", nextQuestion: 14)
            ]),

            // Question 8
            Question(text: "Si intentas un acuerdo con los Estados Unidos, ¿qué oferta les harías?", options: [
                DialogOption(text: "Ofrecer tierras del norte", nextQuestion: 14),
                DialogOption(text: "Pedir apoyo militar a cambio de una alianza", nextQuestion: 14)
            ]),

            // Question 9
            Question(text: "Si decides resistir con la fuerza, ¿cómo organizarías la defensa?", options: [
                DialogOption(text: "Formar un ejército profesional", nextQuestion: 15),
                DialogOption(text: "Usar guerrillas locales", nextQuestion: 15)
            ]),

            // Question 10
            Question(text: "Si negocias un tratado de paz con España, ¿qué condiciones aceptarías?", options: [
                DialogOption(text: "Aceptar la independencia, pero con limitaciones comerciales", nextQuestion: 14),
                DialogOption(text: "Exigir la independencia total sin condiciones", nextQuestion: 16)
            ]),

            // Question 11
            Question(text: "Te has coronado emperador de México y has firmado los tratados de Córdoba", options: [
                DialogOption(text: "Que viva el imperio mexicano de Agustín de Iturbide", nextQuestion: -1)
            ]),

            // Question 12
            Question(text: "Al escoger un líder insurgente se ha escogido a Vicente Guerrero", options: [
                DialogOption(text: "Se ha formado la república mexicana y se han firmado los tratados de Córdoba", nextQuestion: -1)
            ]),

            // Question 13
            Question(text: "Los insurgentes se te han aliado", options: [
                DialogOption(text: "Marchas a Córdoba en búsqueda de la independencia", nextQuestion: -1)
            ]),

            // Question 14
            Question(text: "Los insurgentes se han asentado", options: [
                DialogOption(text: "Sigues siendo parte del imperio español", nextQuestion: -1)
            ]),

            // Question 15
            Question(text: "Una nación extranjera se ha unido a tu lucha", options: [
                DialogOption(text: "Formar alianzas con potencias extranjeras y la guerra se está prolongando a un conflicto de escala mayor", nextQuestion: -1)
            ]),

            // Question 16
            Question(text: "España ha traído más fuerzas y ha aplastado la rebelión", options: [
                DialogOption(text: "Sigues siendo parte del imperio español", nextQuestion: -1)
            ]),
            
            // Question 16
            Question(text: "Los insurgentes se han negado", options: [
                DialogOption(text: "El conflicto se prolomga mas", nextQuestion: -1)
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

            score += 20
            currentQuestionIndex = option.nextQuestion
            loadNextQuestion()
        } else {
            score += 10
            endGame()  // Fin del juego
        }
        showDialog = true
    }
}
