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
            Color.black.opacity(0.7).edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                
                Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .shadow(radius: 10)
                
                ForEach(viewModel.dialogOptions) { option in
                    Button(action: {
                        viewModel.handleSelection(option)
                    }) {
                        Text(option.text)
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .scaleEffect(viewModel.showDialog ? 1.05 : 1.0)
                            .animation(.spring(), value: viewModel.showDialog)
                    }
                    .padding(.horizontal, 40)
                }
                
                ProgressBarView(value: viewModel.progressBarValue)
                    .padding(.horizontal, 40)
                
                if viewModel.showDialog {
                    Text(viewModel.gameMessage)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(15)
                        .shadow(radius: 10)
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
                    .frame(width: geometry.size.width, height: 12)
                    .foregroundColor(.gray.opacity(0.5))
                    .cornerRadius(6)

                Rectangle()
                    .frame(width: CGFloat(value) * geometry.size.width, height: 12)
                    .foregroundColor(.green)
                    .cornerRadius(6)
                    .shadow(radius: 10)
            }
        }
        .frame(height: 12)
    }
}
