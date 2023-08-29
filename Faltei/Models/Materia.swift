//
//  Materia.swift
//  Faltei
//
//  Created by André Schueda on 23/08/23.
//

import Foundation
import SwiftUI

struct Materia: Identifiable {
    let name: String
    let maxFaltas: Int
    let color: Color
    let faltas: [Falta]
    
    let id = UUID()
    
    var faltasCount: Int {
        faltas.reduce(0) { $0 + $1.quantidade }
    }
}
