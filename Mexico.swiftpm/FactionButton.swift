import SwiftUI

struct FactionButton: View {
    let faction: Faction
    let selectFaction: () -> Void
    let isSelected: Bool
    let isLocked: Bool
    @Binding var animateIcon: Bool

    var body: some View {
        Button(action: {
            if !isLocked { selectFaction() }
        }) {
            VStack {
                ZStack {
                    Image(faction.imageName)
                        .resizable()
                        .frame(width: 130, height: 130)
                        .shadow(radius: 5)
                        .scaleEffect(isSelected && animateIcon ? 1.2 : 1)
                        .rotationEffect(isSelected && animateIcon ? .degrees(10) : .degrees(0))
                        .animation(.easeInOut(duration: 0.3), value: animateIcon)
                        .opacity(isLocked ? 0.5 : 1.0)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.yellow, lineWidth: 4)
                        )
                        .shadow(color: .black, radius: 5, x: 0, y: 5)

                    if isLocked {
                        Image(systemName: "lock.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                            .offset(x: 0, y: 0)
                    }
                }

                Text(faction.name)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(5)
                    .foregroundColor(isLocked ? .gray : .primary)
            }
        }
        .disabled(isLocked)
    }
}
