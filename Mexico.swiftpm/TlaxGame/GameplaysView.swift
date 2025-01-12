//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//
 import SwiftUI
struct GameplaysView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var feedbackMessage: String = ""
    @State private var showFeedback: Bool = false

    var body: some View {
        VStack {
            ProgressBar(viewModel: viewModel)
            ScoreView(viewModel: viewModel)

            ZStack {
                MapView()
                CultureIconsView(viewModel: viewModel, feedbackHandler: handleFeedback)
            }

            HStack {
                DropZone(title: "Allies")
                DropZone(title: "Non-Allies")
            }

            if showFeedback {
                FeedbackMessageView(message: feedbackMessage)
            }
        }
    }

    private func handleFeedback(message: String, success: Bool, cultureId: UUID) {
        feedbackMessage = message
        showFeedback = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showFeedback = false
        }

        if success {
            viewModel.score += 100
        } else {
            viewModel.resetCulturePosition(cultureId)
        }
    }
}
