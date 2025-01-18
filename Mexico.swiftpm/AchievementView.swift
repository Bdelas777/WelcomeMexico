//
//  SwiftUIView.swift
//  Mexico
//
//  Created by Alumno on 17/01/25.
//
import SwiftUI

struct AchievementView: View {
    let completedGames: Set<UUID>
    let factions: [Faction]
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("🎮 Logros Épicos 🎖️")
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

                                // Mensaje de logro dependiendo de si está completado o no
                                if completedGames.contains(faction.id) {
                                    switch faction.name {
                                    case "Olmecs":
                                        Text("🪙 ¡Los Olmecas te han coronado!")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    case "Teotihuacán":
                                        Text("⛩️ ¡Has alcanzado la cima de la pirámide de Teotihuacán!")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    case "Tlaxcaltecas":
                                        Text("⚔️ ¡La fuerza Tlaxcalteca ha sido conquistada!")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    case "Realistas":
                                        Text("⚔️ ¡La Corona te aplaude por tu conquista!")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    default:
                                        Text("🎉 ¡Conquistaste todo!")
                                    }
                                } else {
                                    switch faction.name {
                                    case "Olmecs":
                                        Text("🚫 Necesitas tallar más cabezas gigantes para desbloquearlo.")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    case "Teotihuacán":
                                        Text("🚫 Aún te falta escalar un par de pirámides.")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    case "Tlaxcaltecas":
                                        Text("🚫 Todavía no eres un guerrero legendario.")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    case "Realistas":
                                        Text("🚫 Necesitas más batallas para reclamar el oro.")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    default:
                                        Text("🔒 ¡Desbloquea el logro!")
                                    }
                                }
                            }

                            Spacer()

                            // Indicador de estado del logro
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
                    Text("Cerrar")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }
}
