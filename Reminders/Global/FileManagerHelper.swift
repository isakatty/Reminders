//
//  FileManagerHelper.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/7/24.
//

import UIKit

final class FileManagerHelper {
    static func saveImageToDocument(image: UIImage, filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    static func loadImageToDocument(filename: String) -> UIImage? {
         
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
         
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    static func removeToDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return }
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                print("file remove error", error)
            }
        } else {
            print("file no exist")
        }
    }
}
