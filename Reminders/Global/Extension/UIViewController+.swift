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
}
