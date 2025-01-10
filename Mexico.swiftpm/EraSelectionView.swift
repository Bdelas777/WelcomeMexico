//
//  SwiftUIView.swift
//  Mexico
//
//  Created by Alumno on 09/01/25.
//

import SwiftUI

struct EraSelectionView: View {
    @State private var selectedFaction: Faction? = nil // Facción seleccionada
    @State private var showModal = false              // Controla la tarjeta emergente
    @State private var animateIcon = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fondo del mapa
                Image("mexMap")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                // Íconos interactivos distribuidos horizontalmente
                HStack {
                    Spacer()
                    HStack(spacing: 50) { // Espaciado entre íconos
                        ForEach(factions) { faction in
                            FactionButton(
                                faction: faction,
                                selectFaction: selectFaction,
                                isSelected: selectedFaction?.id == faction.id,
                                animateIcon: $animateIcon
                            )
                        }
                    }
                    Spacer()
                }
                
                // Tarjeta emergente
                if let faction = selectedFaction, showModal {
                    FactionCard(faction: faction, isVisible: $showModal)
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
        }
    }
    
    private func selectFaction(faction: Faction) {
        selectedFaction = faction
        animateIcon = true // Inicia la animación del ícono
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            showModal = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animateIcon = false // Resetea la animación
        }
    }
}

struct EraSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        EraSelectionView()
            .previewInterfaceOrientation(.landscapeLeft) // Vista horizontal
    }
}
