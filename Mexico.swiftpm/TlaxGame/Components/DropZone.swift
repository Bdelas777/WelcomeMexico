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
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(title == "Allies" ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                .cornerRadius(10)
        }
        .padding()
    }
}
