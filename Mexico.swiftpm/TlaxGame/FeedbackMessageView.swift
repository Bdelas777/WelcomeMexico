//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import SwiftUI

struct FeedbackMessageView: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.title2)
            .foregroundColor(message == "¡Correcto!" ? .green : .red)
            .transition(.scale.combined(with: .opacity))
    }
}
