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
                
                Text("Time: \(Int(viewModel.timeRemaining)) seconds")
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
                            .shadow(radius: 5)
                            .padding(4)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        viewModel.draggedCulture = culture
                                        let screenHeight = UIScreen.main.bounds.height
                                        let yPosition = min(value.location.y, screenHeight * 0.75)
                                        viewModel.updateCulturePosition(culture.id, position: CGPoint(x: value.location.x, y: yPosition))
                                    }
                                    .onEnded { value in
                                        let dropPoint = value.location
                                        let screenHeight = UIScreen.main.bounds.height
                                        let screenWidth = UIScreen.main.bounds.width
                                        
                                        if dropPoint.y > screenHeight * 0.6 {
                                            let isLeftZone = dropPoint.x < screenWidth / 2
                                            let zoneName = isLeftZone ? "Allies" : "Non-Allies"
                                            
                                            if viewModel.checkPlacement(cultureID: culture.id, location: dropPoint, zoneName: zoneName) {
                                                viewModel.score += 100
                                                if viewModel.score >= 400 {
                                                    viewModel.showVictory()
                                                }
                                                
                                                viewModel.showMessage(message: culture.description, isCorrect: true)
                                            } else {
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
                .zIndex(1)
                
                Spacer()
                
                HStack {
                    DropZone(title: "Allies")
                        .padding()
                        .background(Color.green.opacity(0.7))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .border(Color.white, width: 2)
                        .zIndex(2)
                    
                    DropZone(title: "Non-Allies")
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .border(Color.white, width: 2)
                        .zIndex(2)
                }
                
            }
            
            if let message = viewModel.message {
                VStack {
                    Text(message)
                        .font(.title2)
                        .padding()
                        .foregroundColor(viewModel.isCorrectPlacement ? .green : .red)
                        .background(viewModel.isCorrectPlacement ? Color.white : Color.white)
                        .cornerRadius(12)
                        .padding(.bottom)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 3)
                        )
                    
                    Button(action: {
                        viewModel.message = nil
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .frame(maxWidth: 300)
                .padding(20)
                .zIndex(3)
            }
        }
        .onAppear {
            viewModel.randomizeCulturePositions()
        }
    }
}
