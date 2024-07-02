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
    @Persisted var date: Date?
    @Persisted var idDone: Bool
    
    convenience init(
        id: ObjectId,
        title: String,
        content: String,
        date: Date
    ) {
        self.init()
        
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.idDone = false
    }
}
