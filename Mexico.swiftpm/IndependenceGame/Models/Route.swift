import Foundation

struct Route: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let description: String
    let difficulty: RouteDifficulty
    let type: RouteType
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.id == rhs.id
    }
}
enum RouteDifficulty {
    case safe, dangerous
}

enum RouteType {
    case alliance, escape, tactical
}
