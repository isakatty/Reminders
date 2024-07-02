//
//  ReminderCategoryViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

import SnapKit

final class ReminderCategoryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("load 완")
        // Do any additional setup after loading the view.
        configureHierarchy()
        configureLayout()
    }
    
    override func configureHierarchy() {
        navigationItem.leftBarButtonItem = .init(
            title: "새로운 할 일",
            image: UIImage(systemName: "plus.circle.fill"),
            target: self,
            action: #selector(addReminderTapped)
        )
    }

    @objc private func addReminderTapped() {
        print("하이루")
        let vc = AddReminderViewController(viewTitle: "새로운 할 일")
        let navi = UINavigationController(rootViewController: vc)
        navigationController?.present(navi, animated: true)
    }
}

