//
//  DayDetailView.swift
//  Faltei
//
//  Created by André Schueda on 29/08/23.
//

import SwiftUI

struct DayDetailView<Content: View>: View {
    @Binding var showing: Bool
    let day: Day
    let color: Color
    let content: () -> Content

    init(_ showing: Binding<Bool>, day: Day, color: Color, @ViewBuilder _ content: @escaping () -> Content) {
        self._showing = showing
        self.day = day
        self.color = color
        self.content = content
    }
    
    
    var body: some View {
            VStack {
                HStack(alignment: .center) {
                    Button {
                        showing = false
                    } label: {
                        Image(systemName: "chevron.down")
                            .foregroundColor(color)
                            .font(.title3)
                    }

                    Text(day.formated)
                        .font(.headline)
                    
                    Spacer()
                }
                .padding()
                VStack {
                    content()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.init(uiColor: .systemGray6)
        }
    }
}

extension DayDetailView where Content == EmptyView {
    init(_ showing: Binding<Bool>, day: Day, color: Color) {
        self.init(showing, day: day, color: color, { EmptyView() })
    }
}

struct DayDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(color: .appBittersweet)
    }
}
