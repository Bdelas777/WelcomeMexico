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
        ZStack {
            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .shadow(radius: 5)
                
                ForEach(viewModel.dialogOptions) { option in
                    Button(action: {
                        viewModel.handleSelection(option)
                    }) {
                        Text(option.text)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .scaleEffect(viewModel.showDialog ? 1.05 : 1.0)
                            .animation(.spring(), value: viewModel.showDialog)
                    }
                    .padding(.horizontal)
                }
                
                ProgressBarView(value: viewModel.progressBarValue)
                    .padding()
                
                if viewModel.showDialog {
                    Text(viewModel.gameMessage)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
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
                    .foregroundColor(.gray.opacity(0.3))
                    .cornerRadius(5)
                
                Rectangle()
                    .frame(width: CGFloat(value) * geometry.size.width, height: 10)
                    .foregroundColor(.green)
                    .cornerRadius(5)
                    .shadow(radius: 5)
            }
        }
        .frame(height: 10)
    }
}
