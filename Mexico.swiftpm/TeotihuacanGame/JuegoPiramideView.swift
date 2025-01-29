//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import SwiftUI
import AVFoundation

struct JuegoPiramideView: View {
    @StateObject private var estado = EstadoJuego()
    @State private var audioPlayer: AVAudioPlayer?
    
    private func playBackgroundMusic() {
        if let url = Bundle.main.url(forResource: "teo", withExtension: "mp3") {
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
            Image("teotihua")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Time: \(estado.tiempoRestante)s")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 40)
                    Spacer()
                    Text("Points: \(estado.puntuacion)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.trailing, 40)
                }
                .padding(.top, 20)

                Spacer()

                switch estado.fase {
                case .inicio:
                    PantallaInicioView(estado: estado)
                case .seleccionMateriales:
                    SeleccionMaterialesView(estado: estado)
                case .construccion:
                    ConstruccionPiramideView(estado: estado)
                case .finalizado:
                    PantallaFinalView(estado: estado)
                   
                }
                
                Spacer()
            }
            .padding()
        }.onAppear {
            playBackgroundMusic()
        }
        .onDisappear {
                audioPlayer?.stop()
            }
    }
}
