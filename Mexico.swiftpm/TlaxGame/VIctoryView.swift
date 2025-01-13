//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct VictoryView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss // Utilizamos dismiss para cerrar la vista actual
    
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
            
            // Botón para regresar a EraSelectionView
            Button(action: {
                dismiss() // Cierra la vista actual (VictoryView)
            }) {
                Text("Return to Era Selection")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso de la barra de navegación si es necesario
        .padding()
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView(viewModel: GameViewModel())
    }
}

