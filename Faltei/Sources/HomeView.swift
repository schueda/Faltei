//
//  ContentView.swift
//  Faltei
//
//  Created by André Schueda on 23/08/23.
//

import SwiftUI

struct HomeView: View {
    let periodo: Periodo? = Periodo(name: "2021/1", startDate: Date(), endDate: Date(), materias: [Materia(name: "Introdução a Computação Científica", maxFaltas: 14, color: .blue, faltas: []), Materia(name: "Calculo2", maxFaltas: 14, color: .yellow, faltas: [
            Falta(quantidade: 2, description: "Tava com muita dor de cabeça", date: Calendar.current.date(byAdding: DateComponents(day: -10), to:  Date())!),
            Falta(quantidade: 2, description: "Tava com muita dor de cabeça", date: Calendar.current.date(byAdding: DateComponents(day: -40), to:  Date())!),
            Falta(quantidade: 2, description: "Tava com muita dor de cabeça", date: Calendar.current.date(byAdding: DateComponents(day: -60), to: Date())!),
            Falta(quantidade: 2, description: "Tava com muita dor de cabeça", date: Calendar.current.date(byAdding: DateComponents(day: -2), to: Date())!),
                 ])])
    
    @State var showNewMateria = false
    
//    init(periodo: Periodo? = nil) {
//        self.periodo = periodo
//    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                if let materias = periodo?.materias {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            Text("Faltam X dias pras férias")
                                .font(.headline)
                            
                            LazyVStack(spacing: 16) {
                                ForEach(materias) { materia in
                                    NavigationLink {
                                        MateriaView(materia: materia)
                                    } label: {
                                        MateriaCell(materia: materia)
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                }
                                Button {
                                    self.showNewMateria = true
                                } label: {
                                    NewMateriaCell()
                                }

                            }
                            .padding(.bottom, 16)
                        }
                        .padding(.top, 48)
                    }
                    .padding(.horizontal)
                } else {
                    
                }
                
                
            }
            .navigationTitle(periodo?.name ?? "Sem período atual")
            .navigationBarItems(trailing: Button("Editar", action: {}))
            .adaptiveSheet(isPresented: $showNewMateria, detents: [.medium()]) {
                NewMateriaView(showing: $showNewMateria)
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(periodo: Periodo(name: "2021/1", startDate: Date(), endDate: Date(), materias: [Materia(name: "Introdução a Computação Científica", maxFaltas: 14, color: .blue, faltas: []), Materia(name: "Calculo2", maxFaltas: 14, color: .yellow, faltas: []), Materia(name: "Introdução a Computação Científica", maxFaltas: 14, color: .red, faltas: []), Materia(name: "Introdução a Computação Científica", maxFaltas: 14, color: .green, faltas: [Falta(quantidade: 10, date: Date())]), Materia(name: "Introdução a Computação Científica", maxFaltas: 14, color: .blue, faltas: []), Materia(name: "Calculo2", maxFaltas: 14, color: .yellow, faltas: []), Materia(name: "Calculo2", maxFaltas: 14, color: .yellow, faltas: []), Materia(name: "Calculo2", maxFaltas: 14, color: .yellow, faltas: []), Materia(name: "Introdução a Computação Científica", maxFaltas: 14, color: .red, faltas: []), Materia(name: "Introdução a Computação Científica", maxFaltas: 14, color: .green, faltas: [Falta(quantidade: 10, date: Date())])]))
//    }
//}
