//
//  SwiftUIView.swift
//  Mexico
//
//  Created by Alumno on 09/01/25.
//


import SwiftUI

struct EraSelectionView: View {
    @State private var selectedFaction: Faction? = nil
    @State private var showModal = false
    @State private var showGameView = false
    @State private var showAchievements = false // Controla la pantalla de logros
    @State private var completedGames: Set<UUID> = [] // Juegos completados
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("mexMap")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        Spacer()

                        HStack(spacing: 50) {
                            ForEach(factions) { faction in
                                FactionButton(
                                    faction: faction,
                                    selectFaction: {
                                        if completedGames.contains(faction.id) || canPlay(faction) {
                                            selectFaction(faction: faction)
                                        }
                                    },
                                    isSelected: selectedFaction?.id == faction.id,
                                    isLocked: !canPlay(faction) && !completedGames.contains(faction.id),
                                    animateIcon: $showModal
                                )
                            }
                        }

                        Spacer()

                        Button("Ver Logros") {
                            showAchievements = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }

                    // Tarjeta emergente
                    if let faction = selectedFaction, showModal {
                        FactionCard(faction: faction, isVisible: $showModal, onPlay: {
                            showGameView = true
                        })
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.5)
                            .transition(
                                .asymmetric(
                                    insertion: .opacity.combined(with: .scale(scale: 0.8, anchor: .center)),
                                    removal: .opacity.combined(with: .move(edge: .bottom))
                                )
                            )
                            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: showModal)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented: $showGameView) {
                if let destination = selectedFaction?.destination {
                    destination
                        .onDisappear {
                            if let faction = selectedFaction {
                                completedGames.insert(faction.id)
                            }
                        }
                }
            }
            .sheet(isPresented: $showAchievements) {
                AchievementView(completedGames: completedGames, factions: factions)
            }
        }
    }

    private func canPlay(_ faction: Faction) -> Bool {
        // Habilita el juego si es el primero o el anterior está completado
        if let index = factions.firstIndex(where: { $0.id == faction.id }) {
            if index == 0 { return true }
            let previousFaction = factions[index - 1]
            return completedGames.contains(previousFaction.id)
        }
        return false
    }

    private func selectFaction(faction: Faction) {
        selectedFaction = faction
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            showModal = true
        }
    }
}
