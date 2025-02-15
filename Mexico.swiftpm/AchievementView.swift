import SwiftUI

struct AchievementView: View {
    let completedGames: Set<UUID>
    let factions: [Faction]
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("🎮 Epic Achievements 🎖️")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                ScrollView {
                    ForEach(factions) { faction in
                        HStack {
                            Image(faction.imageName)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .shadow(radius: 4)

                            VStack(alignment: .leading, spacing: 6) {
                                Text(faction.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                if completedGames.contains(faction.id) {
                                    switch faction.name {
                                    case "Olmecas":
                                        Text("🪙 The Olmecs have crowned you!")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    case "Teotihuacán":
                                        Text("⛩️ You've reached the top of the Teotihuacán pyramid!")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    case "Tlaxcaltecas":
                                        Text("⚔️ The Tlaxcaltec force has been conquered!")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    case "Realistas":
                                        Text("⚔️ The Crown applauds your conquest!")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    default:
                                        Text("🎉 You conquered everything!")
                                    }
                                } else {
                                    switch faction.name {
                                    case "Olmecas":
                                        Text("🚫 You need to carve more giant heads to unlock it.")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    case "Teotihuacán":
                                        Text("🚫 You still need to climb a couple of pyramids.")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    case "Tlaxcaltecas":
                                        Text("🚫 You are not a legendary warrior yet.")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    case "Realistas":
                                        Text("🚫 You need more battles to claim the gold.")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    default:
                                        Text("🔒 Unlock the achievement!")
                                    }
                                }
                            }

                            Spacer()

                            Text(completedGames.contains(faction.id) ? "✅" : "🔒")
                                .font(.title)
                                .padding(10)
                                .background(completedGames.contains(faction.id) ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                                .clipShape(Circle())
                        }
                        .padding()
                        .background(
                            completedGames.contains(faction.id) ? Color.green.opacity(0.1) : Color.red.opacity(0.1)
                        )
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                }

                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.vertical, 12) 
                }

            }
            .padding(.top)
        }
    }
}
