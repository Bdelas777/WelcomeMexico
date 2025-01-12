//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct FactsView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text("Did You Know?")
                .font(.largeTitle)
                .padding()
            
            VStack(spacing: 20) {
                FactCard(text: "The Tlaxcaltecas wanted freedom from the Aztecs, so they allied with Cortés!")
                FactCard(text: "Without the Tlaxcaltecas' 50,000 warriors, Cortés wouldn't have won!")
                FactCard(text: "The Totonacas supported the Spanish later, but they weren't key allies at first!")
            }
            .padding()
            
            Button("Continue") {
                withAnimation {
                    viewModel.showVictory()
                }
            }
            .padding()
        }
    }
}
