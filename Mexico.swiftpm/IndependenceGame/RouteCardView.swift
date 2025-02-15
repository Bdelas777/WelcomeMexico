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
                .padding(.top, 40)  // Aumentar el padding superior
                .padding(.horizontal, 32)  // Aumentar el espaciado horizontal
            
            Text(route.description)
                .font(.title2)  // Aumentar el tamaño de la fuente para la descripción
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding([.top, .bottom], 20)  // Aumentar el padding superior e inferior
                .frame(maxWidth: 400)  // Aumentar el ancho máximo de la descripción
                .lineLimit(3)  // Mantener el límite de líneas

            Image(systemName: route.difficulty == .safe ? "shield.fill" : "exclamationmark.triangle.fill")
                .font(.system(size: 100))  // Aumentar el tamaño del icono
                .foregroundColor(route.difficulty == .safe ? .green : .red)
                .padding(.top, 32)  // Aumentar el padding superior
                .frame(height: 100)  // Ajustar el tamaño del icono
        }
        .padding()
        .frame(width: 350, height: 450)  // Duplicar el tamaño de la tarjeta
        .background(
            RoundedRectangle(cornerRadius: 30)  // Borde más redondeado
                .fill(isSelected ? Color.yellow.opacity(0.2) : Color.white.opacity(0.8))
                .shadow(radius: 20, x: 0, y: 10)  // Sombra más pronunciada
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: 6)  // Borde más grueso cuando está seleccionado
        )
        .animation(.easeInOut(duration: 0.3), value: isSelected)  // Animación suave para la selección
        .cornerRadius(30)  // Borde redondeado
        .shadow(radius: 20)  // Sombras más sutiles
        .accessibilityLabel("Route card for \(route.name)")  // Mejor accesibilidad con nombre
    }
}

