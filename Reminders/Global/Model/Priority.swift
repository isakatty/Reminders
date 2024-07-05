//
//  Priority.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/4/24.
//

import UIKit

enum Priority: Int, CaseIterable {
    case primary, secondary, tertiary, none
    
    var toString: String {
        switch self {
        case .primary:
            "높음"
        case .secondary:
            "중간"
        case .tertiary:
            "낮음"
        case .none:
            "없음"
        }
    }
    var toImage: UIImage? {
        switch self {
        case .primary:
            UIImage(systemName: "exclamationmark")
        case .secondary:
            UIImage(systemName: "exclamationmark.2")
        case .tertiary:
            UIImage(systemName: "exclamationmark.3")
        case .none:
            UIImage(systemName: "xmark")
        }
    }
}
