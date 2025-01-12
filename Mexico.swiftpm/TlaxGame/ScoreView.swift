//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        Text("Score: \(viewModel.score)")
            .font(.headline)
            .padding()
    }
}
