//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.gameState {
            case .introduction:
                IntroductionView(viewModel: viewModel)
            case .playing:
                GameplaysView(viewModel: viewModel)
            case .facts:
                FactsView(viewModel: viewModel)
            case .victory:
                VictoryView(viewModel: viewModel)
            }
        }
    }
}
