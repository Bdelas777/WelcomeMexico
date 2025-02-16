import SwiftUI

struct CompletionModalView: View {
    @Binding var isPresented: Bool
    @Binding var showAchievements: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.6)))
                    }
                    .padding(8)
                }
                
                Text("🎉 Congratulations! 🎉")
                    .font(.custom("PressStart2P-Regular", size: 22))
                    .foregroundColor(.yellow)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.black.opacity(0.85))
                    .cornerRadius(10)
                
                Text("You have unlocked all the achievements!")
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black.opacity(0.85))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                
                HStack(spacing: 20) {
                    Button(action: {
                        showAchievements = true
                        isPresented = false
                    }) {
                        Text("View Achievements")
                            .font(.custom("PressStart2P-Regular", size: 16))
                            .foregroundColor(.black)
                            .padding()
                            .frame(minWidth: 140)
                            .background(Color.yellow)
                            .cornerRadius(10)
                            .shadow(color: .yellow.opacity(0.7), radius: 5, x: 0, y: 3)
                    }
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Close")
                            .font(.custom("PressStart2P-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .frame(minWidth: 120)
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 3)
                    }
                }
            }
            .padding(30)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.95), Color.black]),
                              startPoint: .top,
                              endPoint: .bottom)
            )
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.yellow, lineWidth: 4)
            )
            .shadow(color: .black.opacity(0.8), radius: 20, x: 0, y: 8)
        }
    }
}
