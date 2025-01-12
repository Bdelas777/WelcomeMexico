//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct FactsView: View {
    @ObservedObject var viewModel: GameViewModel
    
    let facts = [
        "The Tlaxcalteca alliance with Cortés was crucial in the fall of the Aztec Empire.",
        "Tlaxcala maintained significant autonomy under Spanish rule due to their alliance.",
        "The Tlaxcaltecas provided thousands of warriors to support Cortés."
    ]
    
    var body: some View {
        VStack {
            Text("Historical Facts")
                .font(.largeTitle)
                .padding()
            
            ForEach(facts, id: \.self) { fact in
                FactCard(text: fact)
                    .padding()
            }
            
            Button("Continue") {
                viewModel.showVictory()
            }
            .font(.title)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
    }
}
