//
//  ReminderCategory.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

enum ReminderCategory: CaseIterable {
    case today
    case upComing
    case whole
    case flag
    case completed
    
    var toString: String {
        switch self {
        case .today:
            "오늘"
        case .upComing:
            "예정"
        case .whole:
            "전체"
        case .flag:
            "깃발"
        case .completed:
            "완료됨"
        }
    }
    
    var categoryImgStr: String {
        switch self {
        case .today, .upComing:
            "calendar"
        case .whole:
            "tray"
        case .flag:
            "flag"
        case .completed:
            "checkmark"
        }
    }
    var categoryColor: UIColor {
        switch self {
        case .today:
            UIColor.systemBlue
        case .upComing:
            UIColor.systemRed
        case .whole:
            UIColor.systemGray2
        case .flag:
            UIColor.systemOrange
        case .completed:
            UIColor.systemGray
        }
    }
    
    var sortedReminder: [Reminder] {
        switch self {
        case .today:
            let sorted = ReminderRepository().fetchTodaysReminder()
            return sorted
        case .upComing:
            return ReminderRepository().fetchUpcomingReminder()
        case .whole:
            return ReminderRepository().fetchReminders()
        case .flag:
            return ReminderRepository().sortReminder(keyPath: "priority")
        case .completed:
            let sorted = ReminderRepository().sortReminder(keyPath: "idDone")
                                .filter { reminder in
                                    reminder.idDone == true
                                }
            return sorted
        }
    }
}
