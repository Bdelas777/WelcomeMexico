import SwiftUI

struct FactionCard: View {
    let faction: Faction
    @Binding var isVisible: Bool
    let onPlay: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        isVisible = false
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                        .background(Circle().fill(Color.black.opacity(0.7)))
                }
                .padding(2)
                .padding(.bottom, 20)
            }

            Image(faction.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 140)
                .padding(8)
                .background(Color.black.opacity(0.8))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.yellow, lineWidth: 4)
                )
                .shadow(color: .black, radius: 5, x: 0, y: 5)

            Text(faction.name.uppercased())
                .font(.custom("PressStart2P-Regular", size: 22))
                .foregroundColor(.yellow)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.8))
                .cornerRadius(8)

            // Envuelve la descripción en un ScrollView para evitar recortes
            ScrollView {
                Text(faction.description)
                    .font(.system(size: 20, weight: .medium, design: .monospaced))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black.opacity(0.85))
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: 150)
            Button(action: {
                onPlay()
                isVisible = false
            }) {
                Text("PLAY")
                    .font(.custom("PressStart2P-Regular", size: 20))
                    .foregroundColor(.white)
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Permite que el VStack crezca
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.9), Color.black]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(20)
        .shadow(color: .black, radius: 15, x: 5, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.yellow, lineWidth: 4)
        )
        .padding()
    }
}
