//
//  NewMateriaView.swift
//  Faltei
//
//  Created by André Schueda on 24/08/23.
//

import SwiftUI

struct NewMateriaView: View {
    @Binding var showing: Bool
    
    let colors: [Color] = [.appBittersweet, .appTomato, .appAtomicTangerine, .appSunglow, .appPear, .appYellowGreen, .appJade, .appSteelBlue, .appTrueBlue, .appUltraViolet]
    
    @State var text: String = ""
    @State var maxFaltas: Int = 0
    @State var cor: Color = .appBittersweet
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nome da matéria")
                            .font(.subheadline)
                        TextField("ex: Cálculo 1", text: $text)
                            .padding()
                            .background(Color.init(uiColor: .systemGray6))
                            .cornerRadius(10)
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Máximo de faltas")
                            .font(.subheadline)
                        TextField("", value: $maxFaltas, format: .number)
                            .padding()
                            .background(Color.init(uiColor: .systemGray6))
                            .cornerRadius(10)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cor")
                        .font(.subheadline)
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 5)) {
                        ForEach(colors, id: \.self) { c in
                            Rectangle()
                                .fill(c)
                                .onTapGesture {
                                    withAnimation {
                                        cor = c
                                    }
                                }
                                .overlay {
                                    if cor == c {
                                        Color.black
                                            .opacity(0.3)
                                            .reverseMask {
                                                Image(systemName: "checkmark.circle")
                                                    .font(.title2)
                                                    .bold()
                                            }
                                    }
                                }
                                .cornerRadius(7)
                                .frame(height: 30)
                        }
                        
                    }
                }
                
                Spacer()
                
                DefaultButton(text: "Criar nova matéria", color: cor) {
                    print("criou!")
                }
            }
            .padding()
            .navigationTitle("Nova matéria")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancelar", action: {
                showing = false
            }))
        }
    }
}

struct NewMateriaView_Previews: PreviewProvider {
    static var previews: some View {
        NewMateriaView(showing: .constant(true))
    }
}
