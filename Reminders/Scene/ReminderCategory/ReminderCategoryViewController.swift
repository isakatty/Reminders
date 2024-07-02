//
//  ReminderCategoryViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

import SnapKit

final class ReminderCategoryViewController: BaseViewController {

    private lazy var tempButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("임시 버튼", for: .normal)
        btn.backgroundColor = .systemPink
        btn.addTarget(self, action: #selector(tempTapped), for: .touchUpInside)
        return btn
    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    override func configureHierarchy() {
        navigationItem.leftBarButtonItem = .init(
            title: "새로운 할 일",
            image: UIImage(systemName: "plus.circle.fill"),
            target: self,
            action: #selector(addReminderTapped)
        )
        view.addSubview(tempButton)
    }
    override func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        tempButton.snp.makeConstraints { make in
            make.center.equalTo(safeArea)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        super.configureLayout()
    }

    @objc private func addReminderTapped() {
        print("하이루")
        let vc = AddReminderViewController(viewTitle: "새로운 할 일")
        let navi = UINavigationController(rootViewController: vc)
        navigationController?.present(navi, animated: true)
    }
    @objc private func tempTapped() {
        let vc = ReminderListViewController(viewTitle: ReminderCategory.whole.toString)
        navigationController?.pushViewController(vc, animated: true)
    }
}

