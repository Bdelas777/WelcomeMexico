//
//  File.swift
//  
//
//  Created by Alumno on 14/01/25.
//
import SwiftUI

struct DistractingObjectView: View {
    let object: DistractingObject
    @State private var isShaking = false
    @State private var showWrongEffect = false
    
    var body: some View {
        VStack {
            Image(object.imageName)
                .resizable()
                .frame(width: 160, height: 160)
                .overlay(
                    showWrongEffect ?
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 40))
                    : nil
                )
                .offset(x: isShaking ? -5 : 5)
                .animation(
                    isShaking ?
                    Animation.easeInOut(duration: 0.1)
                        .repeatCount(5)
                    : .default,
                    value: isShaking
                )
                .onTapGesture {
                    handleTap()
                }
        }
    }
    
    private func handleTap() {
        isShaking = true
        showWrongEffect = true
        
        // Reset animations after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isShaking = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showWrongEffect = false
            }
        }
    }
}
