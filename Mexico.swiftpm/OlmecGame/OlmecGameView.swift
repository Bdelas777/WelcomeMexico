//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 09/01/25.
//

import SwiftUI

struct OlmecGameView: View {
    @State private var foundHeads: [UUID] = []
    @State private var showQuiz = false
    @State private var showIntro = true
    @State private var timeRemaining = 30
    @State private var showCelebration = false
    @State private var currentHead: ColossalHead?
    @State private var isAnswered = false
    @State private var gameObjects: [PositionedGameObject] = []
    @State private var answeredQuestions = 0
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    let colossalHeads = ColossalHead.sampleHeads
    let distractingObjects = DistractingObject.sampleObjects
    
    var body: some View {
        ZStack {
            Image("jungle")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            ForEach(gameObjects) { object in
                switch object.type {
                case .head(let head):
                    if !foundHeads.contains(head.id) {
                        ColossalHeadView(head: head) {
                            handleHeadFound(head)
                        }
                        .position(object.position)
                    }
                case .distraction(let distractingObject):
                    DistractingObjectView(object: distractingObject)
                        .position(object.position)
                }
            }
            
            VStack {
                Text("Tiempo restante: \(timeRemaining)s")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .padding(.top, 20)
                
                Spacer()
                
                Text("Cabezas encontradas: \(foundHeads.count)/\(colossalHeads.count)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
            }
            
            if showIntro {
                IntroView(showIntro: $showIntro, startGame: startGame)
            }
            
            if showQuiz, let head = currentHead {
                QuizView(
                    question: head.question,
                    options: head.options,
                    correctAnswer: head.correctAnswer,
                    isVisible: $showQuiz,
                    isAnswered: $isAnswered,
                    onCorrectAnswer: { handleCorrectAnswer() }
                )
            }
            
            if showCelebration {
                CelebrationView(
                    foundCount: foundHeads.count,
                    totalCount: colossalHeads.count,
                    resetGame: resetGame
                )
            }
        }
    }
    
    private func handleCorrectAnswer() {
        answeredQuestions += 1
        if answeredQuestions == 3 {
            timeRemaining = 0
            endGame()
        }
    }
    
    private func generateRandomPositions() {
        var objects: [PositionedGameObject] = []
        var usedPositions: [CGRect] = []
        
        func getRandomPosition(objectSize: CGSize) -> CGPoint {
            var position: CGPoint
            var newObjectRect: CGRect
            
            repeat {
                position = CGPoint(
                    x: CGFloat.random(in: objectSize.width...(screenWidth - objectSize.width)),
                    y: CGFloat.random(in: objectSize.height...(screenHeight - objectSize.height))
                )
                newObjectRect = CGRect(
                    x: position.x - objectSize.width/2,
                    y: position.y - objectSize.height/2,
                    width: objectSize.width,
                    height: objectSize.height
                )
            } while usedPositions.contains(where: { $0.intersects(newObjectRect) })
            
            usedPositions.append(newObjectRect)
            return position
        }
        
        // Position heads
        for head in colossalHeads {
            let position = getRandomPosition(objectSize: CGSize(width: 100, height: 120))
            objects.append(PositionedGameObject(
                position: position,
                type: .head(head)
            ))
        }
        
        // Position distracting objects
        for object in distractingObjects {
            let position = getRandomPosition(objectSize: CGSize(width: 80, height: 100))
            objects.append(PositionedGameObject(
                position: position,
                type: .distraction(object)
            ))
        }
        
        gameObjects = objects
    }
    
    private func handleHeadFound(_ head: ColossalHead) {
        foundHeads.append(head.id)
        currentHead = head
        withAnimation {
            showQuiz = true
        }
    }
    
    private func startGame() {
        generateRandomPositions()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            timeRemaining -= 1
            if timeRemaining <= 0 {
                timer.invalidate()
                endGame()
            }
        }
    }
    
    private func endGame() {
        withAnimation {
            showCelebration = true
        }
    }
    
    private func resetGame() {
        foundHeads = []
        timeRemaining = 30
        showCelebration = false
        showIntro = true
        gameObjects = []
        currentHead = nil
        isAnswered = false
        answeredQuestions = 0
    }
}

struct IntroView: View {
    @Binding var showIntro: Bool
    let startGame: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("¡Bienvenido a la Jungla Olmeca!")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
                .padding()
            
            Text("Tu viaje comienza en las exuberantes junglas de Mesoamérica. La civilización Olmeca, conocida por sus monumentales cabezas de piedra, floreció aquí. Estas esculturas colosales tienen secretos ocultos. ¿Serás tú quien los descubra?")
                .font(.title3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Comenzar Juego") {
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
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(20)
        .padding()
    }
}
