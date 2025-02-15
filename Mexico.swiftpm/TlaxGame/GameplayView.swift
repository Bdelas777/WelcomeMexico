import SwiftUI

struct GameplayView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Image("mesoamerica_map")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 5)
            
            VStack {
                ProgressView(value: viewModel.timeRemaining, total: viewModel.gameDuration)
                    .padding()
                
                Text("Time: \(Int(viewModel.timeRemaining)) seconds")  // Mostrar tiempo como int
                    .font(.title)
                    .padding(.bottom)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                
                Text("Score: \(viewModel.score)")
                    .font(.title)
                    .bold()
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                
                ZStack {
                    ForEach(viewModel.cultures) { culture in
                        CultureIcon(culture: culture)
                            .position(viewModel.culturePositions[culture.id] ?? culture.position)
                            .shadow(radius: 5) // Mantener la sombra
                            .padding(4)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        viewModel.draggedCulture = culture
                                        // Limitar el movimiento a la parte superior 3/4 de la pantalla
                                        let screenHeight = UIScreen.main.bounds.height
                                        let yPosition = min(value.location.y, screenHeight * 0.75)  // Limitar la posición Y
                                        viewModel.updateCulturePosition(culture.id, position: CGPoint(x: value.location.x, y: yPosition))
                                    }
                                    .onEnded { value in
                                        let dropPoint = value.location
                                        let screenHeight = UIScreen.main.bounds.height
                                        let screenWidth = UIScreen.main.bounds.width
                                        
                                        if dropPoint.y > screenHeight * 0.6 {
                                            let isLeftZone = dropPoint.x < screenWidth / 2
                                            let zoneName = isLeftZone ? "Allies" : "Non-Allies"
                                            
                                            // Verificar si la colocación es correcta
                                            if viewModel.checkPlacement(cultureID: culture.id, location: dropPoint, zoneName: zoneName) {
                                                viewModel.score += 100
                                                if viewModel.score >= 400 {
                                                    viewModel.showVictory()
                                                }
                                                
                                                // Mostrar la descripción de la cultura
                                                viewModel.showMessage(message: culture.description, isCorrect: true)
                                            } else {
                                                // Mensaje de "wrong side"
                                                viewModel.showMessage(message: "Wrong side!", isCorrect: false)
                                                
                                                viewModel.resetCulturePosition(culture.id)
                                            }
                                        } else {
                                            viewModel.resetCulturePosition(culture.id)
                                        }
                                        viewModel.draggedCulture = nil
                                    }
                            )
                    }
                }
                .zIndex(1) // Asegura que los iconos de las culturas estén detrás de las zonas de caída
                
                Spacer()
                
                HStack {
                    DropZone(title: "Allies")
                        .padding()
                        .background(Color.green.opacity(0.7))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .border(Color.white, width: 2)
                        .zIndex(2) // Asegura que la zona de "Allies" esté sobre los iconos de cultura
                    
                    DropZone(title: "Non-Allies")
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .border(Color.white, width: 2)
                        .zIndex(2) // Asegura que la zona de "Non-Allies" esté sobre los iconos de cultura
                }
                
                if let message = viewModel.message {
                    Text(message)
                        .font(.title)
                        .padding()
                        .foregroundColor(viewModel.isCorrectPlacement ? .green : .red)
                        .background(viewModel.isCorrectPlacement ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                        .cornerRadius(10)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.5))
                }
            }
        }
        .onAppear {
            viewModel.randomizeCulturePositions()
        }
    }
}
