//
//  File.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct CultureIcon: View {
    let culture: Culture
    
    var body: some View {
        VStack {
            // Imagen del ícono
            Image(culture.name)
                .resizable()
                .frame(width: 150, height: 150) // Tamaño aún más grande para tablets
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.8), lineWidth: 3) // Borde más grueso
                )
            
            // Fondo detrás del texto
            Text(culture.name)
                .font(.largeTitle) // Texto mucho más grande
                .bold()
                .foregroundColor(.white) // Texto blanco para destacar
                .padding(8) // Espaciado dentro del fondo
                .background(
                    RoundedRectangle(cornerRadius: 10) // Fondo detrás del texto
                        .fill(Color.black.opacity(0.6)) // Fondo negro con transparencia
                )
                .padding(.top, 10) // Separación entre la imagen y el texto
        }
        .padding(20) // Espaciado alrededor del ícono
    }
}
