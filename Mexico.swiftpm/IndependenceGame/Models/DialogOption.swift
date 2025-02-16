import Foundation


struct Question {
    let text: String
    let options: [DialogOption]
}

struct DialogOption: Identifiable {
    let id = UUID()
    let text: String
    let nextQuestion: Int
}
