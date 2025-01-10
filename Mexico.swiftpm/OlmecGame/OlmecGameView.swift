//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 09/01/25.
//

import SwiftUI

struct OlmecGameView: View {
    @State private var foundHeads: [UUID] = [] // IDs de cabezas encontradas
    @State private var showQuiz = false       // Muestra el cuestionario al encontrar una cabeza
    @State private var showIntro = true       // Muestra la introducción al inicio
    @State private var timeRemaining = 30    // Duración fija del juego (30 segundos)
    @State private var scrollingOffset = CGFloat(0) // Controla el desplazamiento automático
    @State private var showCelebration = false // Pantalla de felicitación al final
    @State private var currentHead: ColossalHead? // Cabeza seleccionada
    @State private var isAnswered = false     // Si la respuesta del quiz fue correcta

    let colossalHeads = ColossalHead.sampleHeads

    var body: some View {
        ZStack {
            // Fondo del paisaje selvático
            Image("jungle")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .offset(x: scrollingOffset) // Desplazamiento automático
            
            // Cabezas olmecas distribuidas
            HStack(spacing: 300) {
                ForEach(colossalHeads) { head in
                    if !foundHeads.contains(head.id) { // Muestra solo cabezas no encontradas
                        ColossalHeadView(head: head) {
                            handleHeadFound(head)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 50)
            
            // Temporizador
            VStack {
                Text("Time Left: \(timeRemaining)s")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Spacer()
            }
            
            // Introducción
            if showIntro {
                VStack {
                    Text("Welcome to the Olmec Jungle!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    
                    Text("Find the 3 colossal heads and learn fun facts!")
                        .font(.title3)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button("Start Game") {
                        withAnimation {
                            showIntro = false
                            startGame()
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .background(Color.black.opacity(0.8))
                .edgesIgnoringSafeArea(.all)
            }
            
            // Cuestionario emergente
            if showQuiz, let head = currentHead {
                QuizView(
                    question: head.question,
                    options: head.options,
                    correctAnswer: head.correctAnswer,
                    isVisible: $showQuiz,
                    isAnswered: $isAnswered
                )
            }
            
            // Celebración al final
            if showCelebration {
                VStack {
                    Text("Congratulations!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.yellow)
                        .padding()
                    
                    Text("You found \(foundHeads.count) / 3 colossal heads!")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    Button("Play Again") {
                        resetGame()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .background(Color.black.opacity(0.8))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private func handleHeadFound(_ head: ColossalHead) {
        foundHeads.append(head.id) // Marca la cabeza como encontrada
        currentHead = head         // Configura la cabeza actual para mostrar su quiz
        withAnimation {
            showQuiz = true // Muestra el cuestionario
        }
    }
    
    private func endGame() {
        withAnimation {
            showCelebration = true // Muestra la pantalla de felicitación
            
        }
    }
    
    private func resetGame() {
        foundHeads = []
        timeRemaining = 30
        scrollingOffset = 0
        showCelebration = false
        showIntro = true
    }
    private func startGame() {
        // Configuración del desplazamiento automático
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            scrollingOffset -= 2
            if scrollingOffset <= -500 { // Ajusta según el ancho del fondo
                scrollingOffset = 0
            }
        }
        
        // Configuración del temporizador del juego
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            timeRemaining -= 1
            if timeRemaining <= 0 {
                timer.invalidate() // Detiene el temporizador
                endGame()          // Termina el juego
            }
        }
    }

}
