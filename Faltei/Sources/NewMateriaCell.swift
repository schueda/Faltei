//
//  NewMateriaCell.swift
//  Faltei
//
//  Created by André Schueda on 24/08/23.
//

import SwiftUI

struct NewMateriaCell: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "plus")
                .foregroundColor(.accentColor)
                .font(.title2)
            Text("Adicionar matéria")
                .foregroundColor(.accentColor)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)   
        .background(Color.accentColor.opacity(0.2))
        .cornerRadius(10)
        .overlay( RoundedRectangle(cornerRadius: 10)
            .strokeBorder(style: .init(lineWidth: 2))
            .foregroundColor(Color.accentColor)
        )
    }
}

struct NewMateriaCell_Previews: PreviewProvider {
    static var previews: some View {
        NewMateriaCell()
    }
}
