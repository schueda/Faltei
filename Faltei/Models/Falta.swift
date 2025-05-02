//
//  Falta.swift
//  Faltei
//
//  Created by André Schueda on 23/08/23.
//

import Foundation

struct Falta: Identifiable, Timeable {
    let quantidade: Int
    var description: String? = nil
    var date: Date
    
    let id = UUID()
}


