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
}
