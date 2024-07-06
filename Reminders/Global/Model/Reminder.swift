//
//  Reminder.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import Foundation

import RealmSwift

final class Reminder: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var date: Date
    @Persisted var tag: String?
    @Persisted var priority: String
    @Persisted var imageStr: String?
    @Persisted var idDone: Bool
    
    convenience init(
        title: String,
        content: String? = nil,
        date: Date,
        tag: String? = nil,
        priority: String,
        imageStr: String? = nil
    ) {
        self.init()
        self.title = title
        self.content = content
        self.date = date
        self.tag = tag
        self.priority = priority
        self.imageStr = imageStr
        self.idDone = false
    }
}
