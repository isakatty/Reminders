//
//  ReminderRepository.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/5/24.
//

import Foundation

import RealmSwift

enum RealmError: Error {
    case invalidCreate
    case invalidFetch
    case invalidDeleteReminderItem
    case invalidDeleteReminders
    case invalidUpdate
    
}

protocol ReminderRepositoryProtocol {
    // C
    func createReminder(_ reminder: Reminder) throws
    // R
    func fetchReminders() -> [Reminder]
    // U
    func updateReminder(_ reminder: Reminder) throws
    // D
    func deleteReminder(_ reminder: Reminder) throws
    func deleteAllReminder() throws
}

final class ReminderRepository: ReminderRepositoryProtocol {
    
    private let realm = try! Realm()
    
    func createReminder(_ reminder: Reminder) throws {
        do {
            try realm.write {
                realm.add(reminder)
            }
        } catch {
            throw RealmError.invalidCreate
        }
    }
    
    func fetchReminders() -> [Reminder] {
        print(realm.configuration.fileURL, "🔥")
        
        return Array(realm.objects(Reminder.self))
    }
    
    func updateReminder(_ reminder: Reminder) throws {
        do {
            try realm.write {
                reminder.idDone.toggle()
            }
        } catch {
            throw RealmError.invalidUpdate
        }
    }
    
    func deleteReminder(_ reminder: Reminder) throws {
        do {
            try realm.write {
                realm.delete(reminder)
            }
        } catch {
            print("Delete 실패")
            throw RealmError.invalidDeleteReminderItem
        }
    }
    
    func deleteAllReminder() throws {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("realm DB delete Error")
            throw RealmError.invalidDeleteReminders
        }
    }
}
