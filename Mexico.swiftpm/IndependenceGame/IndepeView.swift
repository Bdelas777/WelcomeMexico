import SwiftUI

struct IndepeView: View {
    @State private var showMainGame = false
    @State private var animateText = false
    @StateObject private var musicManager = BackgroundMusicManager()
    
    var body: some View {
        ZStack {
            Image("Indepe")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 10)
            
            VStack(spacing: 25) {
                Text("Welcome to Córdoba!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("""
                Step into the boots of Agustín de Iturbide, leading the Realists during the Mexican War of Independence.
                
                Choose one of three exciting mini-games to strategize, negotiate, or outsmart the insurgents!
                
                Face a final challenge to test your leadership skills and secure your place in history.
                """)
                    .font(.title)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(maxWidth: 1000)

                Button(action: {
                    withAnimation {
                        showMainGame = true
                    }
                }) {
                    Text("Begin the Campaign")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                         startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
            }
            .padding()
            .background(Color.black.opacity(0.85))
            .cornerRadius(20)
            .padding()
            .onAppear {
                animateText = true
                musicManager.playMusic(named: "indepe")
            }
            .onDisappear {
                musicManager.stopMusic()
            }
            
            if showMainGame {
                LibertadEnMarchaGame(musicManager: musicManager)
            }
        }
    }
}
