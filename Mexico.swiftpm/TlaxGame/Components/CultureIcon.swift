

import SwiftUI

struct CultureIcon: View {
    let culture: Culture
    
    var body: some View {
        VStack {
            Image(culture.name)
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.8), lineWidth: 3)
                )
            
            Text(culture.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.6))
                )
                .padding(.top, 10)
        }
        .padding(20) 
    }
}
