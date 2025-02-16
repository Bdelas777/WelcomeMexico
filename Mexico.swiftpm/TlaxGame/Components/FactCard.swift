
import SwiftUI

struct FactCard: View {
    let text: String
    
    var body: some View {
        Text(text)
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
    }
}
