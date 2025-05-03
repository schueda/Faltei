//
//  MateriaCell.swift
//  Faltei
//
//  Created by André Schueda on 23/08/23.
//

import SwiftUI

struct MateriaCell: View {
    let materia: Materia
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text(materia.name)
                .font(.headline)
                .lineLimit(1)
            VStack(alignment: .leading, spacing: 8) {
                Text("\(materia.faltasCount)/\(materia.maxFaltas) faltas")
                    .font(.footnote)
                    .bold()
                ProgressView(value: Float(materia.faltasCount), total: Float(materia.maxFaltas))
                    .progressViewStyle(FaltasProgressStyle(color: materia.color, strokeWidth: 5))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(materia.color.opacity(0.2))
        .cornerRadius(10)
        .overlay( RoundedRectangle(cornerRadius: 10)
            .strokeBorder(style: .init(lineWidth: 2))
            .foregroundColor(materia.color)
        )
    }
}

struct MateriaCell_Previews: PreviewProvider {
    static var previews: some View {
        MateriaCell(materia: Materia(name: "Introdução a Computação Científica", maxFaltas: 14, color: .red, faltas: [Falta(quantidade: 10, date: Date())]))
    }
}
