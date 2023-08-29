
import Foundation

class CalendarManager: ObservableObject {
    var date = Date()
    @Published var currentMonth: Month
    var markedDates: [Date] = []
    
    init(markedDates: [Date] = []) {
        self.currentMonth = Self.getMonth(from: date, markedDates: markedDates)
    }
    
    func mark(date: Date) {
        guard let i = currentMonth.days.firstIndex(where: {
            Calendar.current.dateComponents([.year, .month, .day], from: $0.date) == Calendar.current.dateComponents([.year, .month, .day], from: date)
        }) else { return }
        
        currentMonth.days[i].marked = true
    }
    
    func goToPreviousMonth() {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: -1), to: date) else { return }
        self.date = date
        self.currentMonth = Self.getMonth(from: date, markedDates: markedDates)
    }
    
    func goToNextMonth() {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: 1), to: date) else { return }
        self.date = date
        self.currentMonth = Self.getMonth(from: date, markedDates: markedDates)
    }
    
    func set(markedDates: [Date]) {
        self.markedDates = markedDates
        self.currentMonth = Self.getMonth(from: date, markedDates: markedDates)
    }
    
    static func getMonth(from date: Date, markedDates: [Date]) -> Month {
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.locale = .current
        
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        
        let name = "\(formatter.monthSymbols[month - 1].capitalized) \(year)"
        
        let firstDayOfMonth = calendar.dateComponents([.calendar, .year, .month], from: date).date!
        let lastDayOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfMonth)!
        
        let days = calendar.range(of: .day, in: .month, for: date)!.map { day in
            let d = calendar.date(byAdding: DateComponents(day: day-1), to: firstDayOfMonth)!
            
            return CalendarDay(date: d, marked: markedDates.contains(where: { markedDate in
                calendar.dateComponents([.year, .month, .day], from: markedDate) == calendar.dateComponents([.year, .month, .day], from: d)
            }))
        }
        
        let startsAt = calendar.component(.weekday, from: firstDayOfMonth)
        let finishesAt = calendar.component(.weekday, from: lastDayOfMonth)
        
        let lastDayOfPastMonth = calendar.date(byAdding: DateComponents(day: -1), to: firstDayOfMonth)!
        let lastDayOfPastMonthNum = calendar.component(.day, from: lastDayOfPastMonth)
        let PastMonthDaysCount = startsAt - 2
        let pastMonthStart = lastDayOfPastMonthNum - PastMonthDaysCount
        
        let pastMonthDays = pastMonthStart..<lastDayOfPastMonthNum + 1
        
        let nextMonthDays = 1..<7-finishesAt + 1
        
        return Month(name: name, days: days, startsAt: startsAt, finishesAt: finishesAt, pastMonthDays: pastMonthDays, nextMonthDays: nextMonthDays)
    }
}

struct Month {
    let name: String
    var days: [CalendarDay]
    let startsAt: Int
    let finishesAt: Int
    
    let pastMonthDays: Range<Int>
    let nextMonthDays: Range<Int>
}

struct CalendarDay: Identifiable {
    let date: Date
    var marked: Bool = false
    
    let id = UUID()
    
    var number: Int {
        Calendar.current.component(.day, from: date)
    }
    
    var today: Bool {
        Calendar.current.dateComponents([.year, .month, .day], from: date) == Calendar.current.dateComponents([.year, .month, .day], from: Date())
    }
}
