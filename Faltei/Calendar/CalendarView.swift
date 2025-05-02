//
//  Calendar.swift
//  Faltei
//
//  Created by André Schueda on 26/08/23.
//

import SwiftUI

struct CalendarView<Content: View>: View {
    @StateObject var manager = CalendarManager()
    var color: Color = .blue
    var dates: [Timeable]
    var bottomLimitDate: Date?
    var topLimitDate: Date?
    
    let detail: (_ content: Timeable) -> Content
    
    @State var detailsShowing = false
    @State var selectedDay: Day?
    
    init(color: Color, dates: [Timeable] = [], bottomLimitDate: Date? = nil, topLimitDate: Date? = nil, @ViewBuilder detail: @escaping (_ content: Timeable) -> Content) {
        self.color = color
        self.dates = dates
        self.bottomLimitDate = bottomLimitDate
        self.topLimitDate = topLimitDate
        
        self.detail = detail
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            CalendarHeader(color: color)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(manager.currentMonth.pastMonthDays, id: \.self) { d in
                    CalendarMockDay(num: d)
                }
                
                ForEach(manager.currentMonth.days) { d in
                    CalendarDay(day: d, color: color) {
                        if let falta = d.content as? Falta {
                            if falta.quantidade > 0 {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    selectedDay = d
                                    detailsShowing = true
                                }
                            }
                        }
                    }
                }
                
                ForEach(manager.currentMonth.nextMonthDays, id: \.self) { d in
                    CalendarMockDay(num: d)
                }
            }
        }
        .frame(height: 350, alignment: .top)
        .padding()
        .background {
            Color.init(uiColor: .systemGray6)
        }
        .onAppear {
            manager.set(dates: dates)
            manager.set(bottomLimitDate: bottomLimitDate)
            manager.set(topLimitDate: topLimitDate)
            manager.update()
        }
        .overlay {
            if let selectedDay = self.selectedDay {
                DayDetailView($detailsShowing, day: selectedDay, color: color) {
                    detail(selectedDay.content)
                }
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
            }
        }
        .environmentObject(manager)
        .cornerRadius(10)
        .onChange(of: detailsShowing) { showing in
            if !showing {
                withAnimation(.easeInOut(duration: 0.5)) {
                    selectedDay = nil
                }
            }
        }
    }
}

extension CalendarView where Content == EmptyView {
    init(color: Color, dates: [Timeable] = [], bottomLimitDate: Date? = nil, topLimitDate: Date? = nil) {
        self.init(color: color, dates: dates, bottomLimitDate: bottomLimitDate, topLimitDate: topLimitDate, detail: { content in EmptyView() })
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(color: .appBittersweet)
            .padding()
    }
}
