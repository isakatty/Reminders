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
        buttonAction: Selector
    ) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: title,
            style: .plain,
            target: self,
            action: buttonAction
        )
    }
}
