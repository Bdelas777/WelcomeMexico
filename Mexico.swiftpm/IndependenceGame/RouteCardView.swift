//
//  SwiftUIView 2.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct RouteCardView: View {
    let route: Route
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(route.name)
                .font(.title2)
                .bold()
            Text(route.description)
                .multilineTextAlignment(.center)
            Image(systemName: route.difficulty == .safe ? "shield.fill" : "exclamationmark.triangle.fill")
                .font(.largeTitle)
        }
        .padding()
        .frame(width: 200, height: 250)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(isSelected ? Color.yellow.opacity(0.3) : Color.white.opacity(0.8))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: 3)
        )
    }
}
