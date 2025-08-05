//
//  FalteiView.swift
//  Faltei
//
//  Created by André Schueda on 01/09/23.
//

import SwiftUI

struct FalteiView: View {
  @Binding var showing: Bool

  var body: some View {
    NavigationView {
      VStack {

      }
      .navigationTitle("Faltei")
      .navigationBarItems(
        leading: Button(
          "Cancelar",
          action: {
            showing = false
          }))
    }
  }
}

struct FalteiView_Previews: PreviewProvider {
  static var previews: some View {
    MateriaView(
      materia: Materia(
        name: "Engenharia de Software", maxFaltas: 14, color: .appAtomicTangerine,
        faltas: [
          Falta(
            quantidade: 5,
            date: Calendar.current.date(byAdding: DateComponents(day: -3), to: Date())!)
        ]))
  }
}
