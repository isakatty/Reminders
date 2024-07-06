//
//  UIViewController+.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

extension UIViewController {
    func configureTitle(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureNaviLeftButton(
        title: String,
        buttonAction: Selector
    ) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: title,
            style: .plain,
            target: self,
            action: buttonAction
        )
    }
    func configureNaviRightButton(
        title: String,
        buttonAction: Selector,
        enable: Bool
    ) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: title,
            style: .plain,
            target: self,
            action: buttonAction
        )
        navigationItem.rightBarButtonItem?.isEnabled = enable
    }
    func showAlert(
        title: String,
        message: String,
        ok: String,
        handler: @escaping (() -> Void)
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: ok, style: .default) { _ in
            handler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func configureBackNavi(action: Selector?) {
        if let action {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: action)
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBtnTapped))
        }
        navigationController?
            .interactivePopGestureRecognizer?.delegate = nil
    }
    @objc func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func saveImageToDocument(image: UIImage, filename: String) {
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
    func loadImageToDocument(filename: String) -> UIImage? {
         
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
    func removeToDocument(filename: String) {
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
