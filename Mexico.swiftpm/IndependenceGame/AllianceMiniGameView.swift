//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct AllianceMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    
    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            ForEach(viewModel.dialogOptions) { option in
                Button(action: {
                    viewModel.handleSelection(option)
                }) {
                    Text(option.text)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            ProgressBarView(value: viewModel.progressBarValue)
                .padding()
            
            if viewModel.showDialog {
                Text(viewModel.gameMessage)
                    .font(.body)
                    .padding()
            }
        }
        .padding()
        .onAppear {
            if let route = viewModel.routes.first {
                viewModel.startGame(with: route)
            }
        }
    }
}

struct ProgressBarView: View {
    var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 10)
                    .foregroundColor(.gray.opacity(0.2))
                
                Rectangle()
                    .frame(width: CGFloat(value) * geometry.size.width, height: 10)
                    .foregroundColor(.green)
            }
            .cornerRadius(5)
        }
        .frame(height: 10)
    }
}
