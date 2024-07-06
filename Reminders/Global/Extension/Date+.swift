//
//  Date+.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/6/24.
//

import Foundation

extension Date {
    func changeDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy.MM.dd EEEE"
        
        return dateFormatter.string(from: self)
    }
}
