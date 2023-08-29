//
//  FaltasProgressStyle.swift
//  Faltei
//
//  Created by André Schueda on 25/08/23.
//

import SwiftUI

struct FaltasProgressStyle: ProgressViewStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
            let fractionCompleted = configuration.fractionCompleted ?? 0

            return ZStack {
                Rectangle()
                    .stroke(.white, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                Rectangle()
                    .trim(from: 0, to: fractionCompleted)
                    .stroke(color, style: StrokeStyle(lineWidth: 3, lineCap: .round))
            }
        }
}
