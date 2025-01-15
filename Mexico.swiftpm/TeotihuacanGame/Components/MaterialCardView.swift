//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import SwiftUI

struct MaterialCardView: View {
    let material: Material
    let estaSeleccionado: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack {
   
                Image(material.nombre) // Usa el nombre como el nombre de la imagen en assets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 320)
                    .cornerRadius(8)
                
       
                Text(material.nombre)
                    .font(.title)
                    .padding(.top, 5)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                estaSeleccionado ?
                (material.esCorrectoParaPiramide ? Color.green.opacity(0.5) : Color.red.opacity(0.5)) :
                Color.white
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        estaSeleccionado ?
                        (material.esCorrectoParaPiramide ? Color.green : Color.red) :
                        Color.gray,
                        lineWidth: 2
                    )
            )
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3)
        }
    }
}
