
import Foundation

struct PositionedGameObject: Identifiable {
    let id = UUID()
    let position: CGPoint
    let type: GameObjectType
    
    enum GameObjectType {
        case head(ColossalHead)
        case distraction(DistractingObject)
    }
}



