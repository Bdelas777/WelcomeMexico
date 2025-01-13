import SwiftUI

struct ContentView: View {
    @State private var showMyPresentation = true 

    var body: some View {
        
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
