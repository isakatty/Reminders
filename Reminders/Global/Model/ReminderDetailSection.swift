//
//  ReminderDetailSection.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/7/24.
//

import Foundation

enum ReminderDetailSection: CaseIterable {
    case titleSection
    case photoSection
    case contentSection
    case tagSection
    case dateSection
    case flagSection
    case prioritySection
    
    var toString: String {
        switch self {
        case .titleSection:
            "제목"
        case .photoSection:
            "사진"
        case .contentSection:
            "메모"
        case .tagSection:
            "태그"
        case .dateSection:
            "날짜"
        case .flagSection:
            "깃발"
        case .prioritySection:
            "우선 순위"
        }
    }
}
