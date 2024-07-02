//
//  ReminderListViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

final class ReminderListViewController: BaseViewController {
    private lazy var reminderTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(
            ReminderTableViewCell.self,
            forCellReuseIdentifier: ReminderTableViewCell.identifier
        )
        table.rowHeight = 60
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(reminderTableView)
    }
    override func configureLayout() {
        super.configureLayout()
        let safeArea = view.safeAreaLayoutGuide
        reminderTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    override func configureView() {
        
    }
}

extension ReminderListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        1
    }
    
    func tableView(
        _ taleView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = taleView.dequeueReusableCell(
            withIdentifier: ReminderTableViewCell.identifier,
            for: indexPath
        ) as? ReminderTableViewCell else { return UITableViewCell() }
        
//        cell.backgroundColor = .yellow
        cell.configureUI(title: "임시", content: "어쩌고 저쩌고", date: "위치만 일단")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
