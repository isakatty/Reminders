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
    func updateDoneReminder(_ reminder: Reminder) throws
    // D
    func deleteReminder(_ reminder: Reminder) throws
    func deleteAllReminder() throws
    func sortReminder(keyPath: String) -> [Reminder]
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
    
    func updateDoneReminder(_ reminder: Reminder) throws {
        do {
            try realm.write {
                reminder.isDone.toggle()
            }
        } catch {
            throw RealmError.invalidUpdate
        }
    }
    func updateFlagReminder(_ reminder: Reminder) throws {
        do {
            try realm.write {
                reminder.isFlag.toggle()
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
    
    func sortReminder(keyPath: String) -> [Reminder] {
        let sortedReminder = realm.objects(Reminder.self).sorted(byKeyPath: keyPath)
        return Array(sortedReminder)
    }
    func fetchTodaysReminder() -> [Reminder] {
        let start = Calendar.current.startOfDay(for: Date())
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(
            format: "date >= %@ && date < %@",
            start as NSDate,
            end as NSDate
        )
        let sorted = realm.objects(Reminder.self).filter(predicate)
        
        return Array(sorted)
    }
    func fetchUpcomingReminder() -> [Reminder] {
        let start = Calendar.current.startOfDay(for: Date())
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(
            format: "date < %@ || date >= %@",
            start as NSDate,
            end as NSDate
        )
        let sorted = realm.objects(Reminder.self)
            .filter(predicate)
            .filter { $0.isDone == false }
        
        return Array(sorted)
    }
}
