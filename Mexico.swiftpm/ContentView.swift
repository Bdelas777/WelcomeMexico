import SwiftUI
import AVFoundation

class AudioManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        setupAudio()
    }
    
    private func setupAudio() {
        if let url = Bundle.main.url(forResource: "flamenco", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error al configurar el audio: \(error.localizedDescription)")
            }
        }
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func stop() {
        audioPlayer?.stop()
    }
}

struct ContentView: View {
    @State private var showMyPresentation = true
    @StateObject private var audioManager = AudioManager()
    
    var body: some View {
        if showMyPresentation {
            WelcomeMexicoView(onDismiss: {
                withAnimation {
                    showMyPresentation = false
                }
            })
            .onAppear {
                audioManager.play()
            }
        } else {
            EraSelectionView(audioManager: audioManager)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
