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
                Text(material.nombre)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(estaSeleccionado ? Color.green.opacity(0.3) : Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(estaSeleccionado ? Color.green : Color.gray, lineWidth: 2)
            )
        }
    }
}
