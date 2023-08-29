//
//  Calendar.swift
//  Faltei
//
//  Created by André Schueda on 26/08/23.
//

import SwiftUI

struct CalendarView: View {
    @StateObject var manager = CalendarManager()
    var color: Color = .blue
    var markedDates: [Date]
    
    init(color: Color, markedDates: [Date] = []) {
        self.color = color
        self.markedDates = markedDates
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            header()
            weekDays()
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(manager.currentMonth.pastMonthDays, id: \.self) { d in
                    Text("\(d)")
                        .padding(8)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.init(uiColor: .secondaryLabel))
                }
                ForEach(manager.currentMonth.days) { d in
                    Text("\(d.number)")
                        .bold(d.today)
                        .padding(8)
                        .onTapGesture {
                            manager.mark(date: d.date)
                        }
                        .frame(width: 40, height: 40)
                        .background {
                            if d.marked {
                                Circle()
                                    .fill(color)
                            }
                        }
                }
                ForEach(manager.currentMonth.nextMonthDays, id: \.self) { d in
                    Text("\(d)")
                        .padding(8)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.init(uiColor: .secondaryLabel))
                }
            }
        }
        .frame(height: 350, alignment: .top)
        .padding()
        .background {
            Color.init(uiColor: .systemGray6)
        }
        .cornerRadius(10)
        .onAppear {
            manager.set(markedDates: markedDates)
        }
    }
    
    func header() -> some View {
        HStack {
            Button {
                manager.goToPreviousMonth()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(color)
                    .font(.title3)
            }
            
            Spacer()
            
            Text(manager.currentMonth.name)
                .bold()
            
            Spacer()

            Button {
                manager.goToNextMonth()
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(color)
                    .font(.title3)
            }
        }
    }
    
    func weekDays() -> some View {
        HStack {
            ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { wd in
                Text(wd)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.init(uiColor: .secondaryLabel))
            }
        }
    }
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(color: .appBittersweet)
            .padding()
    }
}
