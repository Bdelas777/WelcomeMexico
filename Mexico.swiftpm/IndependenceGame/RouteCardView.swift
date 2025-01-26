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
                .foregroundColor(isSelected ? .yellow : .primary)
                .padding(.top, 10)
            
            Text(route.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding([.top, .bottom], 8)
                .frame(maxWidth: 180) 
            
            Image(systemName: route.difficulty == .safe ? "shield.fill" : "exclamationmark.triangle.fill")
                .font(.title)
                .foregroundColor(route.difficulty == .safe ? .green : .red)
                .padding(.top, 10)
        }
        .padding()
        .frame(width: 220, height: 280)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(isSelected ? Color.yellow.opacity(0.3) : Color.white.opacity(0.9))
                .shadow(radius: 10)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: 3)
        )
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

