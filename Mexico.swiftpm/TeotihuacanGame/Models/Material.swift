
import Foundation

struct Material: Identifiable {
    let id = UUID()
    let nombre: String
    let descripcion: String
    let esCorrectoParaPiramide: Bool
}
