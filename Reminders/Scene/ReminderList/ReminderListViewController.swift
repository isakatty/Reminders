//
//  ReminderListViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

import RealmSwift

final class ReminderListViewController: BaseViewController {
    var reminders: Results<Reminder>
    
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
    
    init(reminders: Results<Reminder>) {
        self.reminders = reminders
        
        super.init(viewTitle: ReminderCategory.whole.toString)
    }
    
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
        return reminders.count
    }
    
    func tableView(
        _ taleView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = taleView.dequeueReusableCell(
            withIdentifier: ReminderTableViewCell.identifier,
            for: indexPath
        ) as? ReminderTableViewCell else { return UITableViewCell() }
        
        let reminder = reminders[indexPath.row]
//        cell.backgroundColor = .yellow
        cell.configureUI(title: reminder.title, content: reminder.content, date: reminder.date?.description)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
