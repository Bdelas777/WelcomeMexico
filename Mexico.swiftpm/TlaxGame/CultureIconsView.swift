//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct CultureIconsView: View {
    @ObservedObject var viewModel: GameViewModel
    var feedbackHandler: (String, Bool, UUID) -> Void

    var body: some View {
        ForEach(viewModel.cultures) { culture in
            CultureIcon(culture: culture)
                .position(viewModel.culturePositions[culture.id] ?? culture.position)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            viewModel.draggedCultureId = culture.id
                            viewModel.updateCulturePosition(culture.id, position: value.location)
                        }
                        .onEnded { value in
                            let dropPoint = value.location
                            let isLeftSide = dropPoint.x < UIScreen.main.bounds.width / 2
                            let zone = isLeftSide ? "Allies" : "Non-Allies"

                            if dropPoint.y > 400 {
                                if viewModel.checkPlacement(culture.id, at: dropPoint, in: zone) {
                                    withAnimation {
                                        viewModel.updateCulturePosition(
                                            culture.id,
                                            position: CGPoint(x: isLeftSide ? 100 : 300, y: 450)
                                        )
                                    }
                                    feedbackHandler("¡Correcto!", true, culture.id)
                                } else {
                                    feedbackHandler("Intenta de nuevo", false, culture.id)
                                }
                            } else {
                                viewModel.resetCulturePosition(culture.id)
                            }

                            viewModel.draggedCultureId = nil
                        }
                )
                .scaleEffect(viewModel.draggedCultureId == culture.id ? 1.2 : 1.0)
                .animation(.spring(), value: viewModel.draggedCultureId == culture.id)
        }
    }
}
