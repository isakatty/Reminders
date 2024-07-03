//
//  AddReminderViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

import RealmSwift

protocol PassDateProtocol: AnyObject {
    func passDate(_ date: Date)
}

final class AddReminderViewController: BaseViewController {
    weak var fetchReminderDelegate: ReminderFetchProtocol?
    
    private var canAdd: Bool = false
    private var newReminder = Reminder(title: "", content: "", date: nil)
    private var changedDate: String = ""
    private lazy var reminderTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.register(
            AddReminderTextFieldTableViewCell.self,
            forCellReuseIdentifier: AddReminderTextFieldTableViewCell.identifier
        )
        table.register(
            AddReminderBasicCell.self,
            forCellReuseIdentifier: AddReminderBasicCell.identifier
        )
        table.sectionHeaderHeight = 0
        table.sectionFooterHeight = 0
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavi()
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
    
    private func configureNavi() {
        navigationItem.largeTitleDisplayMode = .never
        configureNaviLeftButton(
            title: "취소",
            buttonAction: #selector(cancelButtonTapped)
        )
        configureNaviRightButton(
            title: "추가",
            buttonAction: #selector(addButtonTapped),
            enable: canAdd
        )
    }
    @objc private func cancelButtonTapped() {
        print("Tapped")
        dismiss(animated: true)
    }
    @objc private func addButtonTapped() {
        let realm = try! Realm()
        
        try? realm.write({
            realm.add(newReminder)
            print("Realm 저장")
        })
        fetchReminderDelegate?.fetchReminders(with: realm.objects(Reminder.self))
        dismiss(animated: true)
    }
}
extension AddReminderViewController: PassDateProtocol {
    func passDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy.MM.dd EEEE"
        changedDate = dateFormatter.string(from: date)
        
        // 저장은 Date - 보여주는 형태는 변환된 String
        newReminder.date = date
        let indexSet = IndexSet(integer: 1)
        reminderTableView.reloadSections(indexSet, with: .automatic)
    }
}

extension AddReminderViewController
: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return AddReminderSection.allCases.count
    }
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch AddReminderSection.allCases[indexPath.section] {
        case .todo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddReminderTextFieldTableViewCell.identifier,
                for: indexPath
            ) as? AddReminderTextFieldTableViewCell
            else { return UITableViewCell() }
            
            // title
            cell.contentsCallBack = { [weak self] title, content in
                guard let self else { return }
                guard let title = title,
                      !title.isEmpty else { return }
                
                canAdd = !canAdd
                navigationItem.rightBarButtonItem?.isEnabled = canAdd
//                print(title, content)
                newReminder.title = title
                newReminder.content = content
            }
            return cell
        case .tag, .addImage, .dueDate, .priority:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddReminderBasicCell.identifier,
                for: indexPath
            ) as? AddReminderBasicCell else { return UITableViewCell() }
            
            cell.configureUI(
                labelTitle: AddReminderSection.allCases[indexPath.section].toTitle,
                content: changedDate
            )
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch AddReminderSection.allCases[section] {
        case .todo:
            return 20
        default:
            return 10
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch AddReminderSection.allCases[indexPath.section] {
        case .todo:
            return UITableView.automaticDimension
        default:
            return 40
        }
    }
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let section = AddReminderSection.allCases[indexPath.section]
        switch section {
        case .dueDate:
            let vc = AddReminderDateViewController(viewTitle: "마감 날짜")
            vc.dateDelegate = self
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("아직이용")
        }
    }
}
