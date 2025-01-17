//
//  ReminderListViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/3/24.
//

import UIKit

protocol ReminderFinishedProtocol: AnyObject {
    func finishedReminder(_ isDone: Bool, index: Int)
    func fetchReminder(index: Int)
}

final class ReminderListViewController: BaseViewController {
    var reminders: [Reminder]
    var viewType: ReminderCategory
    
    let repository = ReminderRepository()
    
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
    
    init(reminders: [Reminder], viewType: ReminderCategory) {
        self.reminders = reminders
        self.viewType = viewType
        super.init(viewTitle: viewType.toString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: viewType.categoryColor.cgColor]
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

extension ReminderListViewController: ReminderFinishedProtocol {
    func fetchReminder(index: Int) {
        reminderTableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
    }
    
    func finishedReminder(_ isDone: Bool, index: Int) {
        print(isDone, index, #function)
        do {
            try repository.updateDoneReminder(reminders[index])
        } catch {
            print("업데이트 실패")
        }
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
        cell.configureUI(
            btnTag: indexPath.row,
            priority: reminder.priority,
            title: reminder.title,
            content: reminder.content,
            date: reminder.date,
            tag: reminder.tag?.addHashTag(),
            isDone: reminder.isDone
        )
        cell.reminderDelegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let flag = UIContextualAction(style: .normal, title: "Flag") { [weak self] _, _, success in
            guard let self else { return }
            success(true)
            do {
                try repository.updateFlagReminder(reminders[indexPath.row])
            } catch {
                print("Flag 업데이트 실패")
                success(false)
            }
        }
        flag.image = UIImage(systemName: "flag")
        flag.backgroundColor = UIColor.orange
        
        let delete = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, success in
            guard let self else { return }
            do {
                FileManagerHelper.removeToDocument(filename: "\(reminders[indexPath.row].id)")
                try repository.deleteReminder(reminders[indexPath.row])
                reminders.remove(at: indexPath.row)
                success(true)
                tableView.reloadData()
            } catch {
                print("Delete 실패")
                success(false)
            }
        }
        delete.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [delete, flag])
    }
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let vc = ReminderListDetailViewController(reminder: reminders[indexPath.row], index: indexPath.row)
        vc.finishedDelegate = self
        let navi = UINavigationController(rootViewController: vc)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        present(navi, animated: true)
    }
}
