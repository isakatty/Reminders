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
        case .today:
            ""
        case .upComing:
            ""
        case .whole:
            ""
        case .flag:
            ""
        case .completed:
            ""
        }
    }
}
