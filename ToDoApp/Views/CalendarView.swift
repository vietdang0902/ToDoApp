import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var body: some View {
        VStack {
            // MARK: - Header (Month & Year)
            HStack {
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text(monthYearString(for: currentDate))
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)
            
            // MARK: - Day Symbols (S M T W T F S)
            let symbols = calendar.shortWeekdaySymbols
            HStack {
                ForEach(symbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                }
            }

            // MARK: - Calendar Grid
            let days = generateDaysInMonth(for: currentDate)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(days, id: \.self) { date in
                    Text(dateFormatter.string(from: date))
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(calendar.isDate(date, inSameDayAs: Date()) ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                        .foregroundColor(calendar.isDate(date, equalTo: currentDate, toGranularity: .month) ? .primary : .gray)
                }
            }
            .frame(height: 6*50)
            .padding(.horizontal)
        }
    }
    
    // MARK: - Helpers
    
    func numberOfWeeks(for date: Date) -> Int {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date) else {
            return 6 // fallback
        }
        
        let weeks = calendar.range(of: .weekOfMonth, in: .month, for: date)
        return weeks?.count ?? 6
    }
    
    func monthYearString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }

    func generateDaysInMonth(for date: Date) -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let firstWeekday = calendar.date(from: calendar.dateComponents([.year, .month], from: monthInterval.start)) else {
            return []
        }
        
        var days: [Date] = []
        
        let firstDayWeekday = calendar.component(.weekday, from: firstWeekday)
        let prefixDays = (firstDayWeekday - calendar.firstWeekday + 7) % 7
        
        // Add days from the previous month
        for i in stride(from: prefixDays, to: 0, by: -1) {
            if let previousDay = calendar.date(byAdding: .day, value: -i, to: firstWeekday) {
                days.append(previousDay)
            }
        }

        // Add all days in the current month
        if let range = calendar.range(of: .day, in: .month, for: date) {
            for day in range {
                if let date = calendar.date(bySetting: .day, value: day, of: firstWeekday) {
                    days.append(date)
                }
            }
        }

        // Add trailing days to fill up to exactly 42 days (6 weeks)
        while days.count < 42 {
            if let last = days.last,
               let next = calendar.date(byAdding: .day, value: 1, to: last) {
                days.append(next)
            }
        }

        return days
    }

}
