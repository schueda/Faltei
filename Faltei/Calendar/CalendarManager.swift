
import Foundation

protocol Timeable {
    var date: Date { get }
}

class CalendarManager: ObservableObject {
    var bottomLimit: Date?
    var topLimit: Date?
    
    var date = Date()
    
    @Published var pastMonthAble: Bool = true
    
    @Published var nextMonthAble: Bool = true
    
    @Published var currentMonth: Month
    var dates: [Timeable] = []
    
    init(dates: [Timeable] = []) {
        self.currentMonth = Self.getMonth(from: date, dates: dates)
    }
    
    private func checkPastMonthAble() {
        guard let limit = bottomLimit else { return }
        
        let currentMonth = Calendar.current.component(.month, from: date)
        let limitMonth = Calendar.current.component(.month, from: limit)
        
        pastMonthAble = currentMonth > limitMonth
    }
    
    private func checkNextMonthAble() {
        guard let limit = topLimit else { return }
        
        let currentMonth = Calendar.current.component(.month, from: date)
        let limitMonth = Calendar.current.component(.month, from: limit)
        
        nextMonthAble = currentMonth < limitMonth
    }
    
    func goToPreviousMonth() {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: -1), to: date) else { return }
        self.date = date
        self.currentMonth = Self.getMonth(from: date, dates: dates)
        
        checkPastMonthAble()
        nextMonthAble = true
    }
    
    func goToNextMonth() {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: 1), to: date) else { return }
        self.date = date
        self.currentMonth = Self.getMonth(from: date, dates: dates)
        
        checkNextMonthAble()
        pastMonthAble = true
    }
    
    func set(dates: [Timeable]) {
        self.dates = dates
    }
    
    func set(bottomLimitDate: Date?) {
        bottomLimit = bottomLimitDate
        
        checkPastMonthAble()
    }
    
    func set(topLimitDate: Date?) {
        topLimit = topLimitDate
        
        checkNextMonthAble()
    }
    
    func update() {
        self.currentMonth = Self.getMonth(from: date, dates: dates)
    }
    
    static func getMonth(from date: Date, dates: [Timeable]) -> Month {
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
            
            return Day(content: dates.first(where: { calendar.dateComponents([.year, .month, .day], from: $0.date) == calendar.dateComponents([.year, .month, .day], from: d) }) ?? Falta(quantidade: 0, date: d))
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
    var days: [Day]
    let startsAt: Int
    let finishesAt: Int
    
    let pastMonthDays: Range<Int>
    let nextMonthDays: Range<Int>
}

struct Day: Identifiable {
    let content: Timeable
    
    let id = UUID()
    
    var number: Int {
        Calendar.current.component(.day, from: content.date)
    }
    
    var isToday: Bool {
        Calendar.current.dateComponents([.year, .month, .day], from: content.date) == Calendar.current.dateComponents([.year, .month, .day], from: Date())
    }
    
    var formated: String {
        let day = Calendar.current.component(.day, from: content.date)
        let month = Calendar.current.component(.month, from: content.date)
        let year = Calendar.current.component(.year, from: content.date)
        let formatter = DateFormatter()
        return "\(day) \(formatter.monthSymbols[month - 1].capitalized) \(year)"
    }
}
