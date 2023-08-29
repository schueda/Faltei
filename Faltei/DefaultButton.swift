//
//  Button.swift
//  Faltei
//
//  Created by André Schueda on 23/08/23.
//

import SwiftUI

struct DefaultButton: View {
    let text: String
    let color: Color?
    let click: () -> Void
    
    init(text: String, color: Color? = nil, click: @escaping () -> Void) {
        self.text = text
        self.color = color
        self.click = click
    }
    
    var body: some View {
        Button {
            click()
        } label: {
            HStack {
                Spacer()
                Text(text)
                    .padding()
                Spacer()
            }
            .background(color ?? Color.accentColor)
            .foregroundColor(.white)
            .bold()
            .cornerRadius(10)
            .padding(.horizontal)
        }

    }
}

struct DefaultButton_Previews: PreviewProvider {
    static var previews: some View {
        DefaultButton(text: "zao", color: .red) {
            print("lalal")
        }
    }
}
