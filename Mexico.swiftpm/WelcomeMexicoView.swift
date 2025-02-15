//
//  SwiftUIView.swift
//  Mexico
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

struct WelcomeMexicoView: View {
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Image("pixel")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Welcome to Mexico!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(.center)
                    .padding()
                
                VStack(alignment: .center, spacing: 10) {
                    Text("""
                        I’m Bernardo, a developer and history enthusiast. Having lived across Mexico,
                        I’ve grown fascinated by its untold stories. In this journey, you’ll explore the
                        struggles and perspectives of four unique groups:
                        """)
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("""
                        - **Olmecs:** The "mother culture" of Mesoamerica, known for their colossal heads
                          and mysterious rituals.
                        - **Teotihuacans:** Builders of the grand City of the Gods, whose empire mysteriously
                          vanished into history.
                        - **Tlaxcaltecs:** Fierce warriors who allied with Hernán Cortés, risking everything
                          to overthrow the Aztecs.
                        - **Realists:** Loyalists to Spain during the War of Independence, defending their
                          beliefs against the tide of revolution.
                        """)
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Text("""
                        Choose your side, make strategic decisions, and uncover the stories that shaped
                        Mexico from the shadows. Will you rewrite history or preserve its secrets?
                        """)
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)

                
                Spacer()
                
                Button(action: onDismiss) {
                    Text("Start Your Journey")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
       
    }
}
