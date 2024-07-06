//
//  String+.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/5/24.
//

import Foundation

extension String {
    func addHashTag() -> String {
        var hashTags = [String]()
        hashTags = self.split(separator: " ").map { "#\($0)" }
        hashTags = Array(Set(hashTags))
        return hashTags.joined(separator: " ")
    }
    
    func toPriority() -> Priority {
        switch self {
        case "높음":
            return .primary
        case "중간":
            return .secondary
        case "낮음":
            return .tertiary
        default:
            return .none
        }
    }
}
