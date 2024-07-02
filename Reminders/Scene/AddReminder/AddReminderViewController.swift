//
//  AddReminderViewController.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

enum AddReminderSection: CaseIterable {
    case todo
    case dueDate
    case tag
    case priority
    case addImage
    
    var toTitle: String {
        switch self {
        case .todo:
            "할 일"
        case .dueDate:
            "마감일"
        case .tag:
            "태그"
        case .priority:
            "우선 순위"
        case .addImage:
            "이미지 추가"
        }
    }
}

final class AddReminderViewController: BaseViewController {
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
//        table.sectionHeaderTopPadding = 5
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
            buttonAction: #selector(addButtonTapped)
        )
    }
    @objc private func cancelButtonTapped() {
        print("Tapped")
    }
    @objc private func addButtonTapped() {
        print("Tapped")
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
            
            return cell
        case .tag, .addImage, .dueDate, .priority:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddReminderBasicCell.identifier,
                for: indexPath
            ) as? AddReminderBasicCell else { return UITableViewCell() }
            
            cell.configureUI(
                labelTitle: AddReminderSection.allCases[indexPath.section].toTitle
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
}