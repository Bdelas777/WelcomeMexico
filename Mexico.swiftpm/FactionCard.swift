import SwiftUI

struct FactionCard: View {
    let faction: Faction
    @Binding var isVisible: Bool
    let onPlay: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(faction.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 160)
                .padding(8)
                .background(Color.black)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.yellow, lineWidth: 6)
                )
                .shadow(color: .black, radius: 5, x: 0, y: 5)


            Text(faction.name.uppercased())
                .font(.custom("PressStart2P-Regular", size: 28))
                .foregroundColor(.yellow)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.black)
                .cornerRadius(8)
                .shadow(color: .yellow, radius: 8, x: 0, y: 0)

            // Descripción de la facción, ajustada para mayor visibilidad
            Text(faction.description)
                .font(.custom("PressStart2P-Regular", size: 16))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(nil) // Para permitir el texto en varias líneas
                .fixedSize(horizontal: false, vertical: true) // Evitar que el texto se recorte
                .padding(12)
                .background(Color.black.opacity(0.85))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 4)
                )

            // Botón de "Play" en estilo pixel art
            Button(action: {
                onPlay()
                isVisible = false
            }) {
                Text("PLAY")
                    .font(.custom("PressStart2P-Regular", size: 24))
                    .foregroundColor(.black)
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 4)
                    )
            }
            .padding(.horizontal)

            // Botón de "Close" en estilo pixel art
            Button(action: {
                withAnimation {
                    isVisible = false
                }
            }) {
                Text("CLOSE")
                    .font(.custom("PressStart2P-Regular", size: 20))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.red)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 4)
                    )
            }
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.black]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(20)
        .shadow(color: .black, radius: 15, x: 5, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.yellow, lineWidth: 6)
        )
        .padding()
    }
}
