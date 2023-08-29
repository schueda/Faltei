//
//  MateriaView.swift
//  Faltei
//
//  Created by André Schueda on 24/08/23.
//

import SwiftUI

struct MateriaView: View {
    let materia: Materia
    var body: some View {
        VStack {
            ProgressView(value: Float(materia.faltasCount), total: Float(materia.maxFaltas))
                .progressViewStyle(FaltasProgressStyle(color: materia.color, strokeWidth: 5))
            
            CalendarView(color: materia.color, markedDates: materia.faltas.map({ f in
                f.date
            }))
            
            Spacer()
            
            DefaultButton(text: "Faltei", color: materia.color) {
                print("aaaa")
            }
        }
        .padding(.horizontal)
        .navigationTitle(materia.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MateriaView_Previews: PreviewProvider {
    static var previews: some View {
        MateriaView(materia: Materia(name: "aksjdhas", maxFaltas: 4, color: .brown, faltas: [Falta(quantidade: 2, date: Date())]))
    }
}
