//
//  CalendarDay.swift
//  Faltei
//
//  Created by André Schueda on 29/08/23.
//

import SwiftUI

struct CalendarDay: View {
    let day: Day
    let color: Color
    let action: () -> Void
    var body: some View {
        Text("\(day.number)")
            .fontWeight(day.isToday ? .bold : .regular)
            .padding(8)
            .frame(width: 40, height: 40)
            .background {
                if let falta = day.content as? Falta{
                    if falta.quantidade > 0 {
                        Circle()
                            .fill(color)                        
                    }
                }
            }
            .onTapGesture {
                action()
            }
    }
}

struct CalendarDay_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(color: .appBittersweet)
    }
}
