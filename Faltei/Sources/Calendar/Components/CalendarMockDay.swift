//
//  CalendarMockDay.swift
//  Faltei
//
//  Created by André Schueda on 29/08/23.
//

import SwiftUI

struct CalendarMockDay: View {
    let num: Int
    var body: some View {
        Text("\(num)")
            .font(.footnote)
            .padding(8)
            .frame(width: 40, height: 40)
            .foregroundColor(.init(uiColor: .secondaryLabel))
    }
}

struct CalendarMockDay_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(color: .appBittersweet)
    }
}
