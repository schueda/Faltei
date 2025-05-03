//
//  CalendarHeader.swift
//  Faltei
//
//  Created by André Schueda on 29/08/23.
//

import SwiftUI

struct CalendarHeader: View {
    @EnvironmentObject var manager: CalendarManager
    
    let color: Color
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button {
                    manager.goToPreviousMonth()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(manager.pastMonthAble ? color : .gray)
                        .font(.title3)
                }
                .disabled(!manager.pastMonthAble)
                
                Spacer()
                
                Text(manager.currentMonth.name)
                    .bold()
                
                Spacer()
                
                Button {
                    manager.goToNextMonth()
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(manager.nextMonthAble ? color : .gray)
                        .font(.title3)
                }
                .disabled(!manager.nextMonthAble)
            }
            
            HStack {
                ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { wd in
                    Text(wd)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .foregroundColor(.init(uiColor: .secondaryLabel))
                }
            }
        }
    }
}

struct CalendarHeader_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(color: .red)
    }
}
