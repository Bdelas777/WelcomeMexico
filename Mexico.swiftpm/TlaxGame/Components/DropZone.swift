//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct DropZone: View {
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
               
                .cornerRadius(10)
                
        }
        .padding()
        .frame(minWidth: 500)
        .background(title == "Allies" ? Color.green.opacity(0.3) : Color.red.opacity(0.3))

    }
}
