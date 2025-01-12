//
//  File.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import Foundation

struct Route: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let difficulty: RouteDifficulty
    let type: RouteType
}


enum RouteDifficulty {
    case safe, dangerous
}

enum RouteType {
    case alliance, escape, tactical
}
