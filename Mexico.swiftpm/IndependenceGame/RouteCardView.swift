import SwiftUI

struct RouteCardView: View {
    let route: Route
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(route.name)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(isSelected ? .yellow : .primary)
                .padding(.top, 40) 
                .padding(.horizontal, 32)
            Text(route.description)
                .font(.title2)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding([.top, .bottom], 20)
                .frame(maxWidth: 400)
                .lineLimit(3)
            Image(systemName: route.difficulty == .safe ? "shield.fill" : "exclamationmark.triangle.fill")
                .font(.system(size: 100))
                .foregroundColor(route.difficulty == .safe ? .green : .red)
                .padding(.top, 32)
                .frame(height: 100)
        }
        .padding()
        .frame(width: 350, height: 450)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(isSelected ? Color.yellow.opacity(0.2) : Color.white.opacity(0.8))
                .shadow(radius: 20, x: 0, y: 10)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: 6)
        )
        .animation(.easeInOut(duration: 0.3), value: isSelected)
        .cornerRadius(30)
        .shadow(radius: 20)
        .accessibilityLabel("Route card for \(route.name)")
    }
}

