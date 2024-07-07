//
//  ReminderListDetailViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/7/24.
//

import UIKit

final class ReminderListDetailViewController: BaseViewController {
    var reminder: Reminder
    private var naviEnable: Bool = false
    private lazy var detailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReminderDetailTitleCell.self, forCellReuseIdentifier: ReminderDetailTitleCell.identifier)
        tableView.register(ReminderDetailContentCell.self, forCellReuseIdentifier: ReminderDetailContentCell.identifier)
        tableView.register(ReminderDetailFlagCell.self, forCellReuseIdentifier: ReminderDetailFlagCell.identifier)
        tableView.register(AddReminderBasicCell.self, forCellReuseIdentifier: AddReminderBasicCell.identifier)
        return tableView
    }()
    
    init(reminder: Reminder) {
        self.reminder = reminder
        
        super.init(viewTitle: "세부사항")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackNavi(action: #selector(leftBtnTapped))
        configureNaviRightButton(title: "저장", buttonAction: #selector(rightBtnTapped), enable: naviEnable)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func configureHierarchy() {
        view.addSubview(detailTableView)
    }
    override func configureLayout() {
        super.configureLayout()
        let safeArea = view.safeAreaLayoutGuide
        
        detailTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    @objc private func leftBtnTapped() {
        // TODO: dismiss되기전에 기존 값이랑 비교해서 변한 값이 하나라도 있으면 Alert띄우는 방식
        dismiss(animated: true)
    }
    @objc private func rightBtnTapped() {
        print("save & dismiss", #function)
    }
}
extension ReminderListDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ReminderDetailSection.allCases.count
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
        let section = ReminderDetailSection.allCases[indexPath.section]
        
        switch section {
        case .titleSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderDetailTitleCell.identifier, for: indexPath) as? ReminderDetailTitleCell else { return UITableViewCell () }
            cell.configureUI(text: reminder.title)
            return cell
        case .contentSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderDetailContentCell.identifier, for: indexPath) as? ReminderDetailContentCell else { return UITableViewCell () }
            cell.configureUI(content: reminder.content)
            return cell
        case .flagSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderDetailFlagCell.identifier, for: indexPath) as? ReminderDetailFlagCell else { return UITableViewCell () }
            cell.configureUI(isFlagged: reminder.isFlag)
            return cell
        case .tagSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderBasicCell.identifier, for: indexPath) as? AddReminderBasicCell else { return UITableViewCell () }
            cell.configureUI(labelTitle: section.toString, content: reminder.tag?.addHashTag())
            return cell
        case .dateSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderBasicCell.identifier, for: indexPath) as? AddReminderBasicCell else { return UITableViewCell () }
            cell.configureUI(labelTitle: section.toString, content: reminder.date.changeDateFormat())
            return cell
        case .prioritySection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderBasicCell.identifier, for: indexPath) as? AddReminderBasicCell else { return UITableViewCell () }
            cell.configureUI(labelTitle: section.toString, content: reminder.priority)
            return cell
        case .photoSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderBasicCell.identifier, for: indexPath) as? AddReminderBasicCell else { return UITableViewCell () }
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath.section, ReminderDetailSection.allCases[indexPath.section])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = ReminderDetailSection.allCases[indexPath.section]
        switch section {
        case .photoSection:
            return UITableView.automaticDimension
        case .contentSection:
            return 120
        default:
            return 40
        }
    }
}
