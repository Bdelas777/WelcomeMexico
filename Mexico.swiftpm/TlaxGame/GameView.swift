//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var audioPlayer: AVAudioPlayer?
    
    private func playBackgroundMusic() {
        if let url = Bundle.main.url(forResource: "tlax", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("Error al reproducir la música: \(error.localizedDescription)")
            }
        } else {
            print("No se encontró el archivo de audio en Resources")
        }
    }
    
    var body: some View {
        ZStack {
            switch viewModel.gameState {
            case .introduction:
                IntroductionView(viewModel: viewModel)
            case .playing:
                GameplayView(viewModel: viewModel)
            case .facts:
                FactsView(viewModel: viewModel)
             case .victory:
                VictoryView(viewModel: viewModel)
            }
        }.onAppear {
            playBackgroundMusic()
        }
        .onDisappear {
                audioPlayer?.stop()
            }
    }
}
