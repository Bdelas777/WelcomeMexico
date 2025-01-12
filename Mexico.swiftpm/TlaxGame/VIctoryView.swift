//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct VictoryView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text("Victory!")
                .font(.largeTitle)
                .padding()
            
            Text("Thanks to your alliance, the Aztec Empire falls, and the Tlaxcaltecas secure their future!")
                .multilineTextAlignment(.center)
                .padding()
            
            // Efectos de celebración
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
        }
    }
}
