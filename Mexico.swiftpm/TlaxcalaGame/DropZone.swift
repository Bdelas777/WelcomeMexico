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
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .frame(width: 150, height: 100)
                .background(Color.blue.opacity(0.1))
        }
        .padding()
    }
}
