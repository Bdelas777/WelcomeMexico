//
//  File.swift
//  
//
//  Created by Alumno on 14/01/25.
//

import SwiftUI

struct CelebrationView: View {
    let foundCount: Int
    let totalCount: Int
    let resetGame: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("¡Felicitaciones!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.yellow)
            
            Text("Encontraste \(foundCount) de \(totalCount) cabezas colosales!")
                .font(.title3)
                .foregroundColor(.white)
            
            Button("Jugar de nuevo") {
                resetGame()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(20)
        .padding()
    }
}
