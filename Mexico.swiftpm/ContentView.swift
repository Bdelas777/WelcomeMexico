import SwiftUI

struct ContentView: View {
    @State private var showMyPresentation = true // Controla si se muestra la introducción
    
    var body: some View {
        Group {
            if showMyPresentation {
                MyPresentationView(onDismiss: {
                    withAnimation {
                        showMyPresentation = false
                    }
                })
            } else {
                EraSelectionView()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
