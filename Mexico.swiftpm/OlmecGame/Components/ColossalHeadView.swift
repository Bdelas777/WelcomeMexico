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
    
    var body: some View {
        VStack {
            Image("olmec") // Usa el nombre correcto de la imagen en tus assets
                .resizable()
                .frame(width: 100, height: 100)
                .onTapGesture {
                    onFound()
                }
            
            Text(head.name)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

struct ColossalHeadView_Previews: PreviewProvider {
    static var previews: some View {
        ColossalHeadView(head: ColossalHead.sampleHeads[0]) {}
            .background(Color.black)
    }
}

