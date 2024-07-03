//
//  AddReminderSection.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import Foundation

enum AddReminderSection: CaseIterable {
    case todo
    case dueDate
    case tag
    case priority
    case addImage
    
    var toTitle: String {
        switch self {
        case .todo:
            "할 일"
        case .dueDate:
            "마감일"
        case .tag:
            "태그"
        case .priority:
            "우선 순위"
        case .addImage:
            "이미지 추가"
        }
    }
}
