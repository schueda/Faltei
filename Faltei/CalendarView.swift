//
//  Calendar.swift
//  Faltei
//
//  Created by André Schueda on 26/08/23.
//

import SwiftUI

struct CalendarView: View {
    var color: Color
    var date = Date()
    let weekDays = ["dom", "seg", "ter", "qua", "qui", "sex", "sab"]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Button {
                    print("aaa")
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(color)
                }
                
                Text("Julho de 2023")
                    .bold()

                Button {
                    print("aaa")
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(color)
                }
            }
            
            HStack {
                ForEach(weekDays, id: \.self) { wd in
                    Text(wd)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.init(uiColor: .secondaryLabel))
                }
            }
            
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                Text("1")
            }
        }
    }
    
    func getCurrentMonth() -> Month {
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.locale = .current
        
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let days = calendar.range(of: .day, in: .month, for: date)?.count
        
        let name = "\(formatter.monthSymbols[month - 1]) \(year)"
        
        
        let firstDayOfMonth = calendar.dateComponents([.calendar, .year, .month], from: date).date!
        
        let startsAt = calendar.component(.weekday, from: firstDayOfMonth)
    }
}

struct Month {
    let name: String
    let days: Int
    let startsAt: Int
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar(color: Color.red)
    }
}
