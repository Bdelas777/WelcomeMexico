//
//  File.swift
//  
//
//  Created by Alumno on 29/01/25.
//

import SwiftUI
import AVFoundation

class BackgroundMusicManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    
    func playMusic(named fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
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
    
    func stopMusic() {
        audioPlayer?.stop()
    }
}
