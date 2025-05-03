//
//  FaltasProgressStyle.swift
//  Faltei
//
//  Created by André Schueda on 25/08/23.
//

import SwiftUI

struct FaltasProgressStyle: ProgressViewStyle {
    let color: Color
    let strokeWidth: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
            let fractionCompleted = configuration.fractionCompleted ?? 0

            return ZStack {
                GeometryReader { g in
                    Path { p in
                        p.move(to: CGPoint(x: g.frame(in: .local).minX, y: g.frame(in: .local).midY))
                        p.addLine(to: CGPoint(x: g.frame(in: .local).maxX, y: g.frame(in: .local).midY))
                    }
                    .stroke(.white, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                    Path { p in
                        p.move(to: CGPoint(x: g.frame(in: .local).minX, y: g.frame(in: .local).midY))
                        p.addLine(to: CGPoint(x: g.frame(in: .local).maxX, y: g.frame(in: .local).midY))
                    }
                    .trim(from: 0, to: fractionCompleted)
                    .stroke(color, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                }
                .frame(maxHeight: strokeWidth)
            }
    }
}
