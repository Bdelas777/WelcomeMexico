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
        Route(name: "The Alliance", description: "Safe route: Negotiate with Vicente Guerrero", difficulty: .safe, type: .alliance),
        Route(name: "Night Escape", description: "Dangerous route: Avoid royalist patrols", difficulty: .dangerous, type: .escape),
        Route(name: "Military Strategy", description: "Dangerous route: Use war tactics", difficulty: .dangerous, type: .tactical)
    ]
    
    var timer: Timer?
    
        let questions: [Question] = [
            // Question 1
            Question(text: "How would you prefer to begin negotiations to achieve independence?", options: [
                    DialogOption(text: "Seek support from the insurgents", nextQuestion: 1),
                    DialogOption(text: "Negotiate directly with the Spanish Crown", nextQuestion: 2),
                    DialogOption(text: "Declare independence unilaterally", nextQuestion: 3)
                ]),

            // Question 2
            Question(text: "How do you plan to gain the insurgents' support?", options: [
                    DialogOption(text: "Promise them power in the new government", nextQuestion: 4),
                    DialogOption(text: "Offer them respect for their rights and autonomy", nextQuestion: 5)
                ]),

            // Question 3
            Question(text: "What action would you take if the Spanish Crown rejects the negotiation?", options: [
                    DialogOption(text: "Seek support from other nations", nextQuestion: 6),
                    DialogOption(text: "Attempt an agreement with the United States", nextQuestion: 7)
                ]),

            // Question 4
            Question(text: "How will you respond to Spain's reaction to your declaration of independence?", options: [
                   DialogOption(text: "Resist with military force", nextQuestion: 8),
                   DialogOption(text: "Attempt to negotiate a peace treaty", nextQuestion: 9)
               ]),

            // Question 5
            Question(text: "If you promise power in the government to the insurgents, who would lead the new nation?", options: [
                    DialogOption(text: "I will, as emperor", nextQuestion: 10),
                    DialogOption(text: "A recognized insurgent leader", nextQuestion: 11)
                ]),

            // Question 6
            Question(text: "If you promise respect for the insurgents' rights, how will you handle land distribution?", options: [
                   DialogOption(text: "Distribute land equitably among everyone", nextQuestion: 12),
                   DialogOption(text: "Concentrate land in strategic areas", nextQuestion: 12)
               ]),

            // Question 7
            Question(text: "If you seek support from other nations, who would you contact first?", options: [
                    DialogOption(text: "France", nextQuestion: 14),
                    DialogOption(text: "The United States", nextQuestion: 14)
                ]),


            // Question 8
            Question(text: "If you try to make a deal with the United States, what would you offer them?", options: [
                    DialogOption(text: "Offer land in the north", nextQuestion: 14),
                    DialogOption(text: "Request military support in exchange for an alliance", nextQuestion: 14)
                ]),
            
            // Question 9
            Question(text: "If you decide to resist with force, how would you organize the defense?", options: [
                    DialogOption(text: "Form a professional army", nextQuestion: 15),
                    DialogOption(text: "Use local guerrillas", nextQuestion: 15)
                ]),

            // Question 10
            Question(text: "If you negotiate a peace treaty with Spain, what conditions would you accept?", options: [
                   DialogOption(text: "Accept independence but with trade restrictions", nextQuestion: 14),
                   DialogOption(text: "Demand total independence without conditions", nextQuestion: 16)
               ]),
            
            // Question 11
            Question(text: "You have crowned yourself Emperor of Mexico and signed the Treaty of Córdoba", options: [
                    DialogOption(text: "Long live the Mexican Empire under Agustín de Iturbide", nextQuestion: -1)
                ]),


            // Question 12
            Question(text: "A recognized insurgent leader, Vicente Guerrero, has been chosen", options: [
                    DialogOption(text: "The Mexican Republic has been formed, and the Treaty of Córdoba has been signed", nextQuestion: -1)
                ]),

            // Question 13
            Question(text: "The insurgents have allied with you", options: [
                    DialogOption(text: "You march to Córdoba in pursuit of independence", nextQuestion: -1)
                ]),

            // Question 14
            Question(text: "The insurgents have settled down", options: [
                    DialogOption(text: "You remain part of the Spanish Empire", nextQuestion: -1)
                ]),

            // Question 15
            Question(text: "A foreign nation has joined your fight", options: [
                    DialogOption(text: "Form alliances with foreign powers as the war escalates into a larger conflict", nextQuestion: -1)
                ]),


            // Question 16
            Question(text: "Spain has brought reinforcements and crushed the rebellion", options: [
                    DialogOption(text: "You remain part of the Spanish Empire", nextQuestion: -1)
                ]),
            
            // Question 16
            Question(text: "The insurgents have refused", options: [
                    DialogOption(text: "The conflict prolongs further", nextQuestion: -1)
                ])
        ]
    
    func startGame(with route: Route) {
        currentRoute = route
        gameState = .playing
        currentQuestionIndex = 0
        score = 0
        timeRemaining = 60
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
            endGame()
            return
        }
        let question = questions[currentQuestionIndex]
        dialogOptions = question.options
    }
    
    func handleSelection(_ option: DialogOption) {
        if option.nextQuestion >= 0 {
            score += 20
            currentQuestionIndex = option.nextQuestion
            loadNextQuestion()
        } else {
            score += 10
            endGame()  
        }
        showDialog = true
    }
}
