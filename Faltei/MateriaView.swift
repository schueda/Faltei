//
//  MateriaView.swift
//  Faltei
//
//  Created by André Schueda on 24/08/23.
//

import SwiftUI

struct MateriaView: View {
    @State var showingFaltei: Bool = false
    
    let materia: Materia
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("\(materia.faltasCount) faltas de \(materia.maxFaltas)")
                    .font(.headline)
                
                ProgressView(value: Float(materia.faltasCount), total: Float(materia.maxFaltas))
                    .progressViewStyle(FaltasProgressStyle(color: materia.color, strokeWidth: 5))
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            
            CalendarView(color: materia.color, dates: materia.faltas, bottomLimitDate: Calendar.current.date(byAdding: DateComponents(month: -4), to: Date()), topLimitDate: Calendar.current.date(byAdding: DateComponents(month: 0), to: Date())) { content in
                    if let falta = content as? Falta {
                        VStack(alignment: .leading, spacing: 32) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Quantidade de faltas")
                                    .font(.headline)
                                Text("\(falta.quantidade)")
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Motivos")
                                    .font(.headline)
                                
                                if let descr = falta.description {
                                    Text(descr)
                                }
                            }
                            Spacer()
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
            }
            
            Spacer()
            
            DefaultButton(text: "Faltei", color: materia.color) {
                showingFaltei = true
            }
        }
        .padding()
        .navigationTitle(materia.name)
        .navigationBarTitleDisplayMode(.inline)
        .adaptiveSheet(isPresented: $showingFaltei, detents: [.medium()]) {
            FalteiView(showing: $showingFaltei)
        }
    }
}

struct MateriaView_Previews: PreviewProvider {
    static var previews: some View {
        MateriaView(materia: Materia(name: "aksjdhas", maxFaltas: 4, color: .appJade, faltas: [Falta(quantidade: 2, date: Date())]))
    }
}
