//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 09/01/25.
//

import SwiftUI

struct ColossalHeadView: View {
    let head: ColossalHead
    let onFound: () -> Void
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Image("olmec")
                .resizable()
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .onTapGesture {
                    withAnimation(.spring()) {
                        scale = 1.2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            scale = 1.0
                            onFound()
                        }
                    }
                }
            
            Text(head.name)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}
