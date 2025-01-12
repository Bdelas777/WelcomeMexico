//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct ProgressBar: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            ProgressView(value: viewModel.timeRemaining, total: viewModel.gameDuration)
                .padding()

            Text(String(format: "Time: %.1f", viewModel.timeRemaining))
                .font(.headline)
                .padding(.bottom)
        }
    }
}
